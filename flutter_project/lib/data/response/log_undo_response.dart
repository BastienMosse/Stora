import '/index.dart';

class LogUndoResponse {
  final String message;
  final String action;
  final Product product;

  LogUndoResponse({
    required this.message,
    required this.action,
    required this.product,
  });

  factory LogUndoResponse.fromJson(Map<String, dynamic> json) {
    return LogUndoResponse(
      message: json['message'] as String,
      action: json['action'] as String,
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
    );
  }
}