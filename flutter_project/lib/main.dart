import 'index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  GoRouter.optionURLReflectsImperativeAPIs = true;
  usePathUrlStrategy();

  UserPrefs userPrefs = UserPrefs();
  await userPrefs.init();

  AppState appState = AppState();
  await appState.init();

  ThemeController themeController = ThemeController();
  themeController.init(userPrefs);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: appState),
        ChangeNotifierProvider.value(value: userPrefs),
        ChangeNotifierProvider.value(value: themeController),
      ],
      child: MainApp(),
    ),
  );
}
