import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_project_architecture/core/constants/app_colors.dart';
import 'package:flutter_project_architecture/core/constants/app_sizes.dart';
import 'package:flutter_project_architecture/modules/profile/controllers/profile_controller.dart';
import 'package:flutter_project_architecture/widgets/custom_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.padding),
        child: ListView(
          children: [
            // Premium glassmorphism card with gradient background
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.borderRadius),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.surface.withValues(alpha: 0.6),
                        AppColors.surfaceElevated.withValues(alpha: 0.3),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(AppSizes.borderRadius),
                    border: Border.all(
                      color: AppColors.surfaceElevated.withValues(alpha: 0.2),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(18),
                  child: Row(
                    children: [
                      // Avatar placeholder with gradient border
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [AppColors.primary, AppColors.secondary],
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.person,
                            size: 42,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Nasir Ahmed',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Reseller',
                            style: TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: controller.nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: controller.emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: controller.phoneController,
              decoration: const InputDecoration(labelText: 'Phone'),
            ),
            const SizedBox(height: 22),
            Obx(
              () => ElevatedButton(
                onPressed: controller.loading.value
                    ? null
                    : controller.saveProfile,
                child: controller.loading.value
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text('Save Changes'),
              ),
            ),
            const SizedBox(height: 14),
            CustomButton(
              label: 'Change Password',
              onPressed: () =>
                  Get.snackbar('Security', 'Navigating to change password...'),
              filled: false,
            ),
            const SizedBox(height: 14),
            CustomButton(
              label: 'Logout',
              onPressed: controller.logout,
              filled: false,
              color: AppColors.danger,
            ),
          ],
        ),
      ),
    );
  }
}
