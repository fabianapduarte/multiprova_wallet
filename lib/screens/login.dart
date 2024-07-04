import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multiprova_wallet/models/w3m_service.dart';
import 'package:multiprova_wallet/screens/home.dart';
import 'package:multiprova_wallet/utils/colors.dart';
import 'package:multiprova_wallet/widgets/button.dart'; 
import 'package:multiprova_wallet/widgets/logo.dart';
import 'package:provider/provider.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
    Provider.of<W3mServiceModel>(context, listen: false).initializeState();
    Future.delayed(Duration.zero, () async {
      final w3mService = Provider.of<W3mServiceModel>(context, listen: false);
      await w3mService.initializeState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(48.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Padding(
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
                  padding: const EdgeInsets.symmetric(vertical: 32.0),
                  child: SvgPicture.asset(
                    "assets/illustration_login.svg",
                    height: 213.18,
                    width: 280.0,
                    fit: BoxFit.cover,
                  ),
                ),
                W3MConnectWalletButton(
                    service: context.read<W3mServiceModel>().w3mService,
                    context: context,
                    custom: Consumer<W3mServiceModel>(
                      builder: (context, values, child) {
                        return Button(
                          label: !values.isConnected
                              ? 'Login com MetaMask'
                              : 'Desconectar',
                          icon: Image.asset(
                            'assets/metamask_logo.png',
                            height: 24.0,
                            width: 24.0,
                            fit: BoxFit.cover,
                          ),
                          onPressed: () {
                            context
                                .read<W3mServiceModel>()
                                .w3mService
                                .openModal(context);
                          },
                        );
                      },
                    )),
                Consumer<W3mServiceModel>(
                  builder: (context, values, child) {
                    return Visibility(
                        visible: values.isConnected,
                        child: Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Button(
                            label: 'Acessar MultiprovaWallet',
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Home()),
                              );
                            },
                          ),
                        ));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
