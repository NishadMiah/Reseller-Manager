import 'package:get/get.dart';
import 'package:flutter_project_architecture/data/models/order_model.dart';
import 'package:flutter_project_architecture/data/models/product_model.dart';
import 'package:flutter_project_architecture/data/models/user_model.dart';
import 'package:flutter_project_architecture/data/models/withdraw_request_model.dart';
import 'package:flutter_project_architecture/data/repositories/app_repository.dart';

class AdminController extends GetxController {
  final AppRepository repository = AppRepository();
  final users = <UserModel>[].obs;
  final orders = <OrderModel>[].obs;
  final products = <ProductModel>[].obs;
  final withdrawRequests = <WithdrawRequestModel>[].obs;
  final loading = true.obs;
  final selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadAdminData();
  }

  Future<void> loadAdminData() async {
    loading.value = true;
    users.assignAll(await repository.fetchUsers());
    orders.assignAll(await repository.fetchOrders());
    products.assignAll(await repository.fetchProducts());
    withdrawRequests.assignAll(await repository.fetchWithdrawRequests());
    loading.value = false;
  }

  int get totalUsers => users.length;
  int get totalOrders => orders.length;
  int get pendingOrders =>
      orders.where((element) => element.status == OrderStatus.pending).length;
  double get revenue => orders.fold(0.0, (sum, item) => sum + item.total);

  void approveUser(UserModel user) {
    user.approved = true;
    users.refresh();
  }

  void toggleUserBlock(UserModel user) {
    user.blocked = !user.blocked;
    users.refresh();
  }

  void updateOrderStatus(OrderModel order, OrderStatus status) {
    order.status = status;
    orders.refresh();
  }

  void removeProduct(ProductModel product) {
    products.remove(product);
  }

  void changeTab(int index) {
    selectedIndex.value = index;
  }
}
