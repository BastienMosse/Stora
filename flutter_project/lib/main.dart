import 'index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  
  GoRouter.optionURLReflectsImperativeAPIs = true;
  usePathUrlStrategy();

  await AppState.init();
  await UserPrefs.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AppState.instance),
        ChangeNotifierProvider.value(value: UserPrefs.instance),
      ],
      child: MainApp(),
    ),

  );
}
