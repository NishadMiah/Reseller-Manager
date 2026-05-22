import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_project_architecture/core/constants/app_colors.dart';
import 'package:flutter_project_architecture/core/constants/app_strings.dart';
import 'package:flutter_project_architecture/core/constants/app_sizes.dart';
import 'package:flutter_project_architecture/modules/home/controllers/product_controller.dart';
import 'package:flutter_project_architecture/widgets/product_card.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController controller = Get.put(ProductController());
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(AppStrings.products),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.padding,
          vertical: 12,
        ),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: AppStrings.searchProducts,
                prefixIcon: const Icon(Icons.search),
              ),
              onChanged: controller.updateSearch,
            ),
            const SizedBox(height: 18),
            Expanded(
              child: Obx(() {
                if (controller.loading.value) {
                  return ListView.separated(
                    itemCount: 4,
                    separatorBuilder: (_, _) => const SizedBox(height: 16),
                    itemBuilder: (context, index) => const SizedBox(
                      height: 130,
                      child: _LoadingProductCard(),
                    ),
                  );
                }
                return Column(
                  children: [
                    SizedBox(
                      height: 46,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.categories.length + 1,
                        separatorBuilder: (_, _) => const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          final categoryLabel = index == 0
                              ? 'All'
                              : controller.categories[index - 1].title;
                          final bool selected =
                              controller.selectedCategory.value == categoryLabel;
                          return ChoiceChip(
                            label: Text(categoryLabel),
                            selected: selected,
                            onSelected: (_) =>
                                controller.filterByCategory(categoryLabel),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: controller.filteredProducts.isEmpty
                          ? const Center(child: Text('No products found.'))
                          : GridView.builder(
                              itemCount: controller.filteredProducts.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 14,
                                mainAxisSpacing: 14,
                                childAspectRatio: 0.73,
                              ),
                              itemBuilder: (context, index) {
                                final product =
                                    controller.filteredProducts[index];
                                return ProductCard(product: product);
                              },
                            ),
                    ),
                  ],
                );
            }),
          ],
        ),
      ),
    );
  }
}

class _LoadingProductCard extends StatelessWidget {
  const _LoadingProductCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius),
      ),
    );
  }
}
