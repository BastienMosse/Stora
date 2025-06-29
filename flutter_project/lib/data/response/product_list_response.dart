import '/index.dart';

class ProductListResponse {
  final List<Product> products;

  ProductListResponse({required this.products});

  factory ProductListResponse.fromJson(Map<String, dynamic> json) {
    return ProductListResponse(
      products:
          (json['products'] as List)
              .map((item) => Product.fromJson(item))
              .toList(),
    );
  }
}
