class UserRegisterResponse {
  final String id;
  final String username;
  final String role;
  final String password;
  final String birth;
  final String tel;
  final String email;
  final double pay;
  final String note;

  UserRegisterResponse({
    required this.id,
    required this.username,
    required this.role,
    required this.password,
    required this.birth,
    required this.tel,
    required this.email,
    required this.pay,
    required this.note,
  });

  factory UserRegisterResponse.fromJson(Map<String, dynamic> json) {
    return UserRegisterResponse(
      id: json['id'],
      username: json['username'],
      role: json['role'],
      password: json['password'],
      birth: json.containsKey('birth') ? (json['birth'] ?? '') : '',
      tel: json.containsKey('tel') ? (json['tel'] ?? '') : '',
      email: json.containsKey('email') ? (json['email'] ?? '') : '',
      pay: json.containsKey('pay') ? (json['pay'] ?? 0) : 0,
      note: json.containsKey('note') ? (json['note'] ?? '') : '',
    );
  }
}
