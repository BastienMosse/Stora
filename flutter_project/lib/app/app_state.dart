import '/index.dart';

typedef AppLocale = Locale;

class AppState extends ChangeNotifier {
  late FlutterSecureStorage _secureStorage;

  String _email = '';
  String _password = '';

  String get Email => _email;
  String get Password => _password;

  Future<void> init() async {
    _secureStorage = const FlutterSecureStorage();
    _email = await _secureStorage.read(key: 'user_email') ?? '';
    _password = await _secureStorage.read(key: 'user_password') ?? '';
    notifyListeners();
  }

  Future<void> clear() async {
    await _secureStorage.deleteAll();
    _email = '';
    _password = '';
    notifyListeners();
  }

  Future<void> setEmail(String value) async {
    _email = value;
    await _secureStorage.write(key: 'user_email', value: value);
    notifyListeners();
  }

  Future<void> setPassword(String value) async {
    _password = value;
    await _secureStorage.write(key: 'user_password', value: value);
    notifyListeners();
  }
}
