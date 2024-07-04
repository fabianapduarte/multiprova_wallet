import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:multiprova_wallet/enums/currency.dart';
import 'package:multiprova_wallet/enums/navigation_bar_actions.dart';
import 'package:multiprova_wallet/models/w3m_service.dart';
import 'package:multiprova_wallet/screens/home.dart';
import 'package:multiprova_wallet/utils/colors.dart';
import 'package:multiprova_wallet/widgets/button.dart';
import 'package:multiprova_wallet/widgets/card_outlined.dart';
import 'package:multiprova_wallet/widgets/container_icon.dart';
import 'package:multiprova_wallet/widgets/display.dart';
import 'package:multiprova_wallet/widgets/modal.dart';
import 'package:multiprova_wallet/widgets/snackbar.dart';
import 'package:provider/provider.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';
import 'package:http/http.dart';

class Send extends StatefulWidget {
  const Send({super.key});

  @override
  State<Send> createState() => _SendState();
}

class _SendState extends State<Send> {
  Currency currencySelected = Currency.multiprovaCoin;
  final _valueController = TextEditingController(text: '0');
  final _addressController = TextEditingController();
  late ContractEvent transferMuCoinEvent;
  late ContractEvent transferMuTKEvent;
  late DeployedContract deployedContractMuCoin;
  late DeployedContract deployedContractMuTK;
  late Web3Client ethClient;

  @override
  void initState() {
    super.initState();
    initContracts();
  }

  @override
  void dispose() {
    _valueController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> initContracts() async {
    try {
      final jsonABIMuCoin =
          await rootBundle.loadString('assets/multiprova_coinABI.json');
      final jsonABIMuTK =
          await rootBundle.loadString('assets/multiprova_tokenABI.json');

      deployedContractMuCoin = DeployedContract(
        ContractAbi.fromJson(
          jsonABIMuCoin, // ABI object
          'MultiprovaCoin',
        ),
        EthereumAddress.fromHex(addressMultiprovaCoin),
      );

      deployedContractMuTK = DeployedContract(
        ContractAbi.fromJson(
          jsonABIMuTK, // ABI object
          'MultiprovaToken',
        ),
        EthereumAddress.fromHex(addressMultiprovaToken),
      );

      transferMuCoinEvent = deployedContractMuCoin.event('Transfer');
      transferMuTKEvent = deployedContractMuTK.event('Transfer');
    } catch (e) {
      print("Erro no initContracts: " + e.toString());
    }
  }

  void listenToMuCoinTransferExecuted() {
    final filter = FilterOptions.events(
      contract: deployedContractMuCoin,
      event: transferMuCoinEvent,
    );
    ethClient.events(filter).listen((event) {
      ScaffoldMessenger.of(context).showSnackBar(
          Snackbar(text: 'Tokens enviados com sucesso').build(context));
    });
  }

  void listenToMuTKTransferExecuted() {
    final filter = FilterOptions.events(
      contract: deployedContractMuTK,
      event: transferMuTKEvent,
    );
    ethClient.events(filter).listen((event) {
      ScaffoldMessenger.of(context).showSnackBar(
          Snackbar(text: 'Tokens enviados com sucesso').build(context));
    });
  }

  Future<void> sendTokens(int outputToSend) async {
    try {
      var w3mService =
          Provider.of<W3mServiceModel>(context, listen: false).w3mService;

      final Client httpClient = Client();
      var walletWaddress = w3mService.session!.address!;
      ethClient = Web3Client(rpcUrl, httpClient);
      w3mService.launchConnectedWallet();
      if (currencySelected == Currency.multiprovaCoin) {
        await w3mService.requestWriteContract(
            topic: w3mService.session!.topic!,
            chainId: w3mService.selectedChain!.namespace,
            deployedContract: currencySelected == Currency.multiprovaCoin
                ? deployedContractMuCoin
                : deployedContractMuTK,
            functionName: 'transfer',
            rpcUrl: rpcUrl,
            transaction: Transaction(
              from: EthereumAddress.fromHex(walletWaddress),
            ),
            parameters: [
              EthereumAddress.fromHex(_addressController.text),
              BigInt.from(outputToSend)
            ]);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> onClickSend() async {
    NumberFormat formatter = NumberFormat.decimalPatternDigits(locale: 'pt_BR');
    int tokenValue = formatter.parse(_valueController.text).toInt();

    Navigator.pop(context);
    await sendTokens(tokenValue);
    listenToMuCoinTransferExecuted();
    listenToMuTKTransferExecuted();
  }

  @override
  Widget build(BuildContext context) {
    String currencySelectedName = currencySelected.name;

    return Display(
      title: Text('Enviar', style: Theme.of(context).textTheme.titleLarge),
      body: Column(
        children: <Widget>[
          CardOutlined(
            body: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ContainerIcon(padding: 8.0, icon: Icons.paid),
                    Padding(
                      padding: EdgeInsets.only(left: 12.0),
                      child: Text(currencySelectedName,
                          style: Theme.of(context).textTheme.bodyMedium),
                    ),
                    MenuAnchor(
                      builder: (BuildContext context, MenuController controller,
                          Widget? child) {
                        return IconButton(
                          onPressed: () {
                            if (controller.isOpen) {
                              controller.close();
                            } else {
                              controller.open();
                            }
                          },
                          icon: const Icon(Icons.keyboard_arrow_down_outlined),
                          tooltip: 'Selecionar moeda',
                        );
                      },
                      menuChildren: List<MenuItemButton>.generate(
                        2,
                        (int index) => MenuItemButton(
                          onPressed: () => setState(
                              () => currencySelected = Currency.values[index]),
                          child: Text(Currency.values[index].name),
                        ),
                      ),
                    ),
                    Spacer(),
                    SizedBox(
                      width: 80,
                      child: TextField(
                        controller: _valueController,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.only(bottom: 8.0, top: 0.0),
                        ),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall,
                        maxLines: 1,
                        keyboardType: TextInputType.numberWithOptions(
                            decimal: true, signed: false),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[0-9]+[,]{0,1}[0-9]*')),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 12.0),
                        child: ContainerIcon(
                            padding: 8.0, icon: Icons.link_rounded),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _addressController,
                          decoration: InputDecoration(
                            labelText: 'Endereço',
                            labelStyle: Theme.of(context).textTheme.bodyMedium,
                            contentPadding:
                                EdgeInsets.only(bottom: 8.0, top: 0),
                          ),
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 1,
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            width: double.maxFinite,
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Button(
                  label: 'Enviar',
                  icon: Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(Icons.send_rounded, color: white, size: 16.0),
                  ),
                  onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => Modal(
                      title: 'Deseja continuar?',
                      textBody:
                          'Deseja enviar ${_valueController.text} $currencySelectedName para o endereço fornecido? Confira as informações antes de enviar.',
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Cancelar',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary)),
                        ),
                        TextButton(
                          onPressed: () {
                            onClickSend();
                          },
                          child: Text('Enviar',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 64.0, bottom: 16.0),
            child: SvgPicture.asset(
              "assets/illustration_send.svg",
              height: 191.91,
              width: 200.0,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            'Certifique-se de que o endereço inserido é um endereço válido para não correr o risco de perder seus tokens. O Multiprova não se responsabiliza por tokens perdidos.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
      screenActive: NavigationBarActions.none,
      automaticallyImplyLeading: true,
    );
  }
}
