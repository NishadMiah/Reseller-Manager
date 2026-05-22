import 'package:flutter_project_architecture/data/models/category_model.dart';
import 'package:flutter_project_architecture/data/models/order_model.dart';
import 'package:flutter_project_architecture/data/models/product_model.dart';
import 'package:flutter_project_architecture/data/models/transaction_model.dart';
import 'package:flutter_project_architecture/data/models/user_model.dart';
import 'package:flutter_project_architecture/data/models/withdraw_request_model.dart';

class AppRepository {
  final List<CategoryModel> categories = [
    CategoryModel(id: 'cat1', title: 'Phones', icon: 'assets/icons/mobile.svg'),
    CategoryModel(id: 'cat2', title: 'Shoes', icon: 'assets/icons/shoes.svg'),
    CategoryModel(
      id: 'cat3',
      title: 'Accessories',
      icon: 'assets/icons/accessory.svg',
    ),
    CategoryModel(id: 'cat4', title: 'Fashion', icon: 'assets/icons/shirt.svg'),
  ];

  final List<ProductModel> products = [
    ProductModel(
      id: 'prod1',
      name: 'Premium Smartwatch',
      category: 'Accessories',
      images: [
        'https://images.unsplash.com/photo-1516574187841-cb9cc2ca948b?auto=format&fit=crop&w=900&q=80',
        'https://images.unsplash.com/photo-1580910051071-cbea75420b12?auto=format&fit=crop&w=900&q=80',
      ],
      stock: 16,
      price: 99.99,
      cost: 54.50,
      description:
          'Modern smartwatch with fitness tracking, premium finish, and multi-day battery.',
      rating: 4.8,
      featured: true,
    ),
    ProductModel(
      id: 'prod2',
      name: 'Minimal Running Sneakers',
      category: 'Shoes',
      images: [
        'https://images.unsplash.com/photo-1516574187841-cb9cc2ca948b?auto=format&fit=crop&w=900&q=80',
      ],
      stock: 32,
      price: 69.99,
      cost: 35.00,
      description:
          'Comfortable lightweight sneakers designed for daily performance and style.',
      rating: 4.6,
    ),
    ProductModel(
      id: 'prod3',
      name: 'Classic Leather Wallet',
      category: 'Accessories',
      images: [
        'https://images.unsplash.com/photo-1490367532201-b9bc1dc483f6?auto=format&fit=crop&w=900&q=80',
      ],
      stock: 12,
      price: 29.90,
      cost: 12.20,
      description:
          'Premium leather wallet with minimalist compartments and RFID protection.',
      rating: 4.5,
    ),
    ProductModel(
      id: 'prod4',
      name: 'Soft Linen Shirt',
      category: 'Fashion',
      images: [
        'https://images.unsplash.com/photo-1490367532201-b9bc1dc483f6?auto=format&fit=crop&w=900&q=80',
      ],
      stock: 20,
      price: 48.00,
      cost: 18.00,
      description:
          'Lightweight linen shirt with relaxed fit and premium tailoring.',
      rating: 4.4,
    ),
  ];

  final List<OrderModel> orders = [
    OrderModel(
      id: 'ord1',
      productName: 'Premium Smartwatch',
      customerName: 'Sana Ahmed',
      customerPhone: '+880 1755 123456',
      address: 'Dhanmondi, Dhaka',
      total: 199.98,
      quantity: 2,
      createdAt: DateTime.now().subtract(const Duration(hours: 6)),
      status: OrderStatus.processing,
      paymentMethod: 'bKash',
      imageUrl:
          'https://images.unsplash.com/photo-1516574187841-cb9cc2ca948b?auto=format&fit=crop&w=900&q=80',
    ),
    OrderModel(
      id: 'ord2',
      productName: 'Minimal Running Sneakers',
      customerName: 'Arif Rahman',
      customerPhone: '+880 1811 987654',
      address: 'Banani, Dhaka',
      total: 69.99,
      quantity: 1,
      createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
      status: OrderStatus.pending,
      paymentMethod: 'Bank Account',
      imageUrl:
          'https://images.unsplash.com/photo-1516574187841-cb9cc2ca948b?auto=format&fit=crop&w=900&q=80',
    ),
    OrderModel(
      id: 'ord3',
      productName: 'Soft Linen Shirt',
      customerName: 'Naila Khan',
      customerPhone: '+880 1912 345678',
      address: 'Gulshan, Dhaka',
      total: 48.00,
      quantity: 1,
      createdAt: DateTime.now().subtract(const Duration(days: 2, hours: 5)),
      status: OrderStatus.delivered,
      paymentMethod: 'Nagad',
      imageUrl:
          'https://images.unsplash.com/photo-1490367532201-b9bc1dc483f6?auto=format&fit=crop&w=900&q=80',
    ),
  ];

  final List<TransactionModel> transactions = [
    TransactionModel(
      id: 'txn1',
      description: 'Order received',
      date: DateTime.now().subtract(const Duration(hours: 4)),
      amount: 199.98,
      credit: true,
    ),
    TransactionModel(
      id: 'txn2',
      description: 'Withdraw request',
      date: DateTime.now().subtract(const Duration(days: 1)),
      amount: 120.00,
      credit: false,
    ),
    TransactionModel(
      id: 'txn3',
      description: 'Commission payout',
      date: DateTime.now().subtract(const Duration(days: 2)),
      amount: 75.50,
      credit: true,
    ),
  ];

  final List<WithdrawRequestModel> withdrawRequests = [
    WithdrawRequestModel(
      id: 'wd1',
      userName: 'Sana Ahmed',
      method: 'bKash',
      amount: 120.0,
      submittedAt: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
      status: WithdrawStatus.pending,
    ),
    WithdrawRequestModel(
      id: 'wd2',
      userName: 'Arif Rahman',
      method: 'Bank Account',
      amount: 320.5,
      submittedAt: DateTime.now().subtract(const Duration(days: 2, hours: 4)),
      status: WithdrawStatus.approved,
    ),
  ];

  final List<UserModel> users = [
    UserModel(
      id: 'usr1',
      name: 'Sana Ahmed',
      email: 'sana@example.com',
      phone: '+8801755123456',
      avatar:
          'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=900&q=80',
      role: UserRole.reseller,
      approved: true,
    ),
    UserModel(
      id: 'usr2',
      name: 'Raheel Ahmed',
      email: 'raheel@example.com',
      phone: '+8801811987654',
      avatar:
          'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=900&q=80',
      role: UserRole.reseller,
      approved: false,
    ),
    UserModel(
      id: 'usr3',
      name: 'Admin Team',
      email: 'admin@example.com',
      phone: '+8801912345678',
      avatar:
          'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&w=900&q=80',
      role: UserRole.admin,
      approved: true,
    ),
  ];

  Future<List<CategoryModel>> fetchCategories() async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    return categories;
  }

  Future<List<ProductModel>> fetchProducts() async {
    await Future<void>.delayed(const Duration(milliseconds: 450));
    return products;
  }

  Future<List<OrderModel>> fetchOrders() async {
    await Future<void>.delayed(const Duration(milliseconds: 450));
    return orders;
  }

  Future<List<TransactionModel>> fetchTransactions() async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    return transactions;
  }

  Future<List<WithdrawRequestModel>> fetchWithdrawRequests() async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    return withdrawRequests;
  }

  Future<List<UserModel>> fetchUsers() async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    return users;
  }
}
