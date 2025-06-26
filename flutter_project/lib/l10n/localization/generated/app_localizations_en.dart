// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get hello => 'Hello';

  @override
  String get welcome => 'Welcome to our app!';

  @override
  String get onBoarding_next => 'Next';

  @override
  String get onBoarding_skip => 'Skip';

  @override
  String get onBoarding_finish => 'Finish';

  @override
  String get onBoarding_pageview1_title => 'Welcome to Stora';

  @override
  String get onBoarding_pageview1_desc =>
      'Manage your stocks easily and efficiently.';

  @override
  String get onBoarding_pageview2_title => 'Real-time tracking';

  @override
  String get onBoarding_pageview2_desc =>
      'View the status of your stocks at any time.';

  @override
  String get onBoarding_pageview3_title => 'Smart alerts';

  @override
  String get onBoarding_pageview3_desc =>
      'Receive notifications in case of critical thresholds.';

  @override
  String get onBoarding_pageview4_title => 'Detailed reports';

  @override
  String get onBoarding_pageview4_desc =>
      'Analyze your data to optimize your management.';
}
