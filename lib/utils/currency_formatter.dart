import 'package:intl/intl.dart';

String formatCurrency(num value) {
  // Formats numbers as Bangladeshi Taka (BDT) with two decimal places.
  final formatter = NumberFormat.currency(name: 'BDT', symbol: '৳', decimalDigits: 2);
  return formatter.format(value);
}
