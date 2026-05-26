import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_project_architecture/core/constants/app_sizes.dart';
import 'package:flutter_project_architecture/core/constants/app_colors.dart';
import 'package:flutter_project_architecture/data/models/user_model.dart';

class AdminUserDetailScreen extends StatelessWidget {
  const AdminUserDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserModel? user = Get.arguments as UserModel?;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('User')),
        body: const Center(child: Text('No user data')),
      );
    }

    final isReseller = user.role != UserRole.admin;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'User Profile Details',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Dynamic soft gradient behind header
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 280,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    (isReseller ? AppColors.secondary : AppColors.primary).withValues(alpha: 0.15),
                    Colors.transparent,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.padding),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  const SizedBox(height: 10),
                  // Premium user details header card
                  Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: AppColors.border.withValues(alpha: 0.15),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.02),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Avatar outline with gradient
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: isReseller
                                  ? [AppColors.secondary, AppColors.info]
                                  : [AppColors.primary, AppColors.success],
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 46,
                            backgroundImage: NetworkImage(user.avatar),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          user.name,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: (isReseller ? AppColors.secondary : AppColors.primary).withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: (isReseller ? AppColors.secondary : AppColors.primary).withValues(alpha: 0.15),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            user.role.name.capitalizeFirst!,
                            style: TextStyle(
                              color: isReseller ? AppColors.secondary : AppColors.primary,
                              fontWeight: FontWeight.w800,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Divider(height: 1),
                        const SizedBox(height: 20),
                        _buildContactRow(Icons.email_outlined, 'Email Address', user.email),
                        const SizedBox(height: 16),
                        _buildContactRow(Icons.phone_outlined, 'Phone Number', user.phone),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'User Statistics & Status',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 14),
                  // User info grid
                  Row(
                    children: [
                      _buildStatCard(
                        title: 'Approval Status',
                        value: user.approved ? 'Approved' : 'Pending',
                        icon: Icons.verified_user_rounded,
                        color: user.approved ? AppColors.success : AppColors.warning,
                      ),
                      const SizedBox(width: 14),
                      _buildStatCard(
                        title: 'Account Status',
                        value: user.blocked ? 'Blocked' : 'Active',
                        icon: Icons.gpp_maybe_rounded,
                        color: user.blocked ? AppColors.danger : AppColors.success,
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Administrative Actions',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Get.snackbar('Action', 'Toggled approval status');
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: user.approved ? AppColors.danger : AppColors.success,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            side: BorderSide(
                              color: user.approved ? AppColors.danger : AppColors.success,
                              width: 1.5,
                            ),
                          ),
                          child: Text(
                            user.approved ? 'Revoke Approval' : 'Approve Account',
                            style: const TextStyle(fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Get.snackbar('Action', 'Toggled block status');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: user.blocked ? AppColors.success : AppColors.danger,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            user.blocked ? 'Unblock User' : 'Block User',
                            style: const TextStyle(fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.surfaceElevated,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            size: 18,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(width: 14),
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
              const SizedBox(height: 2),
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
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: color.withValues(alpha: 0.15),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                Icon(
                  icon,
                  color: color,
                  size: 16,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
