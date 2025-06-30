import '/index.dart';

class ProductListResponse {
  final List<Product> products;

  ProductListResponse({required this.products});

  factory ProductListResponse.fromJson(List json) {
    return ProductListResponse(
      products: json.map((product) => Product.fromJson(product)).toList(),
    );
  }
}
