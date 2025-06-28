import '/index.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static String? jwt;

  static void setJwt(String token) {
    jwt = token;
  }

  static Future<http.Response> post(
    String path,
    Map<String, dynamic> body, {
    bool auth = false,
  }) {
    return http.post(
      Uri.parse('$apiBaseUrl$path'),
      headers: {
        'Content-Type': 'application/json',
        if (auth && jwt != null) 'Authorization': 'Bearer $jwt',
      },
      body: jsonEncode(body),
    );
  }

  static Future<http.Response> get(String path, {bool auth = false}) {
    return http.get(
      Uri.parse('$apiBaseUrl$path'),
      headers: {if (auth && jwt != null) 'Authorization': 'Bearer $jwt'},
    );
  }

  static Future<http.Response> delete(String path, {bool auth = false}) {
    return http.delete(
      Uri.parse('$apiBaseUrl$path'),
      headers: {if (auth && jwt != null) 'Authorization': 'Bearer $jwt'},
    );
  }

  static Future<http.Response> uploadFile(
    String path,
    String filePath,
    String field, {
    bool auth = false,
  }) async {
    var request = http.MultipartRequest('POST', Uri.parse('$apiBaseUrl$path'));
    request.files.add(await http.MultipartFile.fromPath(field, filePath));
    if (auth && jwt != null) {
      request.headers['Authorization'] = 'Bearer $jwt';
    }
    var streamed = await request.send();
    return await http.Response.fromStream(streamed);
  }
}
