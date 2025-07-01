class Log {
  final String id;
  final String userId;
  final DateTime actionDate;
  final String actionType;
  final String details;
  final String targetTable;
  final String targetId;
  final String state;
  final String originalData;
  final String username;

  Log({
    required this.id,
    required this.userId,
    required this.actionDate,
    required this.actionType,
    required this.details,
    required this.targetTable,
    required this.targetId,
    required this.state,
    required this.originalData,
    required this.username,
  });

  factory Log.fromJson(Map<String, dynamic> json) {
    return Log(
      id: json['id'],
      userId: json['user_id'],
      actionDate: DateTime.parse(json['action_date']),
      actionType: json['action_type'],
      details: json['details'],
      targetTable: json['target_table'],
      targetId: json['target_id'],
      state: json['state'],
      originalData: json['original_data'],
      username: json['username'],
    );
  }
}
