class LogBackupResponse {
  final String message;
  final String filename;

  LogBackupResponse({
    required this.message,
    required this.filename,
  });

  factory LogBackupResponse.fromJson(Map<String, dynamic> json) {
    return LogBackupResponse(
      message: json['message'] as String,
      filename: json['action'] as String,
    );
  }
}