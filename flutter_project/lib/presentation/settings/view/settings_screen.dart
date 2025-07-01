import '/index.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String? logDuration = '7';
  final List<Color> _colorPalette = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.purple,
    Colors.orange,
    Colors.teal,
  ];
  bool _showColorPalette = false;

  @override
  Widget build(BuildContext context) {
    final userPrefs = context.watch<UserPrefs>();
    final themeController = context.watch<ThemeController>();
    final locale = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(locale.settings_title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.push(Routes.home),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Thème
            _buildSectionTitle(locale.settings_topic),
            _buildThemeSelector(themeController),
            if (_showColorPalette) ...[
              const SizedBox(height: 16),
              _buildColorPalette(context, themeController),
            ],
            const SizedBox(height: 20),

            // Section Langue
            _buildSectionTitle(locale.settings_language),
            _buildLanguageDropdown(userPrefs, locale),
            const SizedBox(height: 20),

            // Section Logs
            _buildSectionTitle(locale.settings_logs_duration),
            _buildLogDurationDropdown(locale),
            const SizedBox(height: 20),

            // Section Contact
            _buildSectionTitle(locale.settings_contact),
            _buildContactButton(locale),
            const SizedBox(height: 20),

            // Version de l'app
            _buildAppVersion(),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeSelector(ThemeController themeController) {
    return DropdownButton<ThemeType>(
      value: themeController.currentType,
      isExpanded: true,
      onChanged: (ThemeType? newType) {
        if (newType != null) {
          setState(() {
            _showColorPalette = newType == ThemeType.custom;
          });
          if (newType != ThemeType.custom) {
            themeController.switchTheme(newType);
          }
        }
      },
      items:
          ThemeType.values.map((type) {
            return DropdownMenuItem<ThemeType>(
              value: type,
              child: Text(_getThemeName(type)),
            );
          }).toList(),
    );
  }

  String _getThemeName(ThemeType type) {
    switch (type) {
      case ThemeType.light:
        return 'Light Theme';
      case ThemeType.dark:
        return 'Dark Theme';
      case ThemeType.custom:
        return 'Custom Theme';
    }
  }

  Widget _buildColorPalette(
    BuildContext context,
    ThemeController themeController,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select custom color:'),
        const SizedBox(height: 10),
        SizedBox(
          height: 60,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _colorPalette.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  _updateCustomTheme(themeController, _colorPalette[index]);
                },
                child: Container(
                  width: 50,
                  decoration: BoxDecoration(
                    color: _colorPalette[index],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _updateCustomTheme(ThemeController themeController, Color newColor) {
    //print('${custom_color.toString()} -> ${newColor.toString()}');

    setState(() {
      custom_color = newColor;
    });

    themeController.switchTheme(ThemeType.custom);
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

  Widget _buildLanguageDropdown(UserPrefs userPrefs, AppLocalizations locale) {
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

  Widget _buildLogDurationDropdown(AppLocalizations locale) {
    final theme = Theme.of(context);
    return DropdownButton<String>(
      isExpanded: true,
      value: logDuration ?? '30',
      dropdownColor: theme.cardColor,
      style: theme.textTheme.bodyMedium,
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() => logDuration = newValue);
        }
      },
      items: [
        DropdownMenuItem(value: '7', child: Text('7 ${locale.settings_days}')),
        DropdownMenuItem(
          value: '30',
          child: Text('30 ${locale.settings_days}'),
        ),
        DropdownMenuItem(
          value: '60',
          child: Text('60 ${locale.settings_days}'),
        ),
        DropdownMenuItem(
          value: '90',
          child: Text('90 ${locale.settings_days}'),
        ),
        DropdownMenuItem(
          value: '365',
          child: Text('365 ${locale.settings_days}'),
        ),
      ],
    );
  }

  Widget _buildContactButton(AppLocalizations locale) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.email),
      label: Text(locale.settings_contact),
      onPressed: () => _showContactDialog(locale),
    );
  }

  void _showContactDialog(AppLocalizations locale) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(locale.settings_contact),
            content: Text(
              'Email: support@example.com\n${locale.employee_display_update_popup_phone}: +123456789',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(locale.settings_close),
              ),
            ],
          ),
    );
  }

  Widget _buildAppVersion() {
    return const Text('Version: 1.0.0', style: TextStyle(color: Colors.grey));
  }
}
