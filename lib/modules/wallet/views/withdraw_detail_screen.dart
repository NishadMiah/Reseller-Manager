import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_project_architecture/core/constants/app_colors.dart';
import 'package:flutter_project_architecture/core/constants/app_sizes.dart';
import 'package:flutter_project_architecture/data/models/withdraw_request_model.dart';

class WithdrawDetailScreen extends StatelessWidget {
  const WithdrawDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final WithdrawRequestModel? request =
        Get.arguments as WithdrawRequestModel?;
    if (request == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Withdraw')),
        body: const Center(child: Text('No request data')),
      );
    }

    final formatter = NumberFormat.simpleCurrency(locale: 'en_US');

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text('Withdraw Request'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.padding),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppSizes.borderRadius),
                boxShadow: [AppSizes.cardShadow],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            request.userName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            request.method,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: _statusColor(
                            request.status,
                          ).withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          request.status.name.capitalizeFirst!,
                          style: TextStyle(
                            color: _statusColor(request.status),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    formatter.format(request.amount),
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 14,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        DateFormat.yMMMMd().add_jm().format(
                          request.submittedAt,
                        ),
                        style: const TextStyle(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  const Divider(),
                  const SizedBox(height: 12),
                  const Text(
                    'Details',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 8),
                  Text('Request ID: ${request.id}'),
                  const SizedBox(height: 6),
                  Text('Method: ${request.method}'),
                  const SizedBox(height: 6),
                  Text(
                    'Submitted: ${DateFormat.yMMMd().format(request.submittedAt)}',
                  ),
                  const SizedBox(height: 18),
                  if (request.status == WithdrawStatus.pending) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Get.back(
                              result: {'action': 'reject', 'id': request.id},
                            );
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.danger,
                          ),
                          child: const Text('Reject'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            Get.back(
                              result: {'action': 'approve', 'id': request.id},
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.success,
                          ),
                          child: const Text('Approve'),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _statusColor(WithdrawStatus status) {
    switch (status) {
      case WithdrawStatus.approved:
        return AppColors.success;
      case WithdrawStatus.rejected:
        return AppColors.danger;
      default:
        return AppColors.warning;
    }
  }
}
