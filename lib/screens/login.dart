import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multiprova_wallet/screens/home.dart';
import 'package:multiprova_wallet/widgets/button.dart';
import 'package:multiprova_wallet/widgets/logo.dart';

class Login extends StatelessWidget {
  const Login({super.key});

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
                Button(
                  label: 'Login com MetaMask',
                  icon: Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Image.asset(
                      'assets/metamask_logo.png',
                      height: 24.0,
                      width: 24.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Home()),
                    );
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
