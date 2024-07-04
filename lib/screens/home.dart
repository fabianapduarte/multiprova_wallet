import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multiprova_wallet/enums/navigation_bar_actions.dart';
import 'package:multiprova_wallet/models/w3m_service.dart';
import 'package:multiprova_wallet/screens/send.dart';
import 'package:multiprova_wallet/screens/swap.dart';
import 'package:multiprova_wallet/utils/colors.dart';
import 'package:multiprova_wallet/widgets/button_home.dart';
import 'package:multiprova_wallet/widgets/card_outlined.dart';
import 'package:multiprova_wallet/widgets/container_icon.dart';
import 'package:multiprova_wallet/widgets/display.dart';
import 'package:multiprova_wallet/widgets/card.dart';
import 'package:multiprova_wallet/widgets/logo.dart';
import 'package:multiprova_wallet/widgets/modal.dart';
import 'package:multiprova_wallet/widgets/snackbar.dart';
import 'package:provider/provider.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

const addressMultiprovaCoin = "0x231Ecef923294bf9470ABF99C8cD0C2864942A57";
const addressMultiprovaToken = "0x426740b5AEaA9191F3E33F090b378fA824864E6b";
const addressMultiprovaUtility = "0x2866Ac194EB9cF3E29c99355D0354655ffb73286";
const rpcUrl = "https://sepolia.infura.io/v3/your_rpc_id";

class _HomeState extends State<Home> {
  int multiprovaCoinBalance = 0;
  int multiprovaTokenBalance = 0;
  int multiplaEscolhaBombs = 0;
  int associacaoColunasBombs = 0;
  int voufBombs = 0;
  String walletAddress = "";

  @override
  void initState() {
    super.initState();
    callReadFunction();
  }

  Future<void> getMultiplaEscolhaBombs(
      DeployedContract contract, String walletWaddress) async {
    var result = await Provider.of<W3mServiceModel>(context, listen: false)
        .w3mService
        .requestReadContract(
            deployedContract: contract,
            functionName: 'get_multipla_escolha_bombs',
            rpcUrl: rpcUrl,
            parameters: [EthereumAddress.fromHex(walletWaddress)]);
    setState(() {
      multiplaEscolhaBombs = int.parse(result[0].toString());
    });
  }

  Future<void> getMultiprovaTokenBalance(
      DeployedContract contract, String walletWaddress) async {
    var result = await Provider.of<W3mServiceModel>(context, listen: false)
        .w3mService
        .requestReadContract(
            deployedContract: contract,
            functionName: 'balanceOf',
            rpcUrl: rpcUrl,
            parameters: [EthereumAddress.fromHex(walletWaddress)]);
    setState(() {
      multiprovaTokenBalance = int.parse(result[0].toString());
    });
  }

  Future<void> getMultiprovaCoinBalance(
      DeployedContract contract, String walletWaddress) async {
    var result = await Provider.of<W3mServiceModel>(context, listen: false)
        .w3mService
        .requestReadContract(
            deployedContract: contract,
            functionName: 'balanceOf',
            rpcUrl: rpcUrl,
            parameters: [EthereumAddress.fromHex(walletWaddress)]);
    setState(() {
      multiprovaCoinBalance = int.parse(result[0].toString());
    });
  }

  Future<void> getAssociacaoColunasBombs(
      DeployedContract contract, String walletWaddress) async {
    var result = await Provider.of<W3mServiceModel>(context, listen: false)
        .w3mService
        .requestReadContract(
            deployedContract: contract,
            functionName: 'get_associacao_de_colunas_bombs',
            rpcUrl: rpcUrl,
            parameters: [EthereumAddress.fromHex(walletWaddress)]);
    setState(() {
      associacaoColunasBombs = int.parse(result[0].toString());
    });
  }

  Future<void> getVouFBombs(
      DeployedContract contract, String walletWaddress) async {
    var result = await Provider.of<W3mServiceModel>(context, listen: false)
        .w3mService
        .requestReadContract(
            deployedContract: contract,
            functionName: 'get_v_ou_f_bombs',
            rpcUrl: rpcUrl,
            parameters: [EthereumAddress.fromHex(walletWaddress)]);
    setState(() {
      voufBombs = int.parse(result[0].toString());
    });
  }

  Future<void> callReadFunction() async {
    final jsonABI =
        await rootBundle.loadString('assets/multiprova_tokenABI.json');
    final jsonABICoin =
        await rootBundle.loadString('assets/multiprova_coinABI.json');
    try {
      final deployedContractCoin = DeployedContract(
        ContractAbi.fromJson(
          jsonABICoin, // ABI object
          'multiprova_coin',
        ),
        EthereumAddress.fromHex(addressMultiprovaCoin),
      );

      final deployedContractToken = DeployedContract(
        ContractAbi.fromJson(
          jsonABI, // ABI object
          'multiprova_token',
        ),
        EthereumAddress.fromHex(addressMultiprovaToken),
      );

      walletAddress = Provider.of<W3mServiceModel>(context, listen: false)
          .w3mService
          .session!
          .address!;
      // Reading values from smart contract
      await getMultiprovaTokenBalance(deployedContractToken, walletAddress);
      await getMultiprovaCoinBalance(deployedContractCoin, walletAddress);
      await getMultiplaEscolhaBombs(deployedContractCoin, walletAddress);
      await getAssociacaoColunasBombs(deployedContractCoin, walletAddress);
      await getVouFBombs(deployedContractCoin, walletAddress);
    } catch (e) {
      print(e);
    }
  }

  Widget getInfoCard(int number, String label) {
    return CardFilled(
      width: (MediaQuery.sizeOf(context).width / 2) - 53.0,
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text('$number', style: Theme.of(context).textTheme.headlineLarge),
          ),
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }

  Widget getBombCard(int number, String type) {
    return CardFilled(
      width: (MediaQuery.sizeOf(context).width / 3) - 50.0,
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text('$number', style: Theme.of(context).textTheme.headlineMedium),
          ),
          Text(
            type,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            softWrap: true,
          ),
        ],
      ),
    );
  }

  Widget getQuotationCard(String currency, double percentage,
      double realCurrency, String coinCurrency) {
    final String percentageString =
        percentage.toStringAsFixed(2).replaceAll('.', ',');
    final String realCurrencyString =
        realCurrency.toStringAsFixed(2).replaceAll('.', ',');

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: CardOutlined(
        width: double.maxFinite,
        body: Row(
          children: <Widget>[
            const ContainerIcon(padding: 8.0, icon: Icons.paid),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(currency,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      )),
                  Text('$percentageString%',
                      style: TextStyle(
                        color: percentage.isNegative ? red : green,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      )),
                ],
              ),
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text('R\$ $realCurrencyString',
                    style: Theme.of(context).textTheme.bodyMedium),
                Text(coinCurrency,
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Display(
      automaticallyImplyLeading: false,
      screenActive: NavigationBarActions.home,
      title: const Logo(
        alignment: MainAxisAlignment.start,
        fontSize: 22.0,
        iconSize: 26.0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              getInfoCard(multiprovaCoinBalance, 'MultiprovaCoin'),
              getInfoCard(multiprovaTokenBalance, 'MultiprovaToken'),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
            child: Text('Bombas', style: Theme.of(context).textTheme.titleSmall, textAlign: TextAlign.start),
          ),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                getBombCard(multiplaEscolhaBombs, 'Múltipla Escolha'),
                getBombCard(associacaoColunasBombs, 'Associação de Colunas'),
                getBombCard(voufBombs, 'V ou F'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
            child: Text('Ações', style: Theme.of(context).textTheme.titleSmall, textAlign: TextAlign.start),
          ),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            direction: Axis.horizontal,
            spacing: 10,
            runSpacing: 10,
            children: <Widget>[
              ButtonHome(
                label: 'Receber',
                srcIcon: 'icon_receive.png',
                onPressed: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => Modal(
                    title: 'Receber',
                    textBody:
                        'Seu endereço:\n $walletAddress\n\nReceba tokens de outra pessoa através do endereço da sua conta.',
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Fechar',
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onPrimary)),
                      ),
                      TextButton(
                        onPressed: () async {
                          await Clipboard.setData(
                            ClipboardData(text: walletAddress),
                          ).then((value) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const Snackbar(text: 'Endereço copiado!').build(context));
                            Navigator.pop(context);
                          });
                        },
                        child: Text('Compartilhar',
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onPrimary)),
                      ),
                    ],
                  ),
                ),
              ),
              ButtonHome(
                label: 'Enviar',
                srcIcon: 'icon_send.png',
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Send()));
                },
              ),
              ButtonHome(
                label: 'Swap',
                srcIcon: 'icon_swap.png',
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Swap()));
                },
              ),
              ButtonHome(
                label: 'Como ganhar',
                srcIcon: 'icon_how_earn.png',
                onPressed: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => Modal(
                    title: 'Como ganhar',
                    textBody:
                        'Responda questões corretamente em provas feitas exclusivamente no Multiprova e consiga MultiprovaTokens. Troque seus MultiprovaTokens por MultiprovaCoin e utilize como achar melhor.\n\nObs.: Seu professor DEVE ativar essa funcionalidade para que seja possível receber os tokens.',
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Fechar',
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onPrimary)),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
            child: Text('Cotação diária', style: Theme.of(context).textTheme.titleSmall, textAlign: TextAlign.start),
          ),
          Column(
            children: <Widget>[
              getQuotationCard('MultiprovaCoin', 2.5, 2.455, 'MTC 50'),
              getQuotationCard('Ethereum', -0.32, 16458.37, 'ETH 1,00014'),
            ],
          ),
        ],
      ),
    );
  }
}
