class AuthLoginRequest {
  final String login;
  final String password;

  AuthLoginRequest({required this.login, required this.password});

  Map<String, dynamic> toJson() {
    final data = {'login': login, 'password': password};
    return data;
  }
}
