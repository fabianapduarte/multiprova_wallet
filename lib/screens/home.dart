import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multiprova_wallet/utils/colors.dart';
import 'package:multiprova_wallet/widgets/button_home.dart';
import 'package:multiprova_wallet/widgets/card_outlined.dart';
import 'package:multiprova_wallet/widgets/display.dart';
import 'package:multiprova_wallet/widgets/card.dart';
import 'package:multiprova_wallet/widgets/logo.dart';
import 'package:multiprova_wallet/widgets/modal.dart';
import 'package:multiprova_wallet/widgets/snackbar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget getInfoCard(int number, String label) {
    return CardFilled(
      width: (MediaQuery.sizeOf(context).width / 2) - 53.0,
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

  Widget getBombCard(int number, String type) {
    return CardFilled(
      width: (MediaQuery.sizeOf(context).width / 3) - 50.0,
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

  Widget getQuotationCard(String currency, double percentage, double realCurrency, String coinCurrency) {
    final String percentageString = percentage.toStringAsFixed(2).replaceAll('.', ',');
    final String realCurrencyString = realCurrency.toStringAsFixed(2).replaceAll('.', ',');

    return Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: CardOutlined(
        width: (MediaQuery.sizeOf(context).width) - 64,
        body: Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                color: Theme.of(context).colorScheme.surface,
              ),
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.paid,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
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
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text('R\$ $realCurrencyString', style: Theme.of(context).textTheme.bodyMedium),
                Text(coinCurrency, style: Theme.of(context).textTheme.bodyMedium),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                getInfoCard(70, 'MultiprovaCoin'),
                getInfoCard(50, 'MultiprovaToken'),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 24.0, bottom: 8.0),
              child: Text('Bombas', style: Theme.of(context).textTheme.titleSmall, textAlign: TextAlign.start),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                getBombCard(2, 'Múltipla Escolha'),
                getBombCard(3, 'Assoc. Colunas'),
                getBombCard(3, 'V ou F'),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 24.0, bottom: 8.0),
              child: Text('Ações', style: Theme.of(context).textTheme.titleSmall, textAlign: TextAlign.start),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ButtonHome(
                  label: 'Receber',
                  srcIcon: 'icon_receive.png',
                  onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => Modal(
                      title: 'Receber',
                      textBody:
                          'Seu endereço:\n0x00b58369796dd223f025315d0a8a8a872517d51d\n\nReceba tokens de outra pessoa através do endereço da sua conta.',
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Fechar', style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
                        ),
                        TextButton(
                          onPressed: () async {
                            await Clipboard.setData(
                              ClipboardData(text: "0x00b58369796dd223f025315d0a8a8a872517d51d"),
                            ).then((value) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(Snackbar(text: 'Endereço copiado!').build(context));
                              Navigator.pop(context);
                            });
                          },
                          child: Text('Compartilhar', style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
                        ),
                      ],
                    ),
                  ),
                ),
                ButtonHome(label: 'Enviar', srcIcon: 'icon_send.png', onPressed: () {}),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ButtonHome(label: 'Swap', srcIcon: 'icon_swap.png', onPressed: () {}),
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
                            child: Text('Fechar', style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 24.0, bottom: 8.0),
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
      ),
    );
  }
}
