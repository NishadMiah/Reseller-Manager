enum WithdrawStatus { pending, approved, rejected }

class WithdrawRequestModel {
  final String id;
  final String userName;
  final String method;
  final double amount;
  final DateTime submittedAt;
  WithdrawStatus status;

  WithdrawRequestModel({
    required this.id,
    required this.userName,
    required this.method,
    required this.amount,
    required this.submittedAt,
    required this.status,
  });
}
