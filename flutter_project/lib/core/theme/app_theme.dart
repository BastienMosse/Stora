import '/index.dart';
import 'dart:convert';

abstract class AppThemeBase {
  // Brand Colors
  Color get Primary;
  Color get Secondary;
  Color get Tertiary;
  Color get Alternate;

  // Utility Colors
  Color get PrimaryText;
  Color get SecondaryText;
  Color get PrimaryBackground;
  Color get SecondaryBackground;

  // Accent Colors
  Color get Accent1;
  Color get Accent2;
  Color get Accent3;
  Color get Accent4;

  // Semantic Colors
  Color get Success => Color(0xFF249689);
  Color get Error => Color(0xFFFF5963);
  Color get Warning => Color(0xFF4b39ef);
  Color get Info => Color(0xFF4b39ef);
}

// ===== Dark Theme ===== //
class DarkTheme extends AppThemeBase {
  static final DarkTheme instance = DarkTheme._internal();
  DarkTheme._internal();

  // Brand Colors
  @override
  Color get Primary => Color(0xFF4B39EF);
  @override
  Color get Secondary => Color(0xFF39D2C0);
  @override
  Color get Tertiary => Color(0xFFEE8B60);
  @override
  Color get Alternate => Color(0xFF262D34);

  // Utility Colors
  @override
  Color get PrimaryText => Color(0xFFFFFFFF);
  @override
  Color get SecondaryText => Color(0xFF95A1AC);
  @override
  Color get PrimaryBackground => Color(0xFF1D2428);
  @override
  Color get SecondaryBackground => Color(0xFF14181D);

  // Accent Colors
  @override
  Color get Accent1 => Color(0x4C4B39EF);
  @override
  Color get Accent2 => Color(0x4D39D2C0);
  @override
  Color get Accent3 => Color(0x4DEE8D60);
  @override
  Color get Accent4 => Color(0xb2262D34);
}

// ===== Light Theme ===== //
class LightTheme extends AppThemeBase {
  static final LightTheme instance = LightTheme._internal();
  LightTheme._internal();

  // Brand Colors
  @override
  Color get Primary => Color(0xFF4B39EF);
  @override
  Color get Secondary => Color(0xFF39D2C0);
  @override
  Color get Tertiary => Color(0xFFEE8B60);
  @override
  Color get Alternate => Color(0xFFE0E3E7);

  // Utility Colors
  @override
  Color get PrimaryText => Color(0xFF14181B);
  @override
  Color get SecondaryText => Color(0xFF57636C);
  @override
  Color get PrimaryBackground => Color(0xFFF1F4F8);
  @override
  Color get SecondaryBackground => Color(0xFFFFFFFF);

  // Accent Colors
  @override
  Color get Accent1 => Color(0x4C4B39EF);
  @override
  Color get Accent2 => Color(0x4D39D2C0);
  @override
  Color get Accent3 => Color(0x4DEE8D60);
  @override
  Color get Accent4 => Color(0xCCFFFFFF);
}

// ===== Custom Theme ===== //
class CustomTheme extends AppThemeBase {
  static final CustomTheme instance = CustomTheme._internal();
  CustomTheme._internal();

  // Brand Colors
  Color? _primary;
  Color? _secondary;
  Color? _tertiary;
  Color? _alternate;
  @override
  Color get Primary => _primary ?? DarkTheme.instance.Primary;
  @override
  Color get Secondary => _secondary ?? DarkTheme.instance.Secondary;
  @override
  Color get Tertiary => _tertiary ?? DarkTheme.instance.Tertiary;
  @override
  Color get Alternate => _alternate ?? DarkTheme.instance.Alternate;

  // Utility Colors
  Color? _primaryText;
  Color? _secondaryText;
  Color? _primaryBackground;
  Color? _secondaryBackground;
  @override
  Color get PrimaryText => _primaryText ?? DarkTheme.instance.PrimaryText;
  @override
  Color get SecondaryText => _secondaryText ?? DarkTheme.instance.SecondaryText;
  @override
  Color get PrimaryBackground =>
      _primaryBackground ?? DarkTheme.instance.PrimaryBackground;
  @override
  Color get SecondaryBackground =>
      _secondaryBackground ?? DarkTheme.instance.SecondaryBackground;

  // Accent Colors
  Color? _accent1;
  Color? _accent2;
  Color? _accent3;
  Color? _accent4;
  @override
  Color get Accent1 => _accent1 ?? DarkTheme.instance.Accent1;
  @override
  Color get Accent2 => _accent2 ?? DarkTheme.instance.Accent2;
  @override
  Color get Accent3 => _accent3 ?? DarkTheme.instance.Accent3;
  @override
  Color get Accent4 => _accent4 ?? DarkTheme.instance.Accent4;

  void load(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);

    Color? parseColor(String key) =>
        json.containsKey(key) && json[key] != null ? Color(json[key]) : null;

    _primary = parseColor('primary');
    _secondary = parseColor('secondary');
    _tertiary = parseColor('tertiary');
    _alternate = parseColor('alternate');

    _primaryText = parseColor('primaryText');
    _secondaryText = parseColor('secondaryText');
    _primaryBackground = parseColor('primaryBackground');
    _secondaryBackground = parseColor('secondaryBackground');

    _accent1 = parseColor('accent1');
    _accent2 = parseColor('accent2');
    _accent3 = parseColor('accent3');
    _accent4 = parseColor('accent4');
  }

  String save() {
    Map<String, int?> colorMap = {
      'primary': _primary?.value,
      'secondary': _secondary?.value,
      'tertiary': _tertiary?.value,
      'alternate': _alternate?.value,
      'primaryText': _primaryText?.value,
      'secondaryText': _secondaryText?.value,
      'primaryBackground': _primaryBackground?.value,
      'secondaryBackground': _secondaryBackground?.value,
      'accent1': _accent1?.value,
      'accent2': _accent2?.value,
      'accent3': _accent3?.value,
      'accent4': _accent4?.value,
    };
    // Remove null values
    colorMap.removeWhere((key, value) => value == null);
    return jsonEncode(colorMap);
  }
}
