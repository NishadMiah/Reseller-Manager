import 'package:flutter/material.dart';

enum OrderStatus {
  pending,
  accepted,
  processing,
  shipped,
  delivered,
  cancelled,
}

class OrderModel {
  final String id;
  final String productName;
  final String customerName;
  final String customerPhone;
  final String address;
  final double total;
  final int quantity;
  final DateTime createdAt;
  OrderStatus status;
  final String paymentMethod;
  final String imageUrl;

  OrderModel({
    required this.id,
    required this.productName,
    required this.customerName,
    required this.customerPhone,
    required this.address,
    required this.total,
    required this.quantity,
    required this.createdAt,
    required this.status,
    required this.paymentMethod,
    required this.imageUrl,
  });

  Color get statusColor {
    switch (status) {
      case OrderStatus.accepted:
        return const Color(0xFF22C55E);
      case OrderStatus.processing:
        return const Color(0xFFF59E0B);
      case OrderStatus.shipped:
        return const Color(0xFF3B82F6);
      case OrderStatus.delivered:
        return const Color(0xFF0EA5E9);
      case OrderStatus.cancelled:
        return const Color(0xFFEF4444);
      default:
        return const Color(0xFF64748B);
    }
  }
}
