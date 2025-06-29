class Product {
  final String id;
  final String name;
  final String category;
  final String description;
  final double price;
  final int stockQuantity;
  final String photoUrl;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.stockQuantity,
    required this.photoUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      stockQuantity: (json['stock_quantity'] as num).toInt(),
      photoUrl: json['photo_url'] as String,
    );
  }
}
