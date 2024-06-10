import 'package:intl/intl.dart';

String convertCurrency(String? input, double currency) {
  if (input == null || input.isEmpty) return '0';

  NumberFormat formatter = NumberFormat.decimalPatternDigits(locale: 'pt_BR');
  double value = formatter.parse(input).toDouble();
  double convertedValue = value * currency;

  return formatter.format(convertedValue);
}
