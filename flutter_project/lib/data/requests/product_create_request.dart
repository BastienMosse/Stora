import '/index.dart';

class ProductCreateRequest {
  final String name;
  final Category category;
  final String description;
  final double price;
  final int stockQuantity;
  final int sellQuantity;
  final int deliveryQuantity;
  final String position;
  final String note;

  ProductCreateRequest({
    required this.name,
    required this.category,
    this.description = '',
    this.price = 0.0,
    this.stockQuantity = 0,
    this.sellQuantity = 0,
    this.deliveryQuantity = 0,
    this.position = '',
    this.note = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category.value,
      'description': description,
      'price': price,
      'stockQuantity': stockQuantity,
      'sellQuantity': sellQuantity,
      'deliveryQuantity': deliveryQuantity,
      'position': position,
      'note': note,
    };
  }
}
