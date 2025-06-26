import '/index.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late SplashScreenViewModel viewModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final prefs = Provider.of<UserPrefs>(context, listen: false);
    viewModel = SplashScreenViewModel(this)..init(prefs);
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
      backgroundColor: darkPrimary,
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
                  color: darkTextDark,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(darkWidget),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
