class Log {
  final String id;
  final String userId;
  final String username;
  final DateTime actionDate;
  final String actionType;
  final String details;
  final String targetTable;
  final String targetId;

  Log({
    required this.id,
    required this.userId,
    required this.username,
    required this.actionDate,
    required this.actionType,
    required this.details,
    required this.targetTable,
    required this.targetId,
  });

  factory Log.fromJson(Map<String, dynamic> json) {
    return Log(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      username: json['username'] as String,
      actionDate: DateTime.parse(json['action_date'] as String),
      actionType: json['action_type'] as String,
      details: json['details'] as String,
      targetTable: json['target_table'] as String,
      targetId: json['target_id'] as String,
    );
  }
}