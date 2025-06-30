import '/index.dart';

class LogsListResponse {
  final List<Log> logs;

  LogsListResponse({required this.logs});

  factory LogsListResponse.fromJson(List json) {
    return LogsListResponse(
      logs: json.map((log) => Log.fromJson(log)).toList(),
    );
  }
}
