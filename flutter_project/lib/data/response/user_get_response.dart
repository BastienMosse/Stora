import '/index.dart';

class UserGetResponse {
  final User user;

  UserGetResponse({required this.user});

  factory UserGetResponse.fromJson(Map<String, dynamic> json) {
    return UserGetResponse(user: User.fromJson(json));
  }
}
