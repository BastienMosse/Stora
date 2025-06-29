import '/index.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
String? logDuration ;
  
  final colorPalette = <Color>[Colors.blue, const Color.fromARGB(255, 239, 141, 135), const Color.fromARGB(255, 151, 204, 153), const Color.fromARGB(255, 185, 109, 199), Colors.orange, Colors.teal, const Color.fromARGB(255, 136, 192, 237), const Color.fromARGB(255, 238, 232, 146)];

  @override
  Widget build(BuildContext context) {
    final userPrefs = context.watch<UserPrefs>();
    final theme = Theme.of(context);
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
            _buildSectionTitle(loc.themeSettings),
            _buildColorPalette(context, userPrefs),
            const SizedBox(height: 20),
            
            // Section Langue
            _buildSectionTitle(loc.language),
            _buildLanguageDropdown(userPrefs, loc),
            const SizedBox(height: 20),
            
            // Section Logs
            _buildSectionTitle(loc.logDuration),
            _buildLogDurationDropdown(),
            const SizedBox(height: 20),
            
            // Section Contact
            _buildSectionTitle(loc.contact),
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
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildColorPalette(BuildContext context, UserPrefs userPrefs) {
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
                onTap: () => userPrefs.setPrimaryColor(_colorPalette[index]),
                child: Container(
                  width: 50,
                  decoration: BoxDecoration(
                    color: _colorPalette[index],
                    borderRadius: BorderRadius.circular(8),
                    border: userPrefs.primaryColor.value == _colorPalette[index].value
                        ? Border.all(color: Colors.black, width: 2)
                        : null,
                  ),
                  child: userPrefs.primaryColor.value == _colorPalette[index].value
                      ? const Icon(Icons.check, color: Colors.white)
                      : null,
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
      items: AppLocalizations.supportedLocales.map((Locale locale) {
        return DropdownMenuItem<Locale>(
          value: locale,
          child: Text(_getLanguageName(locale.languageCode)),
        );
      }).toList(),
    );
  }

  String _getLanguageName(String code) {
    switch (code) {
      case 'en': return 'English';
      case 'fr': return 'Français';
      default: return code.toUpperCase();
    }
  }

  Widget _buildLogDurationDropdown() {
    return DropdownButton<String>(
      isExpanded: true,
      value: _selectedLogDuration ?? '30',
      onChanged: (String? newValue) {
        setState(() {
          _selectedLogDuration = newValue;
          // Sauvegarder la préférence
        });
      },
      items: const [
        DropdownMenuItem(value: '7', child: Text('7 jours')),
        DropdownMenuItem(value: '30', child: Text('30 jours')),
        DropdownMenuItem(value: '90', child: Text('90 jours')),
        DropdownMenuItem(value: '365', child: Text('1 an')),
      ],
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
      builder: (context) => AlertDialog(
        title: const Text('Contact'),
        content: const Text('Email: support@example.com\nTéléphone: +123456789'),
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
    return const Text(
      'Version: 1.0.0',
      style: TextStyle(color: Colors.grey),
    );
  }
}