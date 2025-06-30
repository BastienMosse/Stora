import '/index.dart';

class LogsGetResponse {
  final Log logs;

  LogsGetResponse({required this.logs});

  factory LogsGetResponse.fromJson(Map<String, dynamic> json) {
    return LogsGetResponse(
      logs: Log.fromJson(json['logs'] as Map<String, dynamic>),
    );
  }
}
