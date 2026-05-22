class ProductModel {
  final String id;
  final String name;
  final String category;
  final List<String> images;
  final int stock;
  final double price;
  final double cost;
  final String description;
  final double rating;
  final bool featured;

  ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.images,
    required this.stock,
    required this.price,
    required this.cost,
    required this.description,
    required this.rating,
    this.featured = false,
  });

  double get margin => price - cost;
  String get availability => stock > 0 ? 'In stock' : 'Out of stock';
}
