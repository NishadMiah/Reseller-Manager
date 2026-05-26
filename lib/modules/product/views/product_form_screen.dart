import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_project_architecture/core/constants/app_colors.dart';
import 'package:flutter_project_architecture/core/constants/app_sizes.dart';
import 'package:flutter_project_architecture/widgets/custom_button.dart';

class ProductFormScreen extends StatefulWidget {
  const ProductFormScreen({super.key});

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController costController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String category = 'Accessories';
  bool _saving = false;

  final List<String> _mockImages = [];

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    await Future<void>.delayed(const Duration(milliseconds: 500));
    setState(() => _saving = false);
    Get.back();
    Get.snackbar('Product', 'Product added successfully');
  }

  void _addMockImage() {
    setState(() {
      _mockImages.add(
        'https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&w=400&q=80',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Add Product',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.padding),
        child: Form(
          key: _formKey,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 8),
              // Image Upload Section
              const Text(
                'Product Images',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    // Add image button
                    GestureDetector(
                      onTap: _addMockImage,
                      child: Container(
                        width: 120,
                        height: 120,
                        margin: const EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.primary.withValues(alpha: 0.2),
                            width: 2,
                            strokeAlign: BorderSide.strokeAlignInside,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.08),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.add_photo_alternate_rounded,
                                color: AppColors.primary,
                                size: 24,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Add Image',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Uploaded images
                    ..._mockImages.asMap().entries.map((entry) {
                      return Container(
                        width: 120,
                        height: 120,
                        margin: const EdgeInsets.only(right: 12),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                entry.value,
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                                errorBuilder: (c, e, s) => Container(
                                  width: 120,
                                  height: 120,
                                  color: AppColors.surfaceElevated,
                                  child: const Icon(
                                    Icons.broken_image_rounded,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 6,
                              right: 6,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() => _mockImages.removeAt(entry.key));
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: AppColors.danger.withValues(alpha: 0.9),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.close_rounded,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Product Details Section
              const Text(
                'Product Details',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 14),
              _buildInputCard(
                children: [
                  _buildTextField(
                    controller: nameController,
                    label: 'Product Name',
                    icon: Icons.inventory_2_outlined,
                    validator: (v) => v!.isEmpty ? 'Enter product name' : null,
                  ),
                  const Divider(height: 1),
                  _buildTextField(
                    controller: descriptionController,
                    label: 'Description',
                    icon: Icons.description_outlined,
                    maxLines: 3,
                    validator: (v) => v!.isEmpty ? 'Enter description' : null,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Pricing Section
              const Text(
                'Pricing & Stock',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 14),
              _buildInputCard(
                children: [
                  _buildTextField(
                    controller: priceController,
                    label: 'Selling Price (BDT)',
                    icon: Icons.sell_outlined,
                    keyboardType: TextInputType.number,
                    validator: (v) => v!.isEmpty ? 'Enter price' : null,
                  ),
                  const Divider(height: 1),
                  _buildTextField(
                    controller: costController,
                    label: 'Cost Price (BDT)',
                    icon: Icons.price_change_outlined,
                    keyboardType: TextInputType.number,
                    validator: (v) => v!.isEmpty ? 'Enter cost' : null,
                  ),
                  const Divider(height: 1),
                  _buildTextField(
                    controller: stockController,
                    label: 'Stock Quantity',
                    icon: Icons.inventory_rounded,
                    keyboardType: TextInputType.number,
                    validator: (v) => v!.isEmpty ? 'Enter stock' : null,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Category Section
              const Text(
                'Category',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.border.withValues(alpha: 0.12),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: DropdownButtonFormField<String>(
                  value: category,
                  icon: const Icon(Icons.keyboard_arrow_down_rounded),
                  decoration: InputDecoration(
                    labelText: 'Product Category',
                    labelStyle: const TextStyle(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                    prefixIcon: const Icon(
                      Icons.category_outlined,
                      size: 20,
                      color: AppColors.textSecondary,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Accessories',
                      child: Text('Accessories'),
                    ),
                    DropdownMenuItem(value: 'Shoes', child: Text('Shoes')),
                    DropdownMenuItem(value: 'Fashion', child: Text('Fashion')),
                    DropdownMenuItem(value: 'Phones', child: Text('Phones')),
                    DropdownMenuItem(
                      value: 'Electronics',
                      child: Text('Electronics'),
                    ),
                    DropdownMenuItem(
                      value: 'Home & Living',
                      child: Text('Home & Living'),
                    ),
                  ],
                  onChanged: (value) =>
                      setState(() => category = value ?? category),
                ),
              ),
              const SizedBox(height: 28),
              // Profit preview card
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.success.withValues(alpha: 0.08),
                      AppColors.success.withValues(alpha: 0.02),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.success.withValues(alpha: 0.15),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.success.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.trending_up_rounded,
                        color: AppColors.success,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Estimated Profit Margin',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _calculateMargin(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 18,
                              color: AppColors.success,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saving ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: _saving
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          'Save Product',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  String _calculateMargin() {
    final price = double.tryParse(priceController.text) ?? 0;
    final cost = double.tryParse(costController.text) ?? 0;
    if (price <= 0 || cost <= 0) return '৳0.00';
    final margin = price - cost;
    return '৳${margin.toStringAsFixed(2)} per unit';
  }

  Widget _buildInputCard({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.border.withValues(alpha: 0.12),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(children: children),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        onChanged: (_) => setState(() {}),
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
          prefixIcon: Icon(icon, size: 20, color: AppColors.textSecondary),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
        validator: validator,
      ),
    );
  }
}
