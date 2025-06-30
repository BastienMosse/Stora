import '/index.dart';
import '/core/theme/app_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String? logDuration = '7';

  final List<Color> _colorPalette = [];

  @override
  void initState() {
    super.initState();
    final theme = context.watch<ThemeController>();

    theme.currentType; // pour récup le type ( énum )
    theme.currentTheme; // pour récup le thème ( instance )
  }

  @override
  Widget build(BuildContext context) {
    final userPrefs = context.watch<UserPrefs>();
    final theme = context.watch<ThemeController>();
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Thème
            _buildSectionTitle(loc.settings_topic),
            _buildColorPalette(context, userPrefs),
            const SizedBox(height: 20),

            // je peux faire loc. un truc qui permet d'acceder direct au titre? ou à la langue?
            // Section Langue
            _buildSectionTitle(loc.settings_language),
            _buildLanguageDropdown(userPrefs, loc),
            const SizedBox(height: 20),

            // Section Logs
            _buildSectionTitle(loc.settings_logs_duration),
            _buildLogDurationDropdown(),
            const SizedBox(height: 20),

            // Section Contact
            _buildSectionTitle(loc.settings_contact),
            _buildContactButton(context),
            const SizedBox(height: 20),

            // Version de l'app
            _buildAppVersion(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildColorPalette(BuildContext context, UserPrefs userPrefs) {
    final userPrefs = context.watch<UserPrefs>();
    final theme = context.watch<ThemeController>();
    final loc = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(loc.selectThemeColor),
        const SizedBox(height: 10),
        SizedBox(
          height: 60,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _colorPalette.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap:
                    () =>
                        {}, // userPrefs.setPrimaryColor(_colorPalette[index]),
                child: Container(
                  width: 50,
                  decoration: BoxDecoration(
                    color: _colorPalette[index],
                    borderRadius: BorderRadius.circular(8),
                    border: null,
                    /*userPrefs.primaryColor.value ==
                                _colorPalette[index].value
                            ? Border.all(color: Colors.black, width: 2)
                            : null,*/
                  ),
                  child:
                      /*userPrefs.primaryColor.value == _colorPalette[index].value
                          ? const Icon(Icons.check, color: Colors.white)
                          :*/
                      null,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLanguageDropdown(UserPrefs userPrefs, AppLocalizations loc) {
    return DropdownButton<Locale>(
      isExpanded: true,
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
              child: Text(_getLanguageName(locale.languageCode)),
            );
          }).toList(),
    );
  }

  String _getLanguageName(String code) {
    switch (code) {
      case 'en':
        return 'English';
      case 'fr':
        return 'Français';
      default:
        return code.toUpperCase();
    }
  }

  // Méthode pour initialiser depuis SharedPreferences
  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    //logDuration = prefs.getString('log_duration') ?? '30'; // Valeur par défaut
    //notifyListeners();
  }

  Future<void> setLogDuration(String duration) async {
    // Validation des valeurs autorisées
    const validDurations = {'7', '30', '60', '90', '365'};
    if (!validDurations.contains(duration)) {
      throw ArgumentError('Durée de log non valide: $duration');
    }

    // Sauvegarde dans les préférences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('log_duration', duration);

    // Mise à jour de l'état local
    //logDuration = duration;
    //notifyListeners(); // Notifie les écouteurs du changement
  }

  Widget _buildLogDurationDropdown() {
    final userPrefs = context.watch<UserPrefs>();
    final theme = Theme.of(context); // Utilisation du Theme standard
    final loc = AppLocalizations.of(context)!;

    // Définition des constantes pour les valeurs
    const durations = {
      '7': '7',
      '30': '30',
      '60': '60',
      '90': '90',
      '365': '365',
    };

    return DropdownButton<String>(
      isExpanded: true,
      value: logDuration ?? '30', // Valeur par défaut '30'
      dropdownColor: theme.cardColor, // Style cohérent avec le thème
      style: theme.textTheme.bodyMedium,
      onChanged: (String? newValue) async {
        if (newValue != null) {
          //await userPrefs.setLogDuration(newValue);
          setState(() => logDuration = newValue);
        }
      },
      items:
          durations.entries.map((entry) {
            return DropdownMenuItem<String>(
              value: entry.key,
              child: Text('${entry.value} ${loc.settings_days}'),
            );
          }).toList(),
    );
  }

  Widget _buildContactButton(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.email),
      label: const Text('Contactez-nous'),
      onPressed: () => _showContactDialog(context),
    );
  }

  void _showContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Contact'),
            content: const Text(
              'Email: support@example.com\nTéléphone: +123456789',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Fermer'),
              ),
            ],
          ),
    );
  }

  Widget _buildAppVersion() {
    return const Text('Version: 1.0.0', style: TextStyle(color: Colors.grey));
  }
}
