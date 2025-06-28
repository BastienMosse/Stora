class UserResponse {
  final String id;
  final String login;
  final String username;
  final String role;
  final String photo;

  UserResponse({
    required this.id,
    required this.login,
    required this.username,
    required this.role,
    required this.photo,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      id: json['user']['id'],
      login: json['user']['login'],
      username: json['user']['username'],
      role: json['user']['role'],
      photo: json['user']['photo'] ?? '',
    );
  }
}
