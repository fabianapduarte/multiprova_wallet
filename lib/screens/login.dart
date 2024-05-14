import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multiprova_wallet/screens/home.dart';
import 'package:multiprova_wallet/widgets/button.dart';
import 'package:multiprova_wallet/widgets/logo.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late W3MService _w3mService;

  @override
  void initState() {
    super.initState();
    initializeState();
  }

  void initializeState() async {
    W3MChainPresets.chains.putIfAbsent(_chainId, () => _sepoliaChain);
    _w3mService = W3MService(
      projectId: '1509f0d2823f62aef35bb27b39c0f620',
      metadata: const PairingMetadata(
        name: 'Web3Modal Flutter Example',
        description: 'Web3Modal Flutter Example',
        url: 'https://web3modal.com /',
        icons: ['https://walletconnect.com/walletconnect-logo.png'],
        redirect: Redirect(
          native: 'flutterdapp://',
          universal: 'https://web3modal.com',
        ),
      ),
      includedWalletIds: includedWalletIds,
    );
    await _w3mService.init();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(48.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 32.0),
                  child: Logo(
                    alignment: MainAxisAlignment.center,
                    fontSize: 32.0,
                    iconSize: 36.0,
                  ),
                ),
                Text(
                  'O Multiprova de forma divertida e atualizada com a Web3, conheça já!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  'Ganhe, envie e utilize seus tokens no MultiprovaWallet!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 32.0),
                  child: SvgPicture.asset(
                    "assets/illustration_login.svg",
                    height: 213.18,
                    width: 280.0,
                    fit: BoxFit.cover,
                  ),
                ),
                W3MConnectWalletButton(service: _w3mService),
                W3MNetworkSelectButton(service: _w3mService),
                W3MAccountButton(service: _w3mService),
                Button(
                  label: 'Login com MetaMask',
                  icon: Image.asset(
                    'assets/metamask_logo.png',
                    height: 24.0,
                    width: 24.0,
                    fit: BoxFit.cover,
                  ),
                  onPressed: () {
                    // Navigator.pop(context);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => const Home()),
                    // );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

const _chainId = "11155111";
// const _chainId = "0xaa36a7";

final _sepoliaChain = W3MChainInfo(
    chainName: "Sepolia",
    chainId: _chainId,
    namespace: "eip155:$_chainId",
    tokenName: 'ETH',
    rpcUrl: 'https://sepolia.infura.io/v3/',
    blockExplorer: W3MBlockExplorer(
        name: 'Sepolia Explorer', url: "https://sepolia.etherscan.io"));

final Set<String> includedWalletIds = {
  'c57ca95b47569778a828d19178114f4db188b89b763c899ba0be274e97267d96', // MetaMask
};
