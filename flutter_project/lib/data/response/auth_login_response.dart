import '/index.dart';

class AuthLoginResponse {
  final String token;
  final User user;

  AuthLoginResponse({required this.token, required this.user});

  factory AuthLoginResponse.fromJson(Map<String, dynamic> json) {
    return AuthLoginResponse(
      token: json['token'], 
      user: User.fromJson(json['user'])
    );
  }
}
