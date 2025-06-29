import '/index.dart';

class LogsListResponse {
  final List<LogsResponse> logs;

  LogsListResponse({required this.logs});

  factory LogsListResponse.fromJson(Map<String, dynamic> json) {
    return LogsListResponse(
      logs:
          (json['logs'] as List)
              .map((log) => LogsResponse.fromJson(log))
              .toList(),
    );
  }
}
