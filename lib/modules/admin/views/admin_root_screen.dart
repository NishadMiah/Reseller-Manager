import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_project_architecture/modules/admin/views/admin_dashboard_screen.dart';
import 'package:flutter_project_architecture/modules/admin/views/admin_orders_screen.dart';
import 'package:flutter_project_architecture/modules/admin/views/admin_products_screen.dart';
import 'package:flutter_project_architecture/modules/admin/views/admin_profile_screen.dart';
import 'package:flutter_project_architecture/modules/admin/views/admin_users_screen.dart';
import 'package:flutter_project_architecture/modules/admin/controllers/admin_controller.dart';
import 'package:flutter_project_architecture/widgets/modern_bottom_navbar.dart';

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
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: ModernBottomNavbar(
            currentIndex: controller.selectedIndex.value,
            onTap: controller.changeTab,
            items: const [
              ModernBottomNavbarItem(
                icon: Icons.dashboard_outlined,
                activeIcon: Icons.dashboard,
                label: 'Dashboard',
              ),
              ModernBottomNavbarItem(
                icon: Icons.receipt_long_outlined,
                activeIcon: Icons.receipt_long,
                label: 'Orders',
              ),
              ModernBottomNavbarItem(
                icon: Icons.group_outlined,
                activeIcon: Icons.group,
                label: 'Users',
              ),
              ModernBottomNavbarItem(
                icon: Icons.inventory_2_outlined,
                activeIcon: Icons.inventory_2,
                label: 'Products',
              ),
              ModernBottomNavbarItem(
                icon: Icons.person_outline,
                activeIcon: Icons.person,
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
