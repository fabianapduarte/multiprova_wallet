import 'package:flutter_test/flutter_test.dart';

import 'package:multiprova_wallet/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MultiprovaWallet());
  });
}
