import '/index.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // Récupère les traductions via AppLocalizations
    final loc = AppLocalizations.of(context)!;
    final appState = Provider.of<AppState>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.hello), // Affiche "hello" dans la langue active
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(loc.welcome), // Affiche "welcome" dans la langue active
            const SizedBox(height: 20),
            // DropdownButton pour changer la langue
            DropdownButton<Locale>(
              value: Localizations.localeOf(context),
              onChanged: (Locale? newLocale) {
                if (newLocale != null) {
                  appState.setLocale(newLocale.languageCode);
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
