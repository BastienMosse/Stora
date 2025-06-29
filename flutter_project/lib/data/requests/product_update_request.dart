class ProductUpdateRequest {
  final String name;
  final String category;
  final String description;
  final double price;
  final int stock;

  ProductUpdateRequest({
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.stock,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'description': description,
      'price': price,
      'stock': stock,
    };
  }
}
