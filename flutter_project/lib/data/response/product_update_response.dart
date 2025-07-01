import '/index.dart';

class ProductUpdateResponse {
  final Product product;

  ProductUpdateResponse({required this.product});

  factory ProductUpdateResponse.fromJson(Map<String, dynamic> json) {
    return ProductUpdateResponse(product: Product.fromJson(json));
  }
}
