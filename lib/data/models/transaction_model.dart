class TransactionModel {
  final String id;
  final String description;
  final DateTime date;
  final double amount;
  final bool credit;

  TransactionModel({
    required this.id,
    required this.description,
    required this.date,
    required this.amount,
    required this.credit,
  });
}
