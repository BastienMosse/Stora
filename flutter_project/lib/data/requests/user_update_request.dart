import '/index.dart';

class UserUpdateRequest {
  final String login;
  final String username;
  final Role role;
  final DateTime? birth;
  final String? tel;
  final String? email;
  final double? pay;
  final String? note;

  UserUpdateRequest({
    required this.login,
    required this.username,
    required this.role,
    this.birth,
    this.tel,
    this.email,
    this.pay,
    this.note,
  });

  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'username': username,
      'role': role.value,
      if (birth != null)
        'birth': '${birth!.year}-${birth!.month}-${birth!.day}',
      if (tel != null) 'tel': tel,
      if (email != null) 'email': email,
      if (pay != null) 'pay': pay,
      if (note != null) 'note': note,
    };
  }
}
