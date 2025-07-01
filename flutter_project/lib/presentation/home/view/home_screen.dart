import '/index.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AppState appState;
  late UserPrefs userPrefs;
  late ThemeController theme;

  @override
  void initState() {
    super.initState();

    if (ApiService.jwt == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go(Routes.login);
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    appState = context.read<AppState>();
    theme = context.read<ThemeController>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget buildMenuButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return Align(
      alignment: AlignmentDirectional(0, 0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.currentTheme.Primary,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          minimumSize: Size(
            MediaQuery.sizeOf(context).width * 0.5,
            MediaQuery.sizeOf(context).height * 0.05,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        ),
        child: Text(
          text,
          style: GoogleFonts.interTight(
            color: theme.currentTheme.PrimaryBackground,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: theme.currentTheme.PrimaryBackground,
      appBar: AppBar(
        backgroundColor: theme.currentTheme.Primary,
        automaticallyImplyLeading: false,
        leading: const SizedBox.shrink(),
        title: Align(
          alignment: AlignmentDirectional(0, 0),
          child: Text(
            locale!.homePage_menu,
            style: GoogleFonts.interTight(
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              color: theme.currentTheme.PrimaryBackground,
              fontSize: 22,
              letterSpacing: 0.0,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings_outlined,
              color: theme.currentTheme.SecondaryBackground,
              size: 24,
            ),
            onPressed: () {
              context.go(Routes.settings);
            },
          ),
        ],
        centerTitle: false,
        elevation: 2,
      ),
      body: SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildMenuButton(
              text: locale.homePage_stock,
              onPressed: () {
                context.go(Routes.stock);
              },
            ),
            const SizedBox(height: 16),
            if (appState.isAdmin) ...[
              buildMenuButton(
                text: locale.homePage_admin_employee,
                onPressed: () {
                  context.go(Routes.employees);
                },
              ),
              const SizedBox(height: 16),
              buildMenuButton(
                text: locale.homePage_admin_log,
                onPressed: () {
                  context.go(Routes.gestionLog);
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
