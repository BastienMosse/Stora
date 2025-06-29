import '/index.dart';

class UserMeResponse {
  final User user;

  UserMeResponse({required this.user});

  factory UserMeResponse.fromJson(Map<String, dynamic> json) {
    return UserMeResponse(user: User.fromJson(json['user']));
  }
}
