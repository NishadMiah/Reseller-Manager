import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_project_architecture/data/models/user_model.dart';
import 'package:flutter_project_architecture/routes/app_pages.dart';
import 'package:flutter_project_architecture/services/local_storage_service.dart';

class AuthController extends GetxController {
  final LocalStorageService storage = Get.find<LocalStorageService>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController otpController = TextEditingController();

  final selectedRole = UserRole.reseller.obs;
  final rememberMe = false.obs;
  final loading = false.obs;

  String get currentRoleLabel =>
      selectedRole.value == UserRole.admin ? 'Admin' : 'Reseller';

  void changeRole(UserRole role) {
    selectedRole.value = role;
    storage.saveSelectedRole(role.name);
  }

  void toggleRememberMe(bool? value) {
    rememberMe.value = value ?? false;
  }

  bool validateCredentials() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar(
        'Validation',
        'Please enter email and password',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
    return true;
  }

  Future<void> login() async {
    if (!validateCredentials()) return;
    loading.value = true;
    await Future<void>.delayed(const Duration(milliseconds: 700));
    if (rememberMe.value) {
      await storage.saveRememberMe(true);
      await storage.saveUserEmail(emailController.text.trim());
      await storage.saveSelectedRole(selectedRole.value.name);
    }
    loading.value = false;
    if (selectedRole.value == UserRole.admin) {
      Get.offAllNamed(AppRoutes.adminRoot);
    } else {
      Get.offAllNamed(AppRoutes.resellerRoot);
    }
  }

  Future<void> register() async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      Get.snackbar(
        'Validation',
        'All fields are required',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar(
        'Validation',
        'Passwords do not match',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    loading.value = true;
    await Future<void>.delayed(const Duration(milliseconds: 700));
    loading.value = false;
    Get.offAllNamed(AppRoutes.login);
    Get.snackbar('Success', 'Account created. Please login.');
  }

  Future<void> sendForgotPasswordLink() async {
    if (emailController.text.isEmpty) {
      Get.snackbar(
        'Validation',
        'Please enter your email',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    loading.value = true;
    await Future<void>.delayed(const Duration(milliseconds: 700));
    loading.value = false;
    Get.toNamed(AppRoutes.otpVerification);
  }

  Future<void> verifyOtp() async {
    if (otpController.text.length < 4) {
      Get.snackbar(
        'Validation',
        'Please enter the OTP',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    loading.value = true;
    await Future<void>.delayed(const Duration(milliseconds: 700));
    loading.value = false;
    Get.offAllNamed(AppRoutes.login);
    Get.snackbar('Success', 'OTP verified. Please login.');
  }
}
