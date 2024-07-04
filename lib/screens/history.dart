import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multiprova_wallet/enums/navigation_bar_actions.dart';
import 'package:multiprova_wallet/models/w3m_service.dart';
import 'package:multiprova_wallet/screens/home.dart';
import 'package:multiprova_wallet/widgets/display.dart';
import 'package:multiprova_wallet/widgets/history_card.dart';
import 'package:provider/provider.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  late DeployedContract deployedContractTokenUtility;
  List<dynamic> history = [];

  @override
  void initState() {
    super.initState();
    initContracts();
  }

  Future<void> initContracts() async {
    try {
      final jsonABIUtility =
          await rootBundle.loadString('assets/multiprova_utilityABI.json');

      deployedContractTokenUtility = DeployedContract(
        ContractAbi.fromJson(
          jsonABIUtility, // ABI object
          'MultiprovaTokenUtility',
        ),
        EthereumAddress.fromHex(addressMultiprovaUtility),
      );
      var walletAddress = Provider.of<W3mServiceModel>(context, listen: false)
          .w3mService
          .session!
          .address!;

      var result = await Provider.of<W3mServiceModel>(context, listen: false)
          .w3mService
          .requestReadContract(
              deployedContract: deployedContractTokenUtility,
              functionName: 'get_historico_by_address',
              rpcUrl: rpcUrl,
              parameters: [EthereumAddress.fromHex(walletAddress)]);
      setState(() {
        history = result[0];
      });
    } catch (e) {
      print("Erro no initContracts: " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Display(
      title: Text('Histórico', style: Theme.of(context).textTheme.titleLarge),
      body: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        alignment: WrapAlignment.spaceBetween,
        children: history.map((item) {
          var itemSplit = item.toString().split(";");
          if (itemSplit[0] == "swap") {
            return SwapHistoryCard(
                to: itemSplit[1], from: itemSplit[2], date: itemSplit[3]);
          } else if (itemSplit[0] == "buy") {
            return ShoppingHistoryCard(
                coins: itemSplit[2], item: itemSplit[1], date: itemSplit[3]);
          }
          return HistoryEarnCard(date: '25/05', coins: 10, isToken: true);
        }).toList(),
        // children: const <Widget>[
        //   HistoryEarnCard(date: '25/05', coins: 10, isToken: true),
        //   ShoppingHistoryCard(date: '25/05', coins: 20, item: '1 Cupom R\$ 10'),
        //   SwapHistoryCard(date: '25/05', to: 'MC 10', from: 'MT 5'),
        //   HistoryEarnCard(date: '25/05', coins: 10, isToken: true),
        //   ShoppingHistoryCard(date: '25/05', coins: 20, item: '1 Cupom R\$ 10'),
        //   SwapHistoryCard(date: '25/05', to: 'MC 10', from: 'MT 5'),
        //   HistoryEarnCard(date: '25/05', coins: 10, isToken: true),
        //   ShoppingHistoryCard(date: '25/05', coins: 20, item: '1 Cupom R\$ 10'),
        //   SwapHistoryCard(date: '25/05', to: 'MC 10', from: 'MT 5'),
        //   HistoryEarnCard(date: '25/05', coins: 10, isToken: true),
        //   ShoppingHistoryCard(date: '25/05', coins: 20, item: '1 Cupom R\$ 10'),
        //   SwapHistoryCard(date: '25/05', to: 'MC 10', from: 'MT 5'),
        // ],
      ),
      screenActive: NavigationBarActions.history,
      automaticallyImplyLeading: false,
    );
  }
}
