class Product {
  final String id;
  final String name;
  final String category;
  final String description;
  final double price;
  final int stockQuantity;
  final int sellQuantity;
  final int deliveryQuantity;
  final String photo;
  final String position;
  final String note;

  Product({
    required this.id,
    required this.name,
    required this.category,
    this.description = '',
    this.price = 0,
    this.stockQuantity = 0,
    this.sellQuantity = 0,
    this.deliveryQuantity = 0,
    this.photo = '',
    this.position = '',
    this.note = '',
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      description:
          json.containsKey('description') ? (json['description'] ?? '') : '',
      price:
          json.containsKey('price')
              ? (json['price'] is String
                  ? double.tryParse(json['price']) ?? 0.0
                  : (json['price'] ?? 0.0).toDouble())
              : 0.0,
      stockQuantity:
          json.containsKey('stock_quantity')
              ? (json['stock_quantity'] ?? 0)
              : 0,
      sellQuantity:
          json.containsKey('sell_quantity') ? (json['sell_quantity'] ?? 0) : 0,
      deliveryQuantity:
          json.containsKey('delivery_quantity')
              ? (json['delivery_quantity'] ?? 0)
              : 0,
      photo: json.containsKey('photo') ? (json['photo'] ?? '') : '',
      position: json.containsKey('position') ? (json['position'] ?? '') : '',
      note: json.containsKey('note') ? (json['note'] ?? '') : '',
    );
  }
}
