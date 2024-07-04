import 'package:flutter/material.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

class W3mServiceModel extends ChangeNotifier {
  late W3MService _w3mService;
  bool _isConnected = false;
  bool _loading = false;

  W3MService get w3mService => _w3mService;
  bool get isConnected => _isConnected;
  bool get loading => _loading;

  Future<void> initializeState() async {
    W3MChainPresets.chains.putIfAbsent(_chainId, () => _sepoliaChain);
    _w3mService = W3MService(
        projectId: 'your_project_id',
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

    _loading = true;
    await _w3mService.init();

    _isConnected = _w3mService.isConnected;
    notifyListeners();
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

    _isConnected = _w3mService.isConnected;
    _loading = false;
    notifyListeners();
  }

  void _onModalDisconnect(ModalDisconnect? event) {
    debugPrint('[MultiprovaWallet] _onModalDisconnect ${event?.toString()}');
    _isConnected = false;
    _loading = false;
    notifyListeners();
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
