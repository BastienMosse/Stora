import '/index.dart';

class Endpoints {
  static Future<int> health() async {
    final response = await ApiService.get('api/health');
    return response.statusCode;
  }

  // ================
  // |     AUTH     |
  // ================

  // POST /api/login
  static Future<AuthLoginResponse?> login(AuthLoginRequest request) async {
    final response = await ApiService.post('api/login', request.toJson());
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      ApiService.jwt = json['token'];
      return AuthLoginResponse.fromJson(json);
    }
    return null;
  }

  // =================
  // |     USERS     |
  // =================

  // POST /api/register
  static Future<UserRegisterResponse?> register(
    UserRegisterRequest request,
  ) async {
    final response = await ApiService.post('api/register', request.toJson());
    print('Register response: ${response.statusCode} - ${response.body}');
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return UserRegisterResponse.fromJson(json);
    }
    return null;
  }

  // GET /api/users/me
  static Future<UserMeResponse?> getMe() async {
    final response = await ApiService.get('api/users/me');
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return UserMeResponse.fromJson(json);
    }
    return null;
  }

  // GET /api/users
  static Future<UserListResponse?> getUserList() async {
    final response = await ApiService.get('api/users/');
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return UserListResponse.fromJson(json);
    }
    return null;
  }

  // PATCH /api/users/{id}
  static Future<UserUpdateResponse?> updateUser(
    String userId,
    UserUpdateRequest request,
  ) async {
    final response = await ApiService.patch(
      'api/users/$userId',
      request.toJson(),
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return UserUpdateResponse.fromJson(json);
    }
    return null;
  }

  // GET /api/users/{id}
  static Future<UserGetResponse?> getUserById(String userId) async {
    final response = await ApiService.get('api/users/$userId');
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return UserGetResponse.fromJson(json);
    }
    return null;
  }

  // DELETE /api/users/{id}
  static Future<Message?> deleteUserById(String userId) async {
    final response = await ApiService.delete('api/users/$userId');
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
      'api/users/upload/$userId',
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

  // ====================
  // |     PRODUCTS     |
  // ====================

  // GET /api/products
  static Future<ProductListResponse?> getProducts() async {
    final response = await ApiService.get('api/products');
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return ProductListResponse.fromJson(json);
    }
    return null;
  }

  // POST /api/products
  static Future<ProductCreateResponse?> postProducts(
    ProductCreateRequest productRequest,
  ) async {
    final response = await ApiService.post(
      'api/products',
      productRequest.toJson(),
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return ProductCreateResponse.fromJson(json);
    }
    return null;
  }

  // GET /api/products/{id}
  static Future<ProductGetResponse?> getProductById(String productId) async {
    final response = await ApiService.get('api/products/$productId');
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return ProductGetResponse.fromJson(json);
    }
    return null;
  }

  // DELETE /api/products/{id}
  static Future<Message?> deleteProductById(String productId) async {
    final response = await ApiService.delete('api/products/$productId');
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Message.fromJson(json);
    }
    return null;
  }

  // PATCH /api/products/{id}
  static Future<ProductUpdateResponse?> patchProductById(
    String id,
    ProductUpdateRequest request,
  ) async {
    final response = await ApiService.patch('api/products/$id', request.toJson());
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return ProductUpdateResponse.fromJson(json);
    }
    return null;
  }

  // POST /api/users/upload/{id}
  static Future<Map<String, dynamic>?> uploadProductPhoto(
    String productId,
    File file,
  ) async {
    final response = await ApiService.uploadFile(
      'api/products/upload/$productId',
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

  // GET /api/logs
  static Future<LogsListResponse?> getLogsList() async {
    final response = await ApiService.get('api/logs');
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return LogsListResponse.fromJson(json);
    }
    return null;
  }

  // GET /api/logs/{id}
  static Future<LogsGetResponse?> getLogById(String logId) async {
    final response = await ApiService.get('api/logs/$logId');
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return LogsGetResponse.fromJson(json);
    }
    return null;
  }

  // POST /api/undo
  static Future<LogUndoResponse?> undoLog() async {
    final response = await ApiService.post('api/undo', {});
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return LogUndoResponse.fromJson(json);
    }
    return null;
  }

  // POST /api/undo
  static Future<LogBackupResponse?> backupLog() async {
    final response = await ApiService.post('api/backup', {});
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return LogBackupResponse.fromJson(json);
    }
    return null;
  }

  // POST /api/restore
  static Future<Message?> restoreLog(LogRestoreRequests request) async {
    final response = await ApiService.post('api/restore', request.toJson());
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Message.fromJson(json);
    }
    return null;
  }
  
  // POST /api/restore
  static Future<Message?> archiveeLog() async {
    final response = await ApiService.post('api/restore', {});
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Message.fromJson(json);
    }
    return null;
  }
}

