class User {
  final String id;
  final String login;
  final String username;
  final String role;

  User({
    required this.id,
    required this.login,
    required this.username,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['user']['id'],
      login: json['user']['login'],
      username: json['user']['username'],
      role: json['user']['role'],
    );
  }
}
