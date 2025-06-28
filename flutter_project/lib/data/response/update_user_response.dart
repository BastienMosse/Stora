class UpdateUserResponse {
  final String message;
  final String photo;

  UpdateUserResponse({required this.message, required this.photo});

  factory UpdateUserResponse.fromJson(Map<String, dynamic> json) {
    return UpdateUserResponse(message: json['message'], photo: json['photo']);
  }
}
