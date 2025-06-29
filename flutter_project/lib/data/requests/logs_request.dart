import '/index.dart';

class LogsRequest {
  final String? userId;
  final ActionType? actionType;
  final DateTime? fromDate;
  final DateTime? toDate;
  final String? targetId;

  LogsRequest({
    this.userId,
    this.actionType,
    this.fromDate,
    this.toDate,
    this.targetId,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'actionType': actionType?.value,
      'fromDate': fromDate?.toIso8601String(),
      'toDate': toDate?.toIso8601String(),
      'targetId': targetId,
    };
  }
}
