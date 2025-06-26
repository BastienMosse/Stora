// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get hello => 'Bonjour';

  @override
  String get welcome => 'Bienvenue dans notre application !';

  @override
  String get onBoarding_next => 'Suivant';

  @override
  String get onBoarding_skip => 'Passer';

  @override
  String get onBoarding_finish => 'Terminer';

  @override
  String get onBoarding_pageview1_title => 'Bienvenue sur Stora';

  @override
  String get onBoarding_pageview1_desc =>
      'Gérez vos stocks facilement et efficacement.';

  @override
  String get onBoarding_pageview2_title => 'Suivi en temps réel';

  @override
  String get onBoarding_pageview2_desc =>
      'Visualisez l’état de vos stocks à tout moment.';

  @override
  String get onBoarding_pageview3_title => 'Alertes intelligentes';

  @override
  String get onBoarding_pageview3_desc =>
      'Recevez des notifications en cas de seuil critique.';

  @override
  String get onBoarding_pageview4_title => 'Rapports détaillés';

  @override
  String get onBoarding_pageview4_desc =>
      'Analysez vos données pour optimiser votre gestion.';
}
