import '/index.dart';

class Endpoints {
  static Future<int> health() async {
    final response = await ApiService.get('/api/health');
    return response.statusCode;
  }

  // ================
  // |     AUTH     |
  // ================

  static Future<AuthResponse?> login(LoginRequest request) async {
    final response = await ApiService.post('/api/login', request.toJson());
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      ApiService.jwt = json['token'];
      return AuthResponse.fromJson(json);
    }
    return null;
  }

  // ====================
  // |     PRODUCTS     |
  // ====================

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

  static Future<ProductListResponse?> getProductById(String id) async {
    final response = await ApiService.get('/api/products/$id');
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return ProductListResponse.fromJson(json);
    }
    return null;
  }

  static Future<Message?> deleteProductById(String id) async {
    final response = await ApiService.delete('/api/products/$id');
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Message.fromJson(json);
    }
    return null;
  }

  static Future<ProductUpdateResponse?> postProductById(
    int id,
    File file,
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

  // =================
  // |     USERS     |
  // =================

  // GET /api/users/me
  static Future<UserResponse?> getMeUser() async {
    final response = await ApiService.get('/api/users/me');
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return UserResponse.fromJson(json);
    }
    return null;
  }

  // GET /api/users
  static Future<UserListResponse?> getUsers() async {
    final response = await ApiService.get('/api/users');
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return UserListResponse.fromJson(json);
    }
    return null;
  }

  // POST /api/users
  static Future<AuthResponse?> register(RegisterRequest request) async {
    final response = await ApiService.post('/api/users', request.toJson());
    if (response.statusCode == 201) {
      final json = jsonDecode(response.body);
      return AuthResponse.fromJson(json);
    }
    return null;
  }

  // GET /api/users/{id}
  static Future<UserResponse?> getUserById(String userId) async {
    final response = await ApiService.get('/api/users/$userId');
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return UserResponse.fromJson(json);
    }
    return null;
  }

  // DELETE /api/users/{id}
  static Future<Message?> deleteUserById(String id) async {
    final response = await ApiService.delete('/api/users/$id');
    if (response.statusCode == 201) {
      final json = jsonDecode(response.body);
      return Message.fromJson(json);
    }
    return null;
  }

  // PUT /api/users/upload/{id}
  static Future<Map<String, dynamic>?> uploadUserPhoto(
    String userId,
    File file,
  ) async {
    final response = await ApiService.uploadFile(
      '/api/users/upload/$userId',
      file,
      'photo',
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Erreur upload: ${response.statusCode} - ${response.body}');
      return null;
    }
  }

  // ================
  // |     LOGS     |
  // ================

  static Future<LogsListResponse?> getLogs() async {
    final response = await ApiService.get('/api/logs');
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return LogsListResponse.fromJson(json);
    }
    return null;
  }

  static Future<LogsListResponse?> getLogsId() async {
    final response = await ApiService.get('/api/user');
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return LogsListResponse.fromJson(json);
    }
    return null;
  }
}
