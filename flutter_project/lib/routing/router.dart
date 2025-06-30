import '/index.dart';
import 'routes.dart';

GoRouter route = GoRouter(
  initialLocation: Routes.initial,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: Routes.initial,
      redirect: (context, state) => Routes.splash
    ),
    GoRoute(
      path: Routes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: Routes.onboarding,
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: Routes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: Routes.home,
      builder: (context, state) => const HomeScreen()
    ),
    GoRoute(
      path: Routes.settings,
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: Routes.stock,
      builder: (context, state) => const GestionStockWidget(),
    ),
    GoRoute(
      path: Routes.employees,
      builder: (context, state) => const EmployeesScreen(),
    ),
    GoRoute(
      path: Routes.employeesDisplay,
      builder: (context, state) {
        return EmployeeDisplay(userId: state.extra as String);
      },
    ),
  ],
);
