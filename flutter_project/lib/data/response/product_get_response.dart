import '/index.dart';

class ProductGetResponse {
  final Product products;

  ProductGetResponse({required this.products});

  factory ProductGetResponse.fromJson(Map<String, dynamic> json) {
    return ProductGetResponse(products: Product.fromJson(json['product']));
  }
}
