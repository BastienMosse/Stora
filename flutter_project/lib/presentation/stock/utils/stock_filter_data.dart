import '/index.dart';

class StockFilterData {
  final List<String>? keywords;
  final List<Category>? category;
  final int? minQuantity;
  final int? maxQuantity;

  StockFilterData({
    this.keywords,
    this.category,
    this.minQuantity,
    this.maxQuantity,
  });
}
