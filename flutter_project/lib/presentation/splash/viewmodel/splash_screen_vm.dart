import '/index.dart';

class SplashScreenViewModel {
  final TickerProvider vsync;

  late final AnimationController animationController;
  late final Animation<double> fadeInAnimation;
  late final UserPrefs userPrefs;

  SplashScreenViewModel(this.vsync);

  void init(UserPrefs prefs) {
    userPrefs = prefs;

    animationController = AnimationController(
      vsync: vsync,
      duration: const Duration(seconds: 1),
    );

    fadeInAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeIn),
    );
  }

  void start(BuildContext context) {
    animationController.forward();

    Timer(const Duration(seconds: 4), () {
      if (userPrefs.FirstLaunch) {
        context.go('/onboarding');
      } else {
        context.go('/home');
      }
    });
  }

  void dispose() {
    animationController.dispose();
  }
}
