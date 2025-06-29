class UserResponse {
  final String id;
  final String login;
  final String username;
  final DateTime? birth;
  final String tel;
  final String role;
  final String email;
  final String photo;
  final int pay;
  final String note;

  UserResponse({
    required this.id,
    required this.login,
    required this.username,
    required this.role,
    this.birth,
    this.tel = '',
    this.email = '',
    this.photo = '',
    this.pay = 0,
    this.note = '',
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      id: json['id'] ?? '',
      login: json['login'] ?? '',
      username: json['username'] ?? '',
      role: json['role'] ?? '',
      birth: json['birth'] != null ? DateTime.parse(json['birth']) : null,
      tel: json['tel'] ?? '',
      email: json['email'] ?? '',
      photo: json['photo'] ?? '',
      pay: json['pay'] ?? 0,
      note: json['note'] ?? '',
    );
  }
}
