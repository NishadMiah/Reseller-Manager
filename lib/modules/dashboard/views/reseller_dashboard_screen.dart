import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_project_architecture/core/constants/app_colors.dart';
import 'package:flutter_project_architecture/core/constants/app_sizes.dart';
import 'package:flutter_project_architecture/core/constants/app_strings.dart';
import 'package:flutter_project_architecture/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:flutter_project_architecture/routes/app_pages.dart';
import 'package:flutter_project_architecture/widgets/order_status_chip.dart';

class ResellerDashboardScreen extends StatelessWidget {
  const ResellerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DashboardController controller = Get.put(DashboardController());
    final formatter = NumberFormat.simpleCurrency(locale: 'en_US');
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.padding),
          child: Obx(() {
            if (controller.loading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Text(
                  'Good morning, Reseller',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 6),
                Text(
                  'Your dashboard is ready for action.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    _summaryCard(
                      'Balance',
                      formatter.format(controller.currentBalance),
                      AppColors.info,
                    ),
                    const SizedBox(width: 14),
                    _summaryCard(
                      'Earnings',
                      formatter.format(controller.totalEarnings),
                      AppColors.success,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _summaryCard(
                      'Pending',
                      '${controller.pendingOrders}',
                      AppColors.warning,
                      flex: 1,
                    ),
                    const SizedBox(width: 14),
                    _summaryCard(
                      'Delivered',
                      '${controller.completedOrders}',
                      AppColors.primary,
                      flex: 1,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  AppStrings.recentOrders,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 14),
                Expanded(
                  child: ListView.separated(
                    itemCount: controller.orders.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 14),
                    itemBuilder: (context, index) {
                      final order = controller.orders[index];
                      return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(
                            AppSizes.borderRadius,
                          ),
                          boxShadow: [AppSizes.cardShadow],
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: CachedNetworkImage(
                                imageUrl: order.imageUrl,
                                height: 66,
                                width: 66,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Container(
                                  height: 66,
                                  width: 66,
                                  color: AppColors.surfaceElevated,
                                ),
                                errorWidget: (context, url, error) => Container(
                                  height: 66,
                                  width: 66,
                                  color: AppColors.surfaceElevated,
                                  child: const Icon(
                                    Icons.broken_image,
                                    size: 24,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    order.productName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    order.customerName,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium,
                                  ),
                                  const SizedBox(height: 10),
                                  OrderStatusChip(status: order.status),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () => Get.toNamed(
                                AppRoutes.orderDetail,
                                arguments: order,
                              ),
                              icon: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _summaryCard(String title, String value, Color color, {int flex = 2}) {
    return Expanded(
      flex: flex,
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.borderRadius),
          gradient: LinearGradient(
            colors: [color.withValues(alpha: 41), AppColors.surface],
          ),
          boxShadow: [AppSizes.cardShadow],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: AppColors.textSecondary)),
            const Spacer(),
            Text(
              value,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
