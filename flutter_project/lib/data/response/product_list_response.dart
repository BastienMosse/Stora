import 'product_response.dart';

class ProductListResponse {
  final List<ProductResponse> products;

  ProductListResponse({required this.products});

  factory ProductListResponse.fromJson(Map<String, dynamic> json) {
    return ProductListResponse(
      products:
          (json['products'] as List)
              .map((item) => ProductResponse.fromJson(item))
              .toList(),
    );
  }
}
