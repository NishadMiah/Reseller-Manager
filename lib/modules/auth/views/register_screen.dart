import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_project_architecture/core/constants/app_colors.dart';
import 'package:flutter_project_architecture/core/constants/app_strings.dart';
import 'package:flutter_project_architecture/modules/auth/controllers/auth_controller.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController controller = Get.find<AuthController>();
    // Reset selected role to reseller upon screen entry
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.prepareRegister();
    });
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: ListView(
            children: [
              const SizedBox(height: 20),
              Text(
                AppStrings.register,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              Text(
                'Create a secure reseller account and start managing orders.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 28),
              TextFormField(
                controller: controller.nameController,
                decoration: InputDecoration(
                  labelText: AppStrings.fullName,
                  prefixIcon: const Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: controller.emailController,
                decoration: InputDecoration(
                  labelText: AppStrings.email,
                  prefixIcon: const Icon(Icons.email_outlined),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: controller.phoneController,
                decoration: InputDecoration(
                  labelText: AppStrings.phoneNumber,
                  prefixIcon: const Icon(Icons.phone_outlined),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: controller.passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: AppStrings.password,
                  prefixIcon: const Icon(Icons.lock_outline),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: controller.confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: AppStrings.confirmPassword,
                  prefixIcon: const Icon(Icons.lock_outline),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.info.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.info.withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.info_outline_rounded,
                      color: AppColors.info,
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Only Reseller accounts can be registered. Contact system administration for Admin access.',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12.5,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Obx(
                () => ElevatedButton(
                  onPressed: controller.loading.value
                      ? null
                      : controller.register,
                  child: controller.loading.value
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(AppStrings.register),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
