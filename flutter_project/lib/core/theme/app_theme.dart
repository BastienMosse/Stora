import '/index.dart';
import 'dart:convert';

abstract class AppThemeBase {
  Color get primaryColor;
  Color get backgroundColor;
  Color get textColor;
  Color get buttonColor;
}

// ===== Light Theme ===== //
class LightTheme extends AppThemeBase {
  static final LightTheme instance = LightTheme._internal();
  LightTheme._internal();

  @override Color get primaryColor => Colors.blue;
  @override Color get backgroundColor => Colors.white;
  @override Color get textColor => Colors.black;
  @override Color get buttonColor => Colors.blueAccent;
}

// ===== Dark Theme ===== //
class DarkTheme extends AppThemeBase {
  static final DarkTheme instance = DarkTheme._internal();
  DarkTheme._internal();

  @override Color get primaryColor => const Color(0xFF1A1A1A);
  @override Color get backgroundColor => const Color(0xFF121212);
  @override Color get textColor => Colors.white;
  @override Color get buttonColor => const Color(0xFF2563EB);
}

// ===== Custom Theme ===== //
class CustomTheme extends AppThemeBase {
  static final CustomTheme instance = CustomTheme._internal();
  CustomTheme._internal();

  Color? _primaryColor;
  Color? _backgroundColor;
  Color? _textColor;
  Color? _buttonColor;

  @override Color get primaryColor => _primaryColor ?? DarkTheme.instance.primaryColor;
  @override Color get backgroundColor => _backgroundColor ?? DarkTheme.instance.backgroundColor;
  @override Color get textColor => _textColor ?? DarkTheme.instance.textColor;
  @override Color get buttonColor => _buttonColor ?? DarkTheme.instance.buttonColor;

  void load(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    _primaryColor = json.containsKey('primaryColor') ? Color(json['primaryColor']) : null;
    _backgroundColor = json.containsKey('backgroundColor') ? Color(json['backgroundColor']) : null;
    _textColor = json.containsKey('textColor') ? Color(json['textColor']) : null;
    _buttonColor = json.containsKey('buttonColor') ? Color(json['buttonColor']) : null;
  }

  String save() {
    final Map<String, dynamic> data = {};
    if (_primaryColor != null) data['primaryColor'] = _primaryColor!;
    if (_backgroundColor != null) data['backgroundColor'] = _backgroundColor!;
    if (_textColor != null) data['textColor'] = _textColor!;
    if (_buttonColor != null) data['buttonColor'] = _buttonColor!;
    return jsonEncode(data);
  }
}