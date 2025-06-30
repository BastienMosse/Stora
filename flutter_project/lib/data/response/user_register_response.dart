import '/index.dart';

class UserRegisterResponse {
  final User user;

  UserRegisterResponse({required this.user});

  factory UserRegisterResponse.fromJson(Map<String, dynamic> json) {
    return UserRegisterResponse(user: User.fromJson(json));
  }
}
