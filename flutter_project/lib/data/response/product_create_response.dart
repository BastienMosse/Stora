import '/index.dart';

class ProductCreateResponse {
  final Product product;

  ProductCreateResponse({required this.product});

  factory ProductCreateResponse.fromJson(Map<String, dynamic> json) {
    return ProductCreateResponse(product: Product.fromJson(json['product']));
  }
}
