import '/index.dart';

class LogFilterData {
  final List<ActionType>? action;
  final String? productId;
  final String? productName;
  final String? employeeId;
  final String? employeeName;
  final DateTime? from; // ISO format
  final DateTime? to; // ISO format

  LogFilterData({
    this.action,
    this.productId,
    this.productName,
    this.employeeId,
    this.employeeName,
    this.from,
    this.to,
  });
}
