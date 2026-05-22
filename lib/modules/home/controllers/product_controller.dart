import 'package:get/get.dart';
import 'package:flutter_project_architecture/data/models/category_model.dart';
import 'package:flutter_project_architecture/data/models/product_model.dart';
import 'package:flutter_project_architecture/data/repositories/app_repository.dart';

class ProductController extends GetxController {
  final AppRepository repository = AppRepository();
  final products = <ProductModel>[].obs;
  final categories = <CategoryModel>[].obs;
  final selectedCategory = 'All'.obs;
  final searchQuery = ''.obs;
  final loading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    loading.value = true;
    final loadedCategories = await repository.fetchCategories();
    final loadedProducts = await repository.fetchProducts();
    categories.assignAll(loadedCategories);
    products.assignAll(loadedProducts);
    loading.value = false;
  }

  void filterByCategory(String category) {
    selectedCategory.value = category;
  }

  void updateSearch(String query) {
    searchQuery.value = query;
  }

  List<ProductModel> get filteredProducts {
    return products.where((product) {
      final categoryMatch =
          selectedCategory.value == 'All' ||
          product.category == selectedCategory.value;
      final searchMatch =
          product.name.toLowerCase().contains(
            searchQuery.value.toLowerCase(),
          ) ||
          product.category.toLowerCase().contains(
            searchQuery.value.toLowerCase(),
          );
      return categoryMatch && searchMatch;
    }).toList();
  }
}
