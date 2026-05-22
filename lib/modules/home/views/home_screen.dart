import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_project_architecture/core/constants/app_colors.dart';
import 'package:flutter_project_architecture/core/constants/app_sizes.dart';
import 'package:flutter_project_architecture/modules/dashboard/views/reseller_dashboard_screen.dart';
import 'package:flutter_project_architecture/modules/home/controllers/home_controller.dart';
import 'package:flutter_project_architecture/modules/home/views/product_list_screen.dart';
import 'package:flutter_project_architecture/modules/orders/views/order_list_screen.dart';
import 'package:flutter_project_architecture/modules/profile/views/profile_screen.dart';
import 'package:flutter_project_architecture/modules/wallet/views/wallet_screen.dart';

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
        bottomNavigationBar: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [AppSizes.cardShadow],
          ),
          child: BottomNavigationBar(
            currentIndex: controller.selectedIndex.value,
            elevation: 0,
            backgroundColor: Colors.transparent,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.textSecondary,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            onTap: controller.changeTab,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_customize_outlined),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.grid_view_outlined),
                label: 'Products',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long_outlined),
                label: 'Orders',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_wallet_outlined),
                label: 'Wallet',
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
