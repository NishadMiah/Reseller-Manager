import 'package:get/get.dart';
import 'package:flutter_project_architecture/modules/admin/views/admin_root_screen.dart';
import 'package:flutter_project_architecture/modules/auth/views/forgot_password_screen.dart';
import 'package:flutter_project_architecture/modules/auth/views/login_screen.dart';
import 'package:flutter_project_architecture/modules/auth/views/otp_verification_screen.dart';
import 'package:flutter_project_architecture/modules/auth/views/onboarding_screen.dart';
import 'package:flutter_project_architecture/modules/auth/views/register_screen.dart';
import 'package:flutter_project_architecture/modules/auth/views/splash_screen.dart';
import 'package:flutter_project_architecture/modules/home/views/home_screen.dart';
import 'package:flutter_project_architecture/modules/home/views/product_detail_screen.dart';
import 'package:flutter_project_architecture/modules/product/views/product_form_screen.dart';
import 'package:flutter_project_architecture/modules/orders/views/order_detail_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String otpVerification = '/otp-verification';
  static const String resellerRoot = '/reseller-root';
  static const String adminRoot = '/admin-root';
  static const String productDetail = '/product-detail';
  static const String orderDetail = '/order-detail';
  static const String productForm = '/product-form';
}

class AppPages {
  static List<GetPage> routes = [
    GetPage(name: AppRoutes.splash, page: () => const SplashScreen()),
    GetPage(name: AppRoutes.onboarding, page: () => const OnboardingScreen()),
    GetPage(name: AppRoutes.login, page: () => const LoginScreen()),
    GetPage(name: AppRoutes.register, page: () => const RegisterScreen()),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordScreen(),
    ),
    GetPage(
      name: AppRoutes.otpVerification,
      page: () => const OtpVerificationScreen(),
    ),
    GetPage(name: AppRoutes.resellerRoot, page: () => const HomeScreen()),
    GetPage(name: AppRoutes.adminRoot, page: () => const AdminRootScreen()),
    GetPage(
      name: AppRoutes.productDetail,
      page: () => const ProductDetailScreen(),
    ),
    GetPage(name: AppRoutes.orderDetail, page: () => const OrderDetailScreen()),
    GetPage(name: AppRoutes.productForm, page: () => const ProductFormScreen()),
  ];
}
