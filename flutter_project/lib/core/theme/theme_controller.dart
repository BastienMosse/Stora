import '/index.dart';

enum ThemeType { light, dark, custom }

class ThemeController extends ChangeNotifier {
  static final ThemeController _instance = ThemeController._internal();
  factory ThemeController() => _instance;
  ThemeController._internal();

  static ThemeController get instance => _instance;
  
  late ThemeType _currentType;
  late AppThemeBase _currentTheme;

  void init() {
    _currentType = UserPrefs.TypeTheme;
    switchTheme(_currentType);
  }

  ThemeType get currentType => _currentType;
  AppThemeBase get currentTheme => _currentTheme;

  void switchTheme(ThemeType newType) {
    _currentType = newType;
    switch (newType) {
      case ThemeType.light:
        _currentTheme = LightTheme.instance;
        break;
      case ThemeType.dark:
        _currentTheme = DarkTheme.instance;
        break;
      case ThemeType.custom:
        _currentTheme = CustomTheme.instance;
        (_currentTheme as CustomTheme).load(UserPrefs.CustomTheme);
        break;
    }
    UserPrefs.setTypeTheme(newType);
    notifyListeners();
  }
}
