class UserRegisterResponse {
  final String id;
  final String username;
  final String role;
  final String password;
  final String birth;
  final String tel;
  final String email;
  final String pay;
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
      birth: json['birth'],
      tel: json['tel'],
      email: json['email'],
      pay: json['pay'],
      note: json['note'],
    );
  }
}
