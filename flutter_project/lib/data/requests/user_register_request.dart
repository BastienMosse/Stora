import '/index.dart';

class UserRegisterRequest {
  final String login;
  final String username;
  final Role role;
  final String password;
  final String? birth;
  final String? tel;
  final String? email;
  final double? pay;
  final String? note;

  UserRegisterRequest({
    required this.login,
    required this.username,
    required this.password,
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
      'password': password,
      'role': role.value,
      if (birth != null) 'birth': birth,
      if (tel != null) 'tel': tel,
      if (email != null) 'email': email,
      if (pay != null) 'pay': pay,
      if (note != null) 'note': note,
    };
  }
}
