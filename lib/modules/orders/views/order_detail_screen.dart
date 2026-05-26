// 'dart:ui' import removed — not required when using 'package:flutter/material.dart'

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_project_architecture/utils/currency_formatter.dart';
import 'package:flutter_project_architecture/core/constants/app_colors.dart';
import 'package:flutter_project_architecture/core/constants/app_sizes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_project_architecture/data/models/order_model.dart';
import 'package:flutter_project_architecture/widgets/order_status_chip.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderModel order = Get.arguments as OrderModel;
    final statusColor = _statusColor(order.status);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Order Details',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Background gradient
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 260,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    statusColor.withValues(alpha: 0.12),
                    Colors.transparent,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          SafeArea(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.padding,
                vertical: 10,
              ),
              children: [
                // Product Image Hero
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: CachedNetworkImage(
                    imageUrl: order.imageUrl,
                    width: double.infinity,
                    height: 220,
                    fit: BoxFit.cover,
                    placeholder: (c, u) => Container(
                      height: 220,
                      color: AppColors.surfaceElevated,
                    ),
                    errorWidget: (c, u, e) => Container(
                      height: 220,
                      color: AppColors.surfaceElevated,
                      child: const Icon(
                        Icons.broken_image_rounded,
                        color: AppColors.textSecondary,
                        size: 40,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Product name & status
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        order.productName,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ),
                    OrderStatusChip(status: order.status),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  'Order #${order.id}',
                  style: TextStyle(
                    color: AppColors.textSecondary.withValues(alpha: 0.7),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 24),
                // Customer Info Card
                _buildSectionCard(
                  title: 'Customer Information',
                  icon: Icons.person_rounded,
                  iconColor: AppColors.info,
                  children: [
                    _buildInfoRow(
                      Icons.badge_outlined,
                      'Customer Name',
                      order.customerName,
                    ),
                    _buildInfoRow(
                      Icons.phone_outlined,
                      'Phone Number',
                      order.customerPhone,
                    ),
                    _buildInfoRow(
                      Icons.location_on_outlined,
                      'Delivery Address',
                      order.address,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Order Details Card
                _buildSectionCard(
                  title: 'Order Summary',
                  icon: Icons.receipt_long_rounded,
                  iconColor: AppColors.primary,
                  children: [
                    _buildInfoRow(
                      Icons.shopping_bag_outlined,
                      'Quantity',
                      '${order.quantity} pcs',
                    ),
                    _buildInfoRow(
                      Icons.payment_outlined,
                      'Payment Method',
                      order.paymentMethod,
                    ),
                    _buildInfoRow(
                      Icons.calendar_today_outlined,
                      'Order Date',
                      DateFormat.yMMMMd().format(order.createdAt),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Total Amount Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary.withValues(alpha: 0.06),
                        AppColors.secondary.withValues(alpha: 0.03),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.12),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Amount',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Including all charges',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        formatCurrency(order.total),
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          color: AppColors.primary,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                // Status Timeline
                const Text(
                  'Order Timeline',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: AppColors.border.withValues(alpha: 0.12),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.02),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: OrderStatus.values.asMap().entries.map((entry) {
                      final status = entry.value;
                      final isLast = entry.key == OrderStatus.values.length - 1;
                      final active = status.index <= order.status.index;
                      final isCurrent = status == order.status;
                      return _buildTimelineStep(
                        status: status,
                        active: active,
                        isCurrent: isCurrent,
                        isLast: isLast,
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Color iconColor,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: AppColors.border.withValues(alpha: 0.12),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: iconColor, size: 18),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 16,
            color: AppColors.textSecondary.withValues(alpha: 0.6),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineStep({
    required OrderStatus status,
    required bool active,
    required bool isCurrent,
    required bool isLast,
  }) {
    final color = active ? AppColors.primary : AppColors.border;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: active
                    ? AppColors.primary.withValues(alpha: 0.1)
                    : AppColors.surfaceElevated,
                border: Border.all(
                  color: active ? AppColors.primary : AppColors.border,
                  width: isCurrent ? 3 : 2,
                ),
              ),
              child: Icon(
                active ? Icons.check_rounded : Icons.circle_outlined,
                size: 14,
                color: active ? AppColors.primary : AppColors.border,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 32,
                color: color.withValues(alpha: 0.3),
              ),
          ],
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  status.name.capitalizeFirst!,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isCurrent ? FontWeight.w800 : FontWeight.w600,
                    color: active
                        ? AppColors.textPrimary
                        : AppColors.textSecondary,
                  ),
                ),
                if (isCurrent)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      'Current status',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary.withValues(alpha: 0.7),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Color _statusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return AppColors.warning;
      case OrderStatus.accepted:
        return AppColors.info;
      case OrderStatus.processing:
        return AppColors.primary;
      case OrderStatus.shipped:
        return AppColors.secondary;
      case OrderStatus.delivered:
        return AppColors.success;
      case OrderStatus.cancelled:
        return AppColors.danger;
    }
  }
}
