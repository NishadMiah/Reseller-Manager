import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_project_architecture/core/constants/app_colors.dart';
import 'package:flutter_project_architecture/core/constants/app_sizes.dart';
import 'package:flutter_project_architecture/modules/admin/views/admin_dashboard_screen.dart';
import 'package:flutter_project_architecture/modules/admin/views/admin_orders_screen.dart';
import 'package:flutter_project_architecture/modules/admin/views/admin_products_screen.dart';
import 'package:flutter_project_architecture/modules/admin/views/admin_profile_screen.dart';
import 'package:flutter_project_architecture/modules/admin/views/admin_users_screen.dart';
import 'package:flutter_project_architecture/modules/admin/controllers/admin_controller.dart';

class AdminRootScreen extends StatelessWidget {
  const AdminRootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AdminController controller = Get.put(AdminController());
    final pages = const [
      AdminDashboardScreen(),
      AdminOrdersScreen(),
      AdminUsersScreen(),
      AdminProductsScreen(),
      AdminProfileScreen(),
    ];
    return Obx(
      () => Scaffold(
        extendBody: true,
        body: pages[controller.selectedIndex.value],
        bottomNavigationBar: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [AppSizes.cardShadow],
          ),
          child: BottomNavigationBar(
            currentIndex: controller.selectedIndex.value,
            onTap: controller.changeTab,
            backgroundColor: Colors.transparent,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.textSecondary,
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_outlined),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long_outlined),
                label: 'Orders',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.group_outlined),
                label: 'Users',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.inventory_2_outlined),
                label: 'Products',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
