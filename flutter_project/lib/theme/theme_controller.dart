import '/index.dart';

enum ThemeType { light, dark, custom }

class ThemeController extends ChangeNotifier {
  late UserPrefs _userPrefs;
  late ThemeType _currentType;
  late AppThemeBase _currentTheme;

  void init(UserPrefs userPrefs) {
    _userPrefs = userPrefs;
    _userPrefs.addListener(() {
      if (_userPrefs.TypeTheme != _currentType) {
        switchTheme(_userPrefs.TypeTheme);
      }
    });
    _currentType = _userPrefs.TypeTheme;
    switchTheme(_currentType);
    notifyListeners();
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
        (_currentTheme as CustomTheme).load(_userPrefs.CustomTheme);
        break;
    }

    _userPrefs.setTypeTheme(newType);
    notifyListeners();
  }
}
