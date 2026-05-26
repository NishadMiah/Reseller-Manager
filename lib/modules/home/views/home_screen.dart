import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_project_architecture/core/constants/app_colors.dart';
import 'package:flutter_project_architecture/modules/dashboard/views/reseller_dashboard_screen.dart';
import 'package:flutter_project_architecture/modules/home/controllers/home_controller.dart';
import 'package:flutter_project_architecture/modules/home/views/product_list_screen.dart';
import 'package:flutter_project_architecture/modules/orders/views/order_list_screen.dart';
import 'package:flutter_project_architecture/modules/profile/views/profile_screen.dart';
import 'package:flutter_project_architecture/modules/wallet/views/wallet_screen.dart';
import 'package:flutter_project_architecture/widgets/modern_bottom_navbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    final List<Widget> pages = const [
      ResellerDashboardScreen(),
      ProductListScreen(),
      OrderListScreen(),
      WalletScreen(),
      ProfileScreen(),
    ];
    return Obx(
      () => Scaffold(
        extendBody: true,
        backgroundColor: AppColors.background,
        body: pages[controller.selectedIndex.value],
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: ModernBottomNavbar(
            currentIndex: controller.selectedIndex.value,
            onTap: controller.changeTab,
            items: const [
              ModernBottomNavbarItem(
                icon: Icons.dashboard_customize_outlined,
                activeIcon: Icons.dashboard_customize,
                label: 'Dashboard',
              ),
              ModernBottomNavbarItem(
                icon: Icons.grid_view_outlined,
                activeIcon: Icons.grid_view_rounded,
                label: 'Products',
              ),
              ModernBottomNavbarItem(
                icon: Icons.receipt_long_outlined,
                activeIcon: Icons.receipt_long,
                label: 'Orders',
              ),
              ModernBottomNavbarItem(
                icon: Icons.account_balance_wallet_outlined,
                activeIcon: Icons.account_balance_wallet,
                label: 'Wallet',
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
