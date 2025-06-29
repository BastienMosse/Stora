import '/index.dart';

class UserListResponse {
  final List<User> users;

  UserListResponse({required this.users});

  factory UserListResponse.fromJson(Map<String, dynamic> json) {
    return UserListResponse(
      users:
          (json['user'] as List)
              .map((item) => User.fromJson(item as Map<String, dynamic>))
              .toList(),
    );
  }
}
