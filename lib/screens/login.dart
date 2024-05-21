import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multiprova_wallet/screens/home.dart';
import 'package:multiprova_wallet/widgets/button.dart';
import 'package:multiprova_wallet/widgets/logo.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late W3MService _w3mService;
  bool isConnected = false;

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
            native: 'web3modalflutter://',
            universal: 'https://web3modal.com',
          ),
        ),
        includedWalletIds: includedWalletIds);

    _w3mService.onModalConnect.subscribe(_onModalConnect);
    _w3mService.onModalDisconnect.subscribe(_onModalDisconnect);

    await _w3mService.init();

    setState(() {
      isConnected = _w3mService.isConnected;
    });
  }

  @override
  void dispose() {
    _w3mService.onModalConnect.unsubscribe(_onModalConnect);
    _w3mService.onModalDisconnect.unsubscribe(_onModalDisconnect);

    super.dispose();
  }

  void _onModalConnect(ModalConnect? event) {
    debugPrint('[MultiprovaWallet] _onModalConnect ${event?.toString()}');
    debugPrint(
      '[MultiprovaWallet] _onModalConnect selectedChain ${_w3mService.selectedChain?.chainId}',
    );
    debugPrint(
      '[MultiprovaWallet] _onModalConnect address ${_w3mService.session!.address}',
    );
    setState(() {
      isConnected = _w3mService.isConnected;
    }); 
  }

  void _onModalDisconnect(ModalDisconnect? event) {
    debugPrint('[MultiprovaWallet] _onModalDisconnect ${event?.toString()}');
    setState(() {
      isConnected = false;
    });
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
                W3MConnectWalletButton(
                  service: _w3mService,
                  context: context,
                  custom: Button(
                    label: !isConnected ? 'Login com MetaMask' : 'Desconectar',
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
                      _w3mService.openModal(context);
                    },
                  ),
                ),
                Visibility(
                  visible: isConnected,
                  child: Button(
                    label: 'Acessar MultiprovaWallet',
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Home()),
                      );
                    },
                  ),
                )
                // W3MNetworkSelectButton(service: _w3mService, context: context),
                // W3MAccountButton(service: _w3mService),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

const _chainId = "11155111";

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
