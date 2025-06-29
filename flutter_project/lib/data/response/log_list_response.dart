import '/index.dart';

class LogsListResponse {
  final List<Log> logs;

  LogsListResponse({
    required this.logs,
  });

  factory LogsListResponse.fromJson(Map<String, dynamic> json) {
    return LogsListResponse(
      logs: (json['logs'] as List)
          .map((log) => Log.fromJson(log as Map<String, dynamic>))
          .toList(),
    );
  }
}