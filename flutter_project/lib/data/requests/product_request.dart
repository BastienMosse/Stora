class ProductRequest {
  final String name;
  final String category;
  final int quantity;
  final int stockQuantity;
  final String photo;

  ProductRequest({
    required this.name,
    this.category = '',
    required this.quantity,
    this.stockQuantity = 0,
    this.photo = '',
  });

  Map<String, dynamic> toJson() {
    final data = {
      'name': name,
      'category': category,
      'quantity': quantity,
      'stock_quantity': stockQuantity,
      'photo': photo,
    };
    return data;
  }
}
