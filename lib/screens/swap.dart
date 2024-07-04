import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:multiprova_wallet/enums/currency.dart';
import 'package:multiprova_wallet/enums/navigation_bar_actions.dart';
import 'package:multiprova_wallet/models/w3m_service.dart';
import 'package:multiprova_wallet/screens/home.dart';
import 'package:multiprova_wallet/utils/colors.dart';
import 'package:multiprova_wallet/utils/convert_currency.dart';
import 'package:multiprova_wallet/widgets/button.dart';
import 'package:multiprova_wallet/widgets/card_outlined.dart';
import 'package:multiprova_wallet/widgets/container_icon.dart';
import 'package:multiprova_wallet/widgets/display.dart';
import 'package:multiprova_wallet/widgets/modal.dart';
import 'package:multiprova_wallet/widgets/snackbar.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/link.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';
import 'package:http/http.dart';

class Swap extends StatefulWidget {
  const Swap({super.key});

  @override
  State<Swap> createState() => _SwapState();
}

class _SwapState extends State<Swap> {
  Currency _inputCurrency = Currency.multiprovaToken;
  Currency _outputCurrency = Currency.multiprovaCoin;
  final double tokenInCoin = 0.5;
  final _inputCurrencyController = TextEditingController(text: '0');
  final _outputCurrencyController = TextEditingController(text: '0');
  late ContractEvent swapEvent;
  late DeployedContract deployedContractTokenUtility;
  late Web3Client ethClient;
  bool swapMuTokenToMuCoin = true;

  @override
  void dispose() {
    _inputCurrencyController.dispose();
    _outputCurrencyController.dispose();
    super.dispose();
  }

  Future<void> swapTokens(int inputValue, int outputValue) async {
    final jsonABI =
        await rootBundle.loadString('assets/multiprova_utilityABI.json');
    try {
      var w3mService =
          Provider.of<W3mServiceModel>(context, listen: false).w3mService;
      deployedContractTokenUtility = DeployedContract(
        ContractAbi.fromJson(
          jsonABI, // ABI object
          'multiprova_token_utility',
        ),
        EthereumAddress.fromHex(addressMultiprovaUtility),
      );

      swapEvent = deployedContractTokenUtility.event('swapEfetuado');

      final Client httpClient = Client();
      var walletWaddress = w3mService.session!.address!;
      ethClient = Web3Client(rpcUrl, httpClient);
      w3mService.launchConnectedWallet();
      await w3mService.requestWriteContract(
          topic: w3mService.session!.topic!,
          chainId: w3mService.selectedChain!.namespace,
          deployedContract: deployedContractTokenUtility,
          functionName: swapMuTokenToMuCoin
              ? 'swap_MuTK_to_MuCoin'
              : 'swap_MuCoin_to_MuTK',
          rpcUrl: rpcUrl,
          transaction: Transaction(
            from: EthereumAddress.fromHex(walletWaddress),
          ),
          parameters: [BigInt.from(inputValue), BigInt.from(outputValue)]);
    } catch (e) {
      print(e);
    }
  }

  void listenToSwapExecuted() {
    final filter = FilterOptions.events(
      contract: deployedContractTokenUtility,
      event: swapEvent,
    );
    ethClient.events(filter).listen((event) {
      // final decoded = swapEvent.decodeResults(event.topics!, event.data!);
      ScaffoldMessenger.of(context).showSnackBar(
          const Snackbar(text: 'Troca realizada com sucesso').build(context));
    });
  }

  Future<void> onClickSwap() async {
    NumberFormat formatter = NumberFormat.decimalPatternDigits(locale: 'pt_BR');
    int mutkValue = formatter.parse(_inputCurrencyController.text).toInt();
    int muCoinValue = formatter.parse(_outputCurrencyController.text).toInt();

    Navigator.pop(context);
    await swapTokens(mutkValue, muCoinValue);
    listenToSwapExecuted();
  }

  Widget getCurrencyInput(Currency currency, TextEditingController controller,
      Function(String) onChanged) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const ContainerIcon(padding: 8.0, icon: Icons.paid),
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Text(currency.name, style: Theme.of(context).textTheme.titleSmall),
        ),
        const Spacer(),
        SizedBox(
          width: 80,
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 8.0, top: 0.0),
            ),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
            maxLines: 1,
            keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: false),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(
                  RegExp(r'[0-9]+[,]{0,1}[0-9]*')),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Display(
      title: Text('Swap', style: Theme.of(context).textTheme.titleLarge),
      body: Column(
        children: <Widget>[
          CardOutlined(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('De', style: Theme.of(context).textTheme.bodyMedium),
                ),
                getCurrencyInput(
                  _inputCurrency,
                  _inputCurrencyController,
                  (String? text) {
                    bool isToken = _inputCurrency == Currency.multiprovaToken;
                    _outputCurrencyController.text = convertCurrency(
                        text, isToken ? tokenInCoin : 1 / tokenInCoin);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: <Widget>[
                      Divider(
                          color: Theme.of(context).colorScheme.outline,
                          thickness: 1),
                      FloatingActionButton(
                        onPressed: () {
                          setState(() {
                            String oldInput = _inputCurrencyController.text;
                            String oldOutput = _outputCurrencyController.text;

                            _inputCurrencyController.text = oldOutput;
                            _outputCurrencyController.text = oldInput;

                            if (_inputCurrency == Currency.multiprovaCoin) {
                              _inputCurrency = Currency.multiprovaToken;
                              _outputCurrency = Currency.multiprovaCoin;
                            } else {
                              _inputCurrency = Currency.multiprovaCoin;
                              _outputCurrency = Currency.multiprovaToken;
                            }
                            swapMuTokenToMuCoin = !swapMuTokenToMuCoin;
                          });
                        },
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child:
                            const Icon(Icons.swap_vert_rounded, color: white),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('Para', style: Theme.of(context).textTheme.bodyMedium),
                ),
                getCurrencyInput(
                  _outputCurrency,
                  _outputCurrencyController,
                  (String? text) {
                    bool isToken = _outputCurrency == Currency.multiprovaToken;
                    _inputCurrencyController.text = convertCurrency(
                        text, isToken ? tokenInCoin : 1 / tokenInCoin);
                  },
                ),
              ],
            ),
            width: double.maxFinite,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24.0, bottom: 24.0),
                child: Text(
                  '1 MultiprovaToken = ${tokenInCoin.toStringAsFixed(2).replaceAll('.', ',')} MultiprovaCoin',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Button(
                label: 'Trocar',
                icon: const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.currency_exchange_rounded,
                      color: white, size: 16.0),
                ),
                onPressed: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => Modal(
                    title: 'Deseja continuar?',
                    textBody:
                        'Deseja trocar ${_inputCurrencyController.text} ${_inputCurrency.name} por ${_outputCurrencyController.text} ${_outputCurrency.name}? A ação não pode ser desfeita.',
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
                          onClickSwap(); 
                        },
                        child: Text('Trocar',
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
        ],
      ),
      screenActive: NavigationBarActions.swap,
      automaticallyImplyLeading: false,
    );
  }
}
