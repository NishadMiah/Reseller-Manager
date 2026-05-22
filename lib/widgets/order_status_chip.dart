import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_project_architecture/data/models/order_model.dart';
import 'package:flutter_project_architecture/core/constants/app_colors.dart';

class OrderStatusChip extends StatelessWidget {
  final OrderStatus status;
  const OrderStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 36),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        status.name.capitalizeFirst!,
        style: TextStyle(
          color: statusColor,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }

  Color get statusColor {
    switch (status) {
      case OrderStatus.pending:
        return AppColors.textSecondary;
      case OrderStatus.accepted:
        return AppColors.success;
      case OrderStatus.processing:
        return AppColors.warning;
      case OrderStatus.shipped:
        return AppColors.info;
      case OrderStatus.delivered:
        return AppColors.primary;
      case OrderStatus.cancelled:
        return AppColors.danger;
    }
  }
}
