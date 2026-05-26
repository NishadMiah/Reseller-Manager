import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_project_architecture/utils/currency_formatter.dart';
import 'package:flutter_project_architecture/core/constants/app_colors.dart';
import 'package:flutter_project_architecture/core/constants/app_sizes.dart';
import 'package:flutter_project_architecture/modules/admin/controllers/admin_controller.dart';
import 'package:flutter_project_architecture/routes/app_pages.dart';
import 'package:flutter_project_architecture/data/models/withdraw_request_model.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AdminController controller = Get.find<AdminController>();
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.padding, vertical: 16),
        child: Obx(() {
          if (controller.loading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'System Overview 👋',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        DateFormat('EEEE, MMM d').format(DateTime.now()),
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.2),
                        width: 2,
                      ),
                    ),
                    child: const CircleAvatar(
                      radius: 22,
                      backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&w=200&q=80',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  _metricCard(
                    label: 'Total Users',
                    value: controller.totalUsers.toString(),
                    icon: Icons.group_rounded,
                    baseColor: AppColors.secondary,
                  ),
                  const SizedBox(width: 14),
                  _metricCard(
                    label: 'Total Orders',
                    value: controller.totalOrders.toString(),
                    icon: Icons.shopping_bag_rounded,
                    baseColor: AppColors.primary,
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  _metricCard(
                    label: 'Pending Orders',
                    value: controller.pendingOrders.toString(),
                    icon: Icons.hourglass_empty_rounded,
                    baseColor: AppColors.warning,
                  ),
                  const SizedBox(width: 14),
                  _metricCard(
                    label: 'Revenue',
                    value: formatCurrency(controller.revenue),
                    icon: Icons.payments_rounded,
                    baseColor: AppColors.success,
                  ),
                ],
              ),
              const SizedBox(height: 28),
              const Text(
                'Withdraw Requests',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 16),
              ...controller.withdrawRequests.map(
                (request) {
                  final isPending = request.status == WithdrawStatus.pending;
                  final isApproved = request.status == WithdrawStatus.approved;

                  Color statusColor = AppColors.warning;
                  if (isApproved) statusColor = AppColors.success;
                  if (request.status == WithdrawStatus.rejected) statusColor = AppColors.danger;

                  return InkWell(
                    onTap: () async {
                      final res = await Get.toNamed(AppRoutes.withdrawDetail, arguments: request);
                      if (res is Map && res['action'] != null) {
                        if (res['action'] == 'approve') {
                          controller.approveWithdrawRequest(request);
                        } else if (res['action'] == 'reject') {
                          controller.rejectWithdrawRequest(request);
                        }
                      }
                    },
                    child: Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: AppColors.border.withValues(alpha: 0.25),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.02),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withValues(alpha: 0.08),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    request.method.toLowerCase().contains('bank')
                                        ? Icons.account_balance_rounded
                                        : Icons.phone_android_rounded,
                                    color: AppColors.primary,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                GestureDetector(
                                  onTap: () {
                                    // try find full user, otherwise pass a minimal placeholder
                                    dynamic found;
                                    try {
                                      found = controller.users.firstWhere((u) => u.name == request.userName);
                                    } catch (e) {
                                      found = null;
                                    }

                                    if (found != null) {
                                      Get.toNamed(AppRoutes.adminUserDetail, arguments: found);
                                    } else {
                                      Get.toNamed(AppRoutes.adminUserDetail, arguments: null);
                                    }
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        request.userName,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${request.method} • ${formatCurrency(request.amount)}',
                                        style: const TextStyle(
                                          color: AppColors.textSecondary,
                                          fontSize: 12.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: statusColor.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                request.status.name.capitalizeFirst!,
                                style: TextStyle(
                                  color: statusColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (isPending) ...[
                          const SizedBox(height: 14),
                          const Divider(height: 1, thickness: 1),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () => controller.rejectWithdrawRequest(request),
                                style: TextButton.styleFrom(
                                  foregroundColor: AppColors.danger,
                                ),
                                child: const Text('Reject'),
                              ),
                              const SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: () => controller.approveWithdrawRequest(request),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.success,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text('Approve'),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ));
                },
              ),
            ],
          );
        }),
      ),
    ));
  }

  Widget _metricCard({
    required String label,
    required String value,
    required IconData icon,
    required Color baseColor,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: baseColor.withValues(alpha: 0.15),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: baseColor.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                      fontSize: 13.5,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: baseColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: baseColor,
                    size: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
