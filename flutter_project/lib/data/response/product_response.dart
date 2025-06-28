class ProductResponse {
  final String id;
  final String name;
  final String category;
  final int quantity;
  final int stockQuantity;
  final String photo;

  ProductResponse({
    required this.id,
    required this.name,
    required this.category,
    required this.quantity,
    required this.stockQuantity,
    required this.photo,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      quantity: json['quantity'],
      stockQuantity: json['stock_quantity'],
      photo: json['photo'],
    );
  }
}
