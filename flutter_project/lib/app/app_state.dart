import '/index.dart';

typedef AppLocale = Locale;

class AppState extends ChangeNotifier {
  static final AppState _instance = AppState._internal();
  factory AppState() => _instance;
  AppState._internal();

  static AppState get instance => _instance;


  static late FlutterSecureStorage _secureStorage;


  static String _email = '';
  static String _password = '';

  static String get email => _email;
  static String get password => _password;


  static Future<void> init() async {
    _secureStorage = const FlutterSecureStorage();
    _email = await _secureStorage.read(key: 'user_email') ?? '';
    _password = await _secureStorage.read(key: 'user_password') ?? '';
    _instance.notifyListeners();
  }

  static Future<void> clear() async {
    await _secureStorage.deleteAll();
    _email = '';
    _password = '';
    _instance.notifyListeners();
  }


  static Future<void> setEmail(String value) async {
    _email = value;
    await _secureStorage.write(key: 'user_email', value: value);
    _instance.notifyListeners();
  }

  static Future<void> setPassword(String value) async {
    _password = value;
    await _secureStorage.write(key: 'user_password', value: value);
    _instance.notifyListeners();
  }
}
