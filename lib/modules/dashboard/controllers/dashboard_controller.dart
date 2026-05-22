import 'package:get/get.dart';
import 'package:flutter_project_architecture/data/repositories/app_repository.dart';
import 'package:flutter_project_architecture/data/models/order_model.dart';
import 'package:flutter_project_architecture/data/models/transaction_model.dart';

class DashboardController extends GetxController {
  final AppRepository repository = AppRepository();
  final loading = true.obs;
  final orders = <OrderModel>[].obs;
  final transactions = <TransactionModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadDashboard();
  }

  Future<void> loadDashboard() async {
    loading.value = true;
    orders.assignAll(await repository.fetchOrders());
    transactions.assignAll(await repository.fetchTransactions());
    loading.value = false;
  }

  int get pendingOrders =>
      orders.where((order) => order.status == OrderStatus.pending).length;
  int get completedOrders =>
      orders.where((order) => order.status == OrderStatus.delivered).length;
  double get currentBalance => transactions.fold(
    0.0,
    (sum, item) => sum + (item.credit ? item.amount : -item.amount),
  );
  double get totalEarnings => transactions
      .where((item) => item.credit)
      .fold(0.0, (sum, item) => sum + item.amount);
}
