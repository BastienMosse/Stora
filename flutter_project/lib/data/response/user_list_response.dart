import '/index.dart';

class UserListResponse {
  final List<User> users;

  UserListResponse({required this.users});

  factory UserListResponse.fromJson(List json) {
    return UserListResponse(
      users: json.map((user) => User.fromJson(user)).toList(),
    );
  }
}
