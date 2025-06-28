class LoginRequest {
  final String login;
  final String password;

  LoginRequest({required this.login, required this.password});

  Map<String, dynamic> toJson() {
    final data = {'login': login, 'password': password};
    return data;
  }
}
