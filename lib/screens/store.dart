import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multiprova_wallet/enums/navigation_bar_actions.dart';
import 'package:multiprova_wallet/enums/product_type.dart';
import 'package:multiprova_wallet/models/w3m_service.dart';
import 'package:multiprova_wallet/screens/home.dart';
import 'package:multiprova_wallet/utils/colors.dart';
import 'package:multiprova_wallet/widgets/button.dart';
import 'package:multiprova_wallet/widgets/card.dart';
import 'package:multiprova_wallet/widgets/card_outlined.dart';
import 'package:multiprova_wallet/widgets/display.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multiprova_wallet/widgets/modal.dart';
import 'package:multiprova_wallet/widgets/snackbar.dart';
import 'package:provider/provider.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';
import 'package:http/http.dart';

class Store extends StatefulWidget {
  const Store({super.key});

  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {
  int multiprovaCoinBalance = 0;
  String walletAddress = "";
  late DeployedContract deployedContractCoin;
  late ContractEvent bombaCompradaEvent;
  late Web3Client ethClient;

  @override
  void initState() {
    super.initState();
    getMultiprovaCoinBalance();
  }

  Future<void> getMultiprovaCoinBalance() async {
    try {
      final jsonABICoin =
          await rootBundle.loadString('assets/multiprova_coinABI.json');
      deployedContractCoin = DeployedContract(
        ContractAbi.fromJson(
          jsonABICoin, // ABI object
          'multiprova_coin',
        ),
        EthereumAddress.fromHex(addressMultiprovaCoin),
      );

      walletAddress = Provider.of<W3mServiceModel>(context, listen: false)
          .w3mService
          .session!
          .address!;
      var result = await Provider.of<W3mServiceModel>(context, listen: false)
          .w3mService
          .requestReadContract(
              deployedContract: deployedContractCoin,
              functionName: 'balanceOf',
              rpcUrl: rpcUrl,
              parameters: [EthereumAddress.fromHex(walletAddress)]);
      setState(() {
        multiprovaCoinBalance = int.parse(result[0].toString());
      });
      bombaCompradaEvent = deployedContractCoin.event('bomba_comprada');
      final Client httpClient = Client();
      ethClient = Web3Client(rpcUrl, httpClient);
    } catch (e) {
      print(e);
    }
  }

  void listenToBombEventExecuted() {
    final filter = FilterOptions.events(
      contract: deployedContractCoin,
      event: bombaCompradaEvent,
    );
    ethClient.events(filter).listen((event) {
      final decoded =
          bombaCompradaEvent.decodeResults(event.topics!, event.data!);
      final tipoBomba = decoded[0] as String;
      ScaffoldMessenger.of(context).showSnackBar(
          Snackbar(text: 'Bomba $tipoBomba comprada com sucesso')
              .build(context));
    });
  }

  Future<void> callBuyBomb(String functionName, int quantity) async {
    try {
      var w3mService =
          Provider.of<W3mServiceModel>(context, listen: false).w3mService;

      var walletWaddress = w3mService.session!.address!;
      w3mService.launchConnectedWallet();
      await w3mService.requestWriteContract(
          topic: w3mService.session!.topic!,
          chainId: w3mService.selectedChain!.namespace,
          deployedContract: deployedContractCoin,
          functionName: functionName,
          rpcUrl: rpcUrl,
          transaction: Transaction(
            from: EthereumAddress.fromHex(walletWaddress),
          ),
          parameters: [BigInt.from(quantity)]);
    } catch (e) {
      print(e);
    }
  }

  Future<void> buyBombs(String productName) async {
    String functionName;

    switch (productName) {
      case "Bomba de múltipla escolha":
        functionName = "comprar_multipla_escolha_bomb";
      case "Bomba de V ou F":
        functionName = "comprar_vouf_bomb";
      case "Bomba de associação de colunas":
        functionName = "comprar_associacao_de_colunas_bomb";
      default:
        functionName = "";
    }
    await callBuyBomb(functionName, 1);
    listenToBombEventExecuted();
  }

  Widget getCardStore(
    BuildContext context,
    ProductType productType,
    String productName,
    double price,
    String description,
  ) {
    String priceString = price.toStringAsFixed(2).replaceAll('.', ',');
    IconData icon;

    if (productType == ProductType.bomb) {
      icon = FontAwesomeIcons.bomb;
    } else {
      icon = Icons.card_giftcard_rounded;
    }

    return CardOutlined(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Icon(
                  icon,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              Expanded(
                child: Text(
                  productName,
                  style: Theme.of(context).textTheme.titleMedium,
                  softWrap: true,
                  maxLines: 2,
                ),
              ),
            ],
          ),
          Text(
            'MC $priceString',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0, bottom: 12.0),
            child: Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium,
              softWrap: true,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Button(
                label: 'Comprar',
                icon: Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.shopping_cart_rounded,
                      color: white, size: 16.0),
                ),
                onPressed: () => showDialog<Widget>(
                  context: context,
                  builder: (BuildContext context) => Modal(
                    title: 'Deseja continuar?',
                    textBody:
                        'Deseja comprar 1 $productName por MC $priceString?',
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
                          Navigator.pop(context);
                          buyBombs(productName);
                        },
                        child: Text('Comprar',
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
      width: double.maxFinite,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Display(
      automaticallyImplyLeading: false,
      screenActive: NavigationBarActions.store,
      title: Text('Loja', style: Theme.of(context).textTheme.titleLarge),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: CardFilled(
              width: double.maxFinite,
              body: Row(
                children: <Widget>[
                  Icon(Icons.paid,
                      color: Theme.of(context).colorScheme.onPrimary,
                      size: 50.0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Saldo da conta',
                            style: Theme.of(context).textTheme.bodyMedium),
                        Text('$multiprovaCoinBalance MultiprovaCoins',
                            style: Theme.of(context).textTheme.titleMedium),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            alignment: WrapAlignment.spaceBetween,
            children: <Widget>[
              getCardStore(
                context,
                ProductType.bomb,
                'Bomba de múltipla escolha',
                5.0,
                'Elimina uma alternativa aleatória errada de uma questão de múltipla escolha. Só pode ser usada uma vez.',
              ),
              getCardStore(
                context,
                ProductType.bomb,
                'Bomba de V ou F',
                5.0,
                'Mostra a reposta de um item aleatório de uma questão de V ou F. Só pode ser usada uma vez.',
              ),
              getCardStore(
                context,
                ProductType.bomb,
                'Bomba de associação de colunas',
                5.0,
                'Mostra a resposta de um item aleatório de uma questão de associação de colunas. Só pode ser usada uma vez.',
              ),
              getCardStore(
                context,
                ProductType.giftCard,
                'Cupom R\$ 5',
                10.0,
                'Cupom de desconto de R\$ 5,00 para usar em cantinas.',
              ),
              getCardStore(
                context,
                ProductType.giftCard,
                'Cupom R\$ 10',
                20.0,
                'Cupom de desconto de R\$ 10,00 para usar em cantinas.',
              ),
              getCardStore(
                context,
                ProductType.giftCard,
                'Cupom R\$ 20',
                40.0,
                'Cupom de desconto de R\$ 20,00 para usar em cantinas.',
              ),
            ],
          )
        ],
      ),
    );
  }
}
