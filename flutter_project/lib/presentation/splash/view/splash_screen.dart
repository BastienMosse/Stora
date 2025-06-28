import '/index.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late SplashScreenViewModel viewModel;

  late final UserPrefs prefs;
  late final ThemeController theme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    prefs = Provider.of<UserPrefs>(context, listen: false);
    theme = Provider.of<ThemeController>(context, listen: false);

    viewModel = SplashScreenViewModel(this);
    viewModel.init(prefs);
    viewModel.start(context);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.currentTheme.PrimaryBackground,
      body: FadeTransition(
        opacity: viewModel.fadeInAnimation,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'lib/assets/icons/logo.jpg',
                  width: 150,
                  height: 150,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                appName,
                style: TextStyle(
                  fontFamily: titleFont,
                  fontSize: titleFontSize.toDouble(),
                  color: theme.currentTheme.PrimaryText,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  theme.currentTheme.Primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
