import '/index.dart';

typedef AppLocale = Locale;

class AppState extends ChangeNotifier {
  late FlutterSecureStorage _secureStorage;

  String _login = '';
  String _password = '';
  bool _isAdmin = false;

  String get Login => _login;
  String get Password => _password;
  bool get isAdmin => _isAdmin;

  Future<void> init() async {
    _secureStorage = const FlutterSecureStorage();
    _login = await _secureStorage.read(key: 'user_login') ?? '';
    _password = await _secureStorage.read(key: 'user_password') ?? '';
    _isAdmin = false;
    notifyListeners();
  }

  Future<void> clear() async {
    await _secureStorage.deleteAll();
    _login = '';
    _password = '';
    _isAdmin = false;
    notifyListeners();
  }

  Future<void> setLogin(String value) async {
    _login = value;
    await _secureStorage.write(key: 'user_login', value: value);
    notifyListeners();
  }

  Future<void> setPassword(String value) async {
    _password = value;
    await _secureStorage.write(key: 'user_password', value: value);
    notifyListeners();
  }

  void setIsAdmin(bool value) {
    _isAdmin = value;
    notifyListeners();
  }

  void logout() {
    _login = '';
    _password = '';
    _isAdmin = false;
    clear();
  }
}
