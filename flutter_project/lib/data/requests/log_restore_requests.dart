class LogRestoreRequests {
  final String filename;

  LogRestoreRequests({
    required this.filename,
  });

  Map<String, dynamic> toJson() {
    return {
      'filename': filename,
    };
  }
}