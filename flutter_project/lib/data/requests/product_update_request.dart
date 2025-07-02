class ProductUpdateRequest {
  final String name;
  final String category;
  final String description;
  final double price;
  final int stockQuantity;
  final int sellQuantity;
  final int deliveryQuantity;
  final String position;
  final String note;

  ProductUpdateRequest({
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.stockQuantity,
    required this.sellQuantity,
    required this.deliveryQuantity,
    required this.position,
    required this.note,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'description': description,
      'price': price,
      'stock_quantity': stockQuantity,
      'sell_quantity': sellQuantity,
      'delivery_quantity': deliveryQuantity,
      'position': position,
      'note': note,
    };
  }
}
