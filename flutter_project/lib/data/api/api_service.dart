import '/index.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ApiService {
  static String? jwt;

  static String _getImageMimeType(String path) {
    if (path.endsWith('.png')) return 'png';
    if (path.endsWith('.jpg') || path.endsWith('.jpeg')) return 'jpeg';
    if (path.endsWith('.gif')) return 'gif';
    return 'jpeg';
  }

  static void setJwt(String token) {
    jwt = token;
  }

  static Future<http.Response> post(String path, Map<String, dynamic> body) {
    return http.post(
      Uri.parse('$apiBaseUrl$path'),
      headers: {
        'Content-Type': 'application/json',
        if (jwt != null) 'Authorization': 'Bearer $jwt',
      },
      body: jsonEncode(body),
    );
  }

  static Future<http.Response> get(String path) {
    return http.get(
      Uri.parse('$apiBaseUrl$path'),
      headers: {
        'accept': 'application/json',
        if (jwt != null) 'Authorization': 'Bearer $jwt',
      },
    );
  }

  static Future<http.Response> delete(String path) {
    return http.delete(
      Uri.parse('$apiBaseUrl$path'),
      headers: {
        'accept': 'application/json',
        if (jwt != null) 'Authorization': 'Bearer $jwt',
      },
    );
  }

  static Future<http.Response> patch(String path, Map<String, dynamic> body) {
    return http.patch(
      Uri.parse('$apiBaseUrl$path'),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
        if (jwt != null) 'Authorization': 'Bearer $jwt',
      },
      body: jsonEncode(body),
    );
  }

  static Future<http.Response> uploadFile(
    String path,
    File file,
    String field,
  ) async {
    final uri = Uri.parse('$apiBaseUrl$path');
    final request = http.MultipartRequest('POST', uri);

    request.files.add(
      await http.MultipartFile.fromPath(
        field,
        file.path,
        contentType: MediaType('image', _getImageMimeType(file.path)),
      ),
    );

    request.headers['accept'] = 'application/json';
    if (jwt != null) {
      request.headers['Authorization'] = 'Bearer $jwt';
    }

    print('Uploading file to $uri with headers: ${request.headers}');

    final streamed = await request.send();
    final response = await http.Response.fromStream(streamed);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    return response;
  }
}
