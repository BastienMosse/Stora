import '/index.dart';

class LogsGetResponse {
  final Log log;

  LogsGetResponse({required this.log});

  factory LogsGetResponse.fromJson(Map<String, dynamic> json) {
    return LogsGetResponse(log: Log.fromJson(json));
  }
}
