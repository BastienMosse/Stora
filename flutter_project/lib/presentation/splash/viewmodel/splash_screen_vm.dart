import '/index.dart';

class SplashScreenViewModel {
  final BuildContext context;
  final TickerProvider vsync;

  late final AnimationController animationController;
  late final Animation<double> fadeInAnimation;

  late final UserPrefs userPrefs;

  SplashScreenViewModel(this.context, this.vsync) {
    userPrefs = Provider.of<UserPrefs>(context, listen: false);

    animationController = AnimationController(
      vsync: vsync,
      duration: const Duration(seconds: 1),
    );

    fadeInAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeIn),
    );
  }

  void start() {
    animationController.forward();

    Timer(const Duration(seconds: 4), () {
      if (UserPrefs.FirstLaunch) {
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