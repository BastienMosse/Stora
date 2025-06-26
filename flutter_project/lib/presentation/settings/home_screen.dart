import '/index.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final userPrefs = context.watch<UserPrefs>();
    final appState = context.watch<AppState>();
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(loc.hello)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(loc.welcome),
            const SizedBox(height: 20),
            DropdownButton<Locale>(
              value: Localizations.localeOf(context),
              onChanged: (Locale? newLocale) {
                if (newLocale != null) {
                  userPrefs.setLocale(newLocale);
                }
              },
              items:
                  AppLocalizations.supportedLocales.map((Locale locale) {
                    return DropdownMenuItem<Locale>(
                      value: locale,
                      child: Text(locale.languageCode.toUpperCase()),
                    );
                  }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
