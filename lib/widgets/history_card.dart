import 'package:flutter/material.dart';
import 'package:multiprova_wallet/widgets/card_outlined.dart';
import 'package:multiprova_wallet/widgets/container_icon.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({super.key, required this.date, required this.icon, required this.info, required this.title});

  final IconData icon;
  final String title, date;
  final Widget info;

  @override
  Widget build(BuildContext context) {
    return CardOutlined(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: ContainerIcon(padding: 12.0, icon: icon),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: Theme.of(context).textTheme.titleSmall),
                info,
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(date, style: Theme.of(context).textTheme.bodySmall),
          ),
        ],
      ),
      width: double.maxFinite,
    );
  }
}

class HistoryEarnCard extends StatelessWidget {
  const HistoryEarnCard({super.key, required this.date, required this.coins, required this.isToken});

  final String date;
  final int coins;
  final bool isToken;

  @override
  Widget build(BuildContext context) {
    final String currency = isToken ? 'MultiprovaTokens' : 'MultiprovaCoins';

    return HistoryCard(
      date: date,
      icon: Icons.save_alt_rounded,
      info: Text('$coins $currency', style: Theme.of(context).textTheme.bodyMedium),
      title: 'Moedas recebidas',
    );
  }
}

class ShoppingHistoryCard extends StatelessWidget {
  const ShoppingHistoryCard({super.key, required this.date, required this.coins, required this.item});

  final String date, item;
  final String coins;

  @override
  Widget build(BuildContext context) {
    return HistoryCard(
      date: date,
      icon: Icons.shopping_cart_rounded,
      info: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(item, style: Theme.of(context).textTheme.bodyMedium, overflow: TextOverflow.ellipsis),
          Text(coins, style: Theme.of(context).textTheme.bodyMedium)
        ],
      ),
      title: 'Compra na loja',
    );
  }
}

class SwapHistoryCard extends StatelessWidget {
  const SwapHistoryCard({super.key, required this.date, required this.to, required this.from});

  final String date, to, from;

  @override
  Widget build(BuildContext context) {
    return HistoryCard(
      date: date,
      icon: Icons.swap_horiz_rounded,
      info: Row(
        children: [
          Text(from, style: Theme.of(context).textTheme.bodyMedium),
          const Padding(padding: EdgeInsets.symmetric(horizontal: 5.0), child: Icon(Icons.arrow_right_alt_rounded)),
          Text(to, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
      title: 'Troca de moedas',
    );
  }
}
