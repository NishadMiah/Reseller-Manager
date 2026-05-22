import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_project_architecture/data/models/transaction_model.dart';
import 'package:flutter_project_architecture/data/models/withdraw_request_model.dart';
import 'package:flutter_project_architecture/data/repositories/app_repository.dart';

class WalletController extends GetxController {
  final AppRepository repository = AppRepository();
  final transactions = <TransactionModel>[].obs;
  final withdrawRequests = <WithdrawRequestModel>[].obs;
  final loading = true.obs;
  final amountController = TextEditingController();
  final method = 'bKash'.obs;

  @override
  void onInit() {
    super.onInit();
    loadWallet();
  }

  Future<void> loadWallet() async {
    loading.value = true;
    transactions.assignAll(await repository.fetchTransactions());
    withdrawRequests.assignAll(await repository.fetchWithdrawRequests());
    loading.value = false;
  }

  double get walletBalance => transactions.fold(
    0.0,
    (sum, item) => sum + (item.credit ? item.amount : -item.amount),
  );

  void submitWithdraw() {
    final amount = double.tryParse(amountController.text) ?? 0;
    if (amount <= 0) {
      Get.snackbar('Validation', 'Enter a valid amount');
      return;
    }
    withdrawRequests.add(
      WithdrawRequestModel(
        id: 'wd${withdrawRequests.length + 1}',
        userName: 'Current Reseller',
        method: method.value,
        amount: amount,
        submittedAt: DateTime.now(),
        status: WithdrawStatus.pending,
      ),
    );
    amountController.clear();
    Get.snackbar('Success', 'Withdraw request submitted');
  }
}
