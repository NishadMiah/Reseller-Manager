import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_project_architecture/data/models/user_model.dart';
import 'package:flutter_project_architecture/routes/app_pages.dart';

class ProfileController extends GetxController {
  final nameController = TextEditingController(text: 'Nasir Ahmed');
  final emailController = TextEditingController(text: 'nasir@example.com');
  final phoneController = TextEditingController(text: '+880 1711 223344');
  final loading = false.obs;
  final selectedRole = UserRole.reseller.obs;

  void logout() {
    Get.offAllNamed(AppRoutes.login);
  }

  Future<void> saveProfile() async {
    loading.value = true;
    await Future<void>.delayed(const Duration(milliseconds: 600));
    loading.value = false;
    Get.snackbar('Profile', 'Profile updated successfully');
  }
}
