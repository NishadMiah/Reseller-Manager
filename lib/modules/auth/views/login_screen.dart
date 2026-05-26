import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_project_architecture/core/constants/app_colors.dart';
import 'package:flutter_project_architecture/core/constants/app_strings.dart';
import 'package:flutter_project_architecture/modules/auth/controllers/auth_controller.dart';
import 'package:flutter_project_architecture/routes/app_pages.dart';
import 'package:flutter_project_architecture/widgets/modern_role_selector.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController controller = Get.put(AuthController());
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 14),
          child: ListView(
            children: [
              const SizedBox(height: 28),
              Text(
                AppStrings.login,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              Text(
                'Continue as reseller or admin to manage your business.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 32),
              Obx(
                () => ModernRoleSelector(
                  selectedRole: controller.selectedRole.value,
                  onRoleChanged: controller.changeRole,
                ),
              ),
              const SizedBox(height: 28),
              TextFormField(
                controller: controller.emailController,
                decoration: InputDecoration(
                  labelText: AppStrings.email,
                  prefixIcon: const Icon(Icons.email_outlined),
                ),
              ),
              const SizedBox(height: 18),
              TextFormField(
                controller: controller.passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: AppStrings.password,
                  prefixIcon: const Icon(Icons.lock_outline),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Obx(
                    () => Checkbox(
                      value: controller.rememberMe.value,
                      onChanged: controller.toggleRememberMe,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      AppStrings.rememberMe,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Get.toNamed(AppRoutes.forgotPassword),
                    child: const Text(AppStrings.forgotPassword),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Obx(
                () => ElevatedButton(
                  onPressed: controller.loading.value ? null : controller.login,
                  child: controller.loading.value
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(AppStrings.login),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don’t have an account? '),
                  TextButton(
                    onPressed: () => Get.toNamed(AppRoutes.register),
                    child: const Text(AppStrings.register),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
