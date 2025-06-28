import '/index.dart';

class Endpoints {
  // ===== LOGIN / REGISTER ===== //
  static Future<AuthResponse?> login(LoginRequest request) async {
    final response = await ApiService.post('/api/login', request.toJson());
    print('Login test: ${response.statusCode} - ${response.body}');
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      ApiService.jwt = json['token'];
      return AuthResponse.fromJson(json);
    }
    return null;
  }

  static Future<AuthResponse?> register(RegisterRequest request) async {
    final response = await ApiService.post('/api/register', request.toJson());
    if (response.statusCode == 201) {
      final json = jsonDecode(response.body);
      return AuthResponse.fromJson(json);
    }
    return null;
  }

  // ===== PRODUCTS ===== //
  static Future<ProductListResponse?> getProducts() async {
    final response = await ApiService.get('/api/products');
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return ProductListResponse.fromJson(json);
    }
    return null;
  }

  static Future<ProductResponse?> postProducts(
    ProductRequest productRequest,
  ) async {
    final response = await ApiService.post(
      '/api/products',
      productRequest.toJson(),
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return ProductResponse.fromJson(json);
    }
    return null;
  }

  static Future<ProductListResponse?> getProductById(int id) async {
    final response = await ApiService.get('/api/products/$id');
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return ProductListResponse.fromJson(json);
    }
    return null;
  }

  static Future<Message?> deleteProductById(int id) async {
    final response = await ApiService.delete('/api/products/$id');
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Message.fromJson(json);
    }
    return null;
  }

  static Future<ProductUpdateResponse?> postProductById(
    int id,
    String file,
  ) async {
    final response = await ApiService.uploadFile(
      '/api/products/$id',
      file,
      'photo',
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return ProductUpdateResponse.fromJson(json);
    }
    return null;
  }

  // ===== USERS ===== //
  static Future<UserResponse?> getUser() async {
    final response = await ApiService.get('/api/user');
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return UserResponse.fromJson(json);
    }
    return null;
  }

  static Future<UserResponse?> getUserId(int userId) async {
    final response = await ApiService.get('/api/user/$userId');
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return UserResponse.fromJson(json);
    }
    return null;
  }

  static Future<Map<String, dynamic>?> uploadUserPhoto(
    String userId,
    String file,
  ) async {
    final response = await ApiService.uploadFile(
      '/api/upload/user/$userId',
      file,
      'photo',
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }
}
