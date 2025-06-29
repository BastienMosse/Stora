class RegisterRequest {
  final String login;
  final String username;
  final String password;
  final String role;

  RegisterRequest({
    required this.login,
    required this.password,
    required this.username,
    this.role = 'USER',
  }) : assert(role == 'USER' || role == 'ADMIN', 'role must be USER or ADMIN');

  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'password': password,
      'username': username,
      'role': role,
    };
  }
}
