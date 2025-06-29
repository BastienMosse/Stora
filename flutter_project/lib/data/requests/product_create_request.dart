class ProductCreateRequest {
  final String name;
  final String category;
  final String description;
  final double price;
  final int quantity;

  ProductCreateRequest({
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'description': description,
      'price': price,
      'stock_quantity': quantity,
    };
  }
}
