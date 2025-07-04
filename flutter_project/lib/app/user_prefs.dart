import '/index.dart';

class UserPrefs extends ChangeNotifier {
  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ======= Theme Mode ======= //
  String get CustomTheme => _prefs.getString('custom_theme') ?? LightTheme.instance.Primary.toString();
  Future<void> setCustomTheme(String jsonString) async {
    await _prefs.setString('custom_theme', jsonString);
    notifyListeners();
  }

  // ======= Theme Type ======= //
  ThemeType get TypeTheme {
    final raw = _prefs.getString('type_theme');
    return ThemeType.values.firstWhere(
      (e) => e.toString().split('.').last == raw,
      orElse: () => ThemeType.dark,
    );
  }

  Future<void> setTypeTheme(ThemeType themeType) async {
    await _prefs.setString('type_theme', themeType.toString().split('.').last);
    notifyListeners();
  }

  // ======= Login ======= //
  bool get RememberMe => _prefs.getBool('remember_me') ?? false;
  Future<void> setRememberMe(bool value) async {
    await _prefs.setBool('remember_me', value);
    notifyListeners();
  }

  // ======= Locale ======= //
  AppLocale get Locale => AppLocale(_prefs.getString('language_code') ?? 'en');
  Future<void> setLocale(AppLocale code) async {
    await _prefs.setString('language_code', code.languageCode);
    notifyListeners();
  }

  // ======= First Launch ======= //
  bool get FirstLaunch => _prefs.getBool('first_launch') ?? true;
  Future<void> setFirstLaunch(bool value) async {
    await _prefs.setBool('first_launch', value);
    notifyListeners();
  }
}
