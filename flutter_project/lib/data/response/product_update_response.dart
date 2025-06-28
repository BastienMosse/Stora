class ProductUpdateResponse {
  final String message;
  final String photoUrl;

  ProductUpdateResponse({required this.message, required this.photoUrl});

  factory ProductUpdateResponse.fromJson(Map<String, dynamic> json) {
    return ProductUpdateResponse(
      message: json['message'] as String,
      photoUrl: json['photoUrl'] as String,
    );
  }
}
