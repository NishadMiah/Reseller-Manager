import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_project_architecture/core/constants/app_colors.dart';
import 'package:flutter_project_architecture/data/models/product_model.dart';
import 'package:flutter_project_architecture/widgets/custom_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_project_architecture/modules/orders/controllers/orders_controller.dart';
import 'package:flutter_project_architecture/modules/admin/controllers/admin_controller.dart';
import 'package:flutter_project_architecture/data/models/order_model.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductModel product = Get.arguments as ProductModel;
    final priceFormatter = NumberFormat.simpleCurrency(locale: 'en_US');

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        title: Text(
          product.name,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          SizedBox(
            height: 280,
            child: PageView.builder(
              itemCount: product.images.length,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: CachedNetworkImage(
                    imageUrl: product.images[index],
                    fit: BoxFit.cover,
                    placeholder: (c, u) =>
                        Container(color: AppColors.surfaceElevated),
                    errorWidget: (c, u, e) => Container(
                      color: AppColors.surfaceElevated,
                      child: const Icon(
                        Icons.broken_image,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                priceFormatter.format(product.price),
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surfaceElevated,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  product.availability,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Profit: ${priceFormatter.format(product.margin)}',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.success,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Product Details',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 10),
          Text(
            product.description,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _detailItem('Category', product.category),
              _detailItem('Stock', '${product.stock} pcs'),
            ],
          ),
          const SizedBox(height: 30),
          CustomButton(
            label: 'Place Order',
            onPressed: () => _showPlaceOrderSheet(context, product),
          ),
        ],
      ),
    );
  }

  Widget _detailItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: AppColors.textSecondary)),
        const SizedBox(height: 6),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w700)),
      ],
    );
  }

  void _showPlaceOrderSheet(BuildContext context, ProductModel product) {
    final nameCtrl = TextEditingController();
    final priceCtrl = TextEditingController(
      text: product.price.toStringAsFixed(2),
    );
    final phoneCtrl = TextEditingController();
    final addressCtrl = TextEditingController();
    final qtyCtrl = TextEditingController(text: '1');
    String paymentMethod = 'bKash';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: AppColors.border,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                Text('Place Order', style: Theme.of(ctx).textTheme.titleLarge),
                const SizedBox(height: 12),
                TextField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(labelText: 'Your name'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: phoneCtrl,
                  decoration: const InputDecoration(labelText: 'Phone'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: addressCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Delivery address',
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: qtyCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Quantity'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: priceCtrl,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Reseller price (per item)',
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  initialValue: paymentMethod,
                  decoration: const InputDecoration(
                    labelText: 'Payment method',
                  ),
                  items: const [
                    DropdownMenuItem(value: 'bKash', child: Text('bKash')),
                    DropdownMenuItem(value: 'Nagad', child: Text('Nagad')),
                    DropdownMenuItem(
                      value: 'Bank Account',
                      child: Text('Bank Account'),
                    ),
                  ],
                  onChanged: (v) => paymentMethod = v ?? paymentMethod,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        label: 'Confirm Order',
                        onPressed: () {
                          final name = nameCtrl.text.trim().isEmpty
                              ? 'Guest'
                              : nameCtrl.text.trim();
                          final phone = phoneCtrl.text.trim();
                          final address = addressCtrl.text.trim();
                          final qty = int.tryParse(qtyCtrl.text.trim()) ?? 1;
                          final unit =
                              double.tryParse(priceCtrl.text.trim()) ??
                              product.price;
                          final total = unit * qty;

                          final order = OrderModel(
                            id: 'ord_${DateTime.now().millisecondsSinceEpoch}',
                            productName: product.name,
                            customerName: name,
                            customerPhone: phone,
                            address: address,
                            total: total,
                            quantity: qty,
                            createdAt: DateTime.now(),
                            status: OrderStatus.pending,
                            paymentMethod: paymentMethod,
                            imageUrl: product.images.first,
                          );

                          final ordersCtrl = Get.put(OrdersController());
                          ordersCtrl.placeOrder(order);
                          final adminCtrl = Get.put(AdminController());
                          adminCtrl.orders.insert(0, order);
                          adminCtrl.orders.refresh();

                          Navigator.of(ctx).pop();
                          Get.snackbar('Order', 'Order placed successfully');
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }
}
