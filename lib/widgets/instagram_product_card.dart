import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_project_architecture/core/constants/app_colors.dart';
import 'package:flutter_project_architecture/data/models/product_model.dart';
import 'package:flutter_project_architecture/routes/app_pages.dart';

class InstagramProductCard extends StatelessWidget {
  final ProductModel product;
  const InstagramProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.simpleCurrency(locale: 'en_US', decimalDigits: 2);
    final hasMultipleImages = product.images.length > 1;

    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.productDetail, arguments: product),
      child: AspectRatio(
        aspectRatio: 1.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Product Image
              CachedNetworkImage(
                imageUrl: product.images.first,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: AppColors.surfaceElevated,
                  child: const Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: AppColors.surfaceElevated,
                  child: const Icon(
                    Icons.broken_image,
                    size: 32,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              // Multiple Images Indicator (Instagram Carousel Icon Style)
              if (hasMultipleImages)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.45),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.collections_rounded,
                      size: 13,
                      color: Colors.white,
                    ),
                  ),
                ),
              // Bottom Gradient Overlay
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 52,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.75),
                      ],
                    ),
                  ),
                ),
              ),
              // Price and Stock Overlays
              Positioned(
                bottom: 8,
                left: 8,
                right: 8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Price Tag
                    Expanded(
                      child: Text(
                        formatter.format(product.price),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13.5,
                          fontWeight: FontWeight.w800,
                          shadows: [
                            Shadow(
                              color: Colors.black38,
                              blurRadius: 4,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Stock Count
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '${product.stock} in stock',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 9.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
