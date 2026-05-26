import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_project_architecture/core/constants/app_colors.dart';
import 'package:flutter_project_architecture/core/constants/app_sizes.dart';
import 'package:flutter_project_architecture/modules/profile/controllers/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Gradient App Bar with overlay
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: AppColors.background,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.primary, AppColors.secondary],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  // Decorative bubbles
                  Positioned(
                    right: -40,
                    top: -40,
                    child: Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.06),
                      ),
                    ),
                  ),
                  Positioned(
                    left: -30,
                    bottom: -50,
                    child: Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.04),
                      ),
                    ),
                  ),
                  // Profile Info Overlay
                  SafeArea(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 20),
                          // Gradient ring avatar
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.5),
                                width: 3,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.2),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: const CircleAvatar(
                              radius: 44,
                              backgroundColor: Colors.white24,
                              child: Icon(
                                Icons.person_rounded,
                                size: 48,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          ValueListenableBuilder<TextEditingValue>(
                            valueListenable: controller.nameController,
                            builder: (_, value, __) {
                              final name = value.text.isNotEmpty
                                  ? value.text
                                  : 'Reseller';
                              return Text(
                                name,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                  letterSpacing: -0.5,
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.2),
                              ),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.star_rounded,
                                  size: 14,
                                  color: Colors.amber,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  'Premium Reseller',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Quick Stats Row
                  Row(
                    children: [
                      _buildStatItem(
                        icon: Icons.shopping_bag_rounded,
                        label: 'Orders',
                        value: '24',
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 12),
                      _buildStatItem(
                        icon: Icons.payments_rounded,
                        label: 'Earnings',
                        value: '৳12,400',
                        color: AppColors.success,
                      ),
                      const SizedBox(width: 12),
                      _buildStatItem(
                        icon: Icons.trending_up_rounded,
                        label: 'Growth',
                        value: '+18%',
                        color: AppColors.info,
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  // Personal Info Section
                  const Text(
                    'Personal Information',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 14),
                  _buildInputCard(
                    children: [
                      _buildFormField(
                        controller: controller.nameController,
                        label: 'Full Name',
                        icon: Icons.person_outline_rounded,
                      ),
                      const Divider(height: 1),
                      _buildFormField(
                        controller: controller.emailController,
                        label: 'Email Address',
                        icon: Icons.email_outlined,
                      ),
                      const Divider(height: 1),
                      _buildFormField(
                        controller: controller.phoneController,
                        label: 'Phone Number',
                        icon: Icons.phone_outlined,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Save changes button
                  SizedBox(
                    width: double.infinity,
                    child: Obx(
                      () => ElevatedButton(
                        onPressed: controller.loading.value
                            ? null
                            : controller.saveProfile,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: controller.loading.value
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                'Save Changes',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  // Account Settings Section
                  const Text(
                    'Account Settings',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 14),
                  _buildInputCard(
                    children: [
                      _buildSettingTile(
                        icon: Icons.lock_outline_rounded,
                        title: 'Change Password',
                        subtitle: 'Update your account password',
                        onTap: () => Get.snackbar(
                          'Security',
                          'Navigating to change password...',
                        ),
                      ),
                      const Divider(height: 1),
                      _buildSettingTile(
                        icon: Icons.notifications_outlined,
                        title: 'Notifications',
                        subtitle: 'Manage push & email alerts',
                        onTap: () =>
                            Get.snackbar('Notifications', 'Coming soon...'),
                      ),
                      const Divider(height: 1),
                      _buildSettingTile(
                        icon: Icons.language_rounded,
                        title: 'Language',
                        subtitle: 'English (Bangladesh)',
                        onTap: () => Get.snackbar('Language', 'Coming soon...'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  // Danger zone
                  const Text(
                    'Account Actions',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 14),
                  _buildInputCard(
                    children: [
                      _buildSettingTile(
                        icon: Icons.workspace_premium_rounded,
                        title: 'Upgrade to Premium',
                        subtitle: 'Unlock premium features & benefits',
                        iconColor: AppColors.secondary,
                        onTap: () => Get.snackbar(
                          'Upgrade',
                          'Upgrade flow not implemented.',
                        ),
                      ),
                      const Divider(height: 1),
                      _buildSettingTile(
                        icon: Icons.logout_rounded,
                        title: 'Logout',
                        subtitle: 'Sign out of your account',
                        iconColor: AppColors.danger,
                        titleColor: AppColors.danger,
                        onTap: controller.logout,
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  // App version
                  Center(
                    child: Text(
                      'Reseller Manager v1.0.0',
                      style: TextStyle(
                        color: AppColors.textSecondary.withValues(alpha: 0.5),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
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

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: color.withValues(alpha: 0.12), width: 1),
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
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 18),
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputCard({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(children: children),
      ),
    );
  }

  Widget _buildFormField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
          prefixIcon: Icon(icon, size: 20, color: AppColors.textSecondary),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? iconColor,
    Color? titleColor,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: (iconColor ?? AppColors.primary).withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: iconColor ?? AppColors.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: titleColor ?? AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textSecondary.withValues(alpha: 0.4),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
