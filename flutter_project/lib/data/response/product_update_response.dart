import '/index.dart';

class ProductUpdateResponse {
  final Product products;

  ProductUpdateResponse({required this.products});

  factory ProductUpdateResponse.fromJson(Map<String, dynamic> json) {
    return ProductUpdateResponse(products: Product.fromJson(json['product']));
  }
}
