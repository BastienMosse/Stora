import '/index.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  
  late ThemeController theme;
  late AppLocalizations locale;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    theme = context.read<ThemeController>();
    locale = AppLocalizations.of(context)!;
  }

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

    return Scaffold(
      backgroundColor: theme.currentTheme.PrimaryBackground,
      appBar: AppBar(
        backgroundColor: theme.currentTheme.Primary,
        title: Text(
          locale.settings_title,
          style: GoogleFonts.interTight(
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              color:  theme.currentTheme.PrimaryBackground,
              fontSize: 22,
              letterSpacing: 0.0,
            ),
          ),
        leading: IconButton(
          icon:  Icon(Icons.arrow_back,color: theme.currentTheme.PrimaryBackground,),
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
    return 
    Theme(
      data:Theme.of(context).copyWith(
        canvasColor: theme.currentTheme.PrimaryBackground,
      ), 
      child: 
      DropdownButton<ThemeType>(
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
      items: ThemeType.values.map((type) {
        return DropdownMenuItem<ThemeType>(
          value: type,
          child: Text(_getThemeName(type),style:  TextStyle(color:theme.currentTheme.PrimaryText)),
        );
      }).toList(),
    )
    );
  }

  String _getThemeName(ThemeType type) {
    switch (type) {
      case ThemeType.light: return locale.settings_light_theme;
      case ThemeType.dark: return locale.settings_dark_theme;
      case ThemeType.custom: return locale.settings_custom_theme;
    }
  }

  Widget _buildColorPalette(
    BuildContext context,
    ThemeController themeController,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(locale.settings_select_custom_color,
          style: TextStyle(
            color: theme.currentTheme.PrimaryText,
          ),
        ),
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
        style:  TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: theme.currentTheme.PrimaryText),
      ),
    );
  }

  Widget _buildLanguageDropdown(UserPrefs userPrefs, AppLocalizations locale) {
    return 
    Theme(
      data:Theme.of(context).copyWith(
        canvasColor: theme.currentTheme.PrimaryBackground,
      ), 
      child: 
      DropdownButton<Locale>(
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
            child: Text(_getLanguageName(locale.languageCode),style:  TextStyle(color:theme.currentTheme.PrimaryText)),
          );
        }).toList(),
      )
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
    final theme2 = Theme.of(context);
    return Theme(
      data:Theme.of(context).copyWith(
        canvasColor: theme.currentTheme.PrimaryBackground,
      ), 
      child: 
      DropdownButton<String>(
        isExpanded: true,
        value: logDuration ?? '30',
        dropdownColor: theme.currentTheme.PrimaryBackground,
        style: theme2.textTheme.bodyMedium,
        onChanged: (String? newValue) {
          if (newValue != null) {
            setState(() => logDuration = newValue);
          }
        },
      
        items: [
          DropdownMenuItem(value: '7', child: Text('7 ${locale.settings_days}',style:  TextStyle(color:theme.currentTheme.PrimaryText))),
          DropdownMenuItem(value: '30', child: Text('30 ${locale.settings_days}',style:  TextStyle(color:theme.currentTheme.PrimaryText))),
          DropdownMenuItem(value: '60', child: Text('60 ${locale.settings_days}',style:  TextStyle(color:theme.currentTheme.PrimaryText))),
          DropdownMenuItem(value: '90', child: Text('90 ${locale.settings_days}',style:  TextStyle(color:theme.currentTheme.PrimaryText))),
          DropdownMenuItem(value: '365', child: Text('365 ${locale.settings_days}',style:  TextStyle(color:theme.currentTheme.PrimaryText))),
        ],
      )
    );
  }

  Widget _buildContactButton(AppLocalizations locale) {
    return ElevatedButton.icon(
      icon: Icon(Icons.email,color: theme.currentTheme.PrimaryBackground,),
      label: Text(locale.settings_contact, style:  TextStyle(color: theme.currentTheme.PrimaryBackground),),
      onPressed: () => _showContactDialog(locale),
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.currentTheme.Primary,
      ),
    );
  }

  void _showContactDialog(AppLocalizations locale) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: theme.currentTheme.PrimaryBackground,
        title: Text(locale.settings_contact,style:  TextStyle(color: theme.currentTheme.PrimaryText),),
        content: Text('Email: support@example.com\n${locale.employee_display_update_popup_phone}: +123456789',style:  TextStyle(color: theme.currentTheme.PrimaryText)),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.currentTheme.Primary,
            ),
            onPressed: () => Navigator.pop(context),
            child: Text(locale.settings_close, style: TextStyle(
                                color: theme.currentTheme.PrimaryText,
                              ),
            ),
          ),
        ]
      ),
    );
  }

  Widget _buildAppVersion() {

    return Text('Version: 1.0.0', style: TextStyle(color: theme.currentTheme.PrimaryText));
  }
}
