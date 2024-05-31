import 'package:flutter/material.dart';
import 'package:multiprova_wallet/enums/navigation_bar_actions.dart';
import 'package:multiprova_wallet/widgets/display.dart';
import 'package:multiprova_wallet/widgets/history_card.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return Display(
      title: Text('Histórico', style: Theme.of(context).textTheme.titleLarge),
      body: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        alignment: WrapAlignment.spaceBetween,
        children: const <Widget>[
          HistoryEarnCard(date: '25/05', coins: 10, isToken: true),
          ShoppingHistoryCard(date: '25/05', coins: 20, item: '1 Cupom R\$ 10'),
          SwapHistoryCard(date: '25/05', to: 'MC 10', from: 'MT 5'),
          HistoryEarnCard(date: '25/05', coins: 10, isToken: true),
          ShoppingHistoryCard(date: '25/05', coins: 20, item: '1 Cupom R\$ 10'),
          SwapHistoryCard(date: '25/05', to: 'MC 10', from: 'MT 5'),
          HistoryEarnCard(date: '25/05', coins: 10, isToken: true),
          ShoppingHistoryCard(date: '25/05', coins: 20, item: '1 Cupom R\$ 10'),
          SwapHistoryCard(date: '25/05', to: 'MC 10', from: 'MT 5'),
          HistoryEarnCard(date: '25/05', coins: 10, isToken: true),
          ShoppingHistoryCard(date: '25/05', coins: 20, item: '1 Cupom R\$ 10'),
          SwapHistoryCard(date: '25/05', to: 'MC 10', from: 'MT 5'),
        ],
      ),
      screenActive: NavigationBarActions.history,
      automaticallyImplyLeading: false,
    );
  }
}
