import '/index.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final userPrefs = context.watch<UserPrefs>();

    return Consumer<AppState>(
      builder: (context, appState, _) {
        return MaterialApp.router(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: userPrefs.Locale,
          routerConfig: route,
        );
      },
    );
  }
}
