import '/index.dart';

class UserPrefs extends ChangeNotifier {
  static final UserPrefs _instance = UserPrefs._internal();
  factory UserPrefs() => _instance;
  UserPrefs._internal();

  static UserPrefs get instance => _instance;

  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ======= Theme Mode ======= //
  static String get CustomTheme => _prefs.getString('custom_theme') ?? '';
  static Future<void> setThemeJson(String jsonString) async {
    await _prefs.setString('custom_theme', jsonString);
    _instance.notifyListeners();
  }

  // ======= Theme Type ======= //
  static ThemeType get TypeTheme {
    final raw = _prefs.getString('type_theme');
    return ThemeType.values.firstWhere(
      (e) => e.toString().split('.').last == raw,
      orElse: () => ThemeType.dark,
    );
  }

  static Future<void> setTypeTheme(ThemeType themeType) async {
    await _prefs.setString('type_theme', themeType.toString().split('.').last);
    _instance.notifyListeners();
  }


  
  // ======= Locale ======= //
  static AppLocale get Locale => AppLocale(_prefs.getString('language_code') ?? 'en');
  static Future<void> setLocale(AppLocale code) async {
    await _prefs.setString('language_code', code.languageCode);
    _instance.notifyListeners();
  }


  // ======= First Launch ======= //
  static bool get FirstLaunch => _prefs.getBool('first_launch') ?? true;
  static Future<void> setFirstLaunch(bool value) async {
    await _prefs.setBool('first_launch', value);
    _instance.notifyListeners();
  }
}