import '/index.dart';

class UserUpdateResponse {
  final User user;

  UserUpdateResponse({required this.user});

  factory UserUpdateResponse.fromJson(Map<String, dynamic> json) {
    return UserUpdateResponse(user: User.fromJson(json['user']));
  }
}
