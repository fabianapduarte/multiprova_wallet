import 'package:flutter/material.dart';
import 'package:multiprova_wallet/enums/navigation_bar_actions.dart';
import 'package:multiprova_wallet/enums/product_type.dart';
import 'package:multiprova_wallet/utils/colors.dart';
import 'package:multiprova_wallet/widgets/button.dart';
import 'package:multiprova_wallet/widgets/card.dart';
import 'package:multiprova_wallet/widgets/card_outlined.dart';
import 'package:multiprova_wallet/widgets/display.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multiprova_wallet/widgets/modal.dart';
import 'package:multiprova_wallet/widgets/snackbar.dart';

class Store extends StatelessWidget {
  const Store({super.key});

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
                padding: const EdgeInsets.only(right: 10.0),
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
            padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
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
                icon: const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.shopping_cart_rounded, color: white, size: 16.0),
                ),
                onPressed: () => showDialog<Widget>(
                  context: context,
                  builder: (BuildContext context) => Modal(
                    title: 'Deseja continuar?',
                    textBody: 'Deseja comprar 1 $productName por MC $priceString?',
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Cancelar', style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
                      ),
                      TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const Snackbar(text: 'Compra realizada com sucesso').build(context));
                          Navigator.pop(context);
                        },
                        child: Text('Comprar', style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
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
            padding: const EdgeInsets.only(bottom: 16.0),
            child: CardFilled(
              width: double.maxFinite,
              body: Row(
                children: <Widget>[
                  Icon(Icons.paid, color: Theme.of(context).colorScheme.onPrimary, size: 50.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Saldo da conta', style: Theme.of(context).textTheme.bodyMedium),
                        Text('50 MultiprovaCoins', style: Theme.of(context).textTheme.titleMedium),
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
                10.0,
                'Elimina uma alternativa aleatória errada de uma questão de múltipla escolha. Só pode ser usada uma vez.',
              ),
              getCardStore(
                context,
                ProductType.bomb,
                'Bomba de V ou F',
                10.0,
                'Mostra a reposta de um item aleatório de uma questão de V ou F. Só pode ser usada uma vez.',
              ),
              getCardStore(
                context,
                ProductType.bomb,
                'Bomba de associação de colunas',
                10.0,
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
