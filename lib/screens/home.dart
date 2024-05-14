import 'package:flutter/material.dart';
import 'package:multiprova_wallet/widgets/display.dart';
import 'package:multiprova_wallet/widgets/card.dart';
import 'package:multiprova_wallet/widgets/logo.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget getInfoCard(BuildContext context, int number, String label) {
    return CardFilled(
      width: (MediaQuery.sizeOf(context).width / 2) - 56.0,
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text('$number', style: Theme.of(context).textTheme.headlineLarge),
          ),
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }

  Widget getBombCard(BuildContext context, int number, String type) {
    return CardFilled(
      width: (MediaQuery.sizeOf(context).width / 3) - 51.0,
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text('$number', style: Theme.of(context).textTheme.headlineMedium),
          ),
          Text(
            type,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Display(
      title: Logo(
        alignment: MainAxisAlignment.start,
        fontSize: 22.0,
        iconSize: 26.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getInfoCard(context, 70, 'MultiprovaCoin'),
                getInfoCard(context, 50, 'MultiprovaToken'),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.0, bottom: 8.0, left: 4.0),
              child: Text('Bombas', style: Theme.of(context).textTheme.titleSmall, textAlign: TextAlign.start),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getBombCard(context, 2, 'Múltipla Escolha'),
                getBombCard(context, 3, 'Assoc. Colunas'),
                getBombCard(context, 3, 'V ou F'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
