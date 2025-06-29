import '/index.dart';

class UserListResponse {
  final List<UserResponse> users;

  UserListResponse({required this.users});

  factory UserListResponse.fromJson(List json) {
    return UserListResponse(
      users:
          json
              .map(
                (user) => UserResponse.fromJson(user as Map<String, dynamic>),
              )
              .toList(),
    );
  }
}
