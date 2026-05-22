import 'package:get/get.dart';
import 'package:flutter_project_architecture/data/models/order_model.dart';
import 'package:flutter_project_architecture/data/repositories/app_repository.dart';

class OrdersController extends GetxController {
  final AppRepository repository = AppRepository();
  final orders = <OrderModel>[].obs;
  final loading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadOrders();
  }

  Future<void> loadOrders() async {
    loading.value = true;
    orders.assignAll(await repository.fetchOrders());
    loading.value = false;
  }

  /// Place a new order (demo/in-memory).
  void placeOrder(OrderModel order) {
    orders.insert(0, order);
    orders.refresh();
  }

  void updateStatus(OrderModel order, OrderStatus status) {
    order.status = status;
    orders.refresh();
  }
}
