class User {
  final String id;
  final String login;
  final String username;
  final String role;
  final String birth;
  final String tel;
  final String email;
  final String photo;
  final int pay;
  final String note;

  User({
    required this.id,
    required this.login,
    required this.username,
    required this.role,
    this.birth = '',
    this.tel = '',
    this.email = '',
    this.photo = '',
    this.pay = 0,
    this.note = '',
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      login: json['login'],
      username: json['username'],
      role: json['role'],
      birth: json.containsKey('birth') ? (json['birth'] ?? '') : '',
      tel: json.containsKey('tel') ? (json['tel'] ?? '') : '',
      email: json.containsKey('email') ? (json['email'] ?? '') : '',
      photo: json.containsKey('photo') ? (json['photo'] ?? '') : '',
      pay: json.containsKey('pay') ? (json['pay'] ?? 0) : 0,
      note: json.containsKey('note') ? (json['note'] ?? '') : '',
    );
  }
}
