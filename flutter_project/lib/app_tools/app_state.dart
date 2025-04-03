import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef AppLocale = Locale;

class AppState extends ChangeNotifier {
	static final AppState _instance = AppState._internal();
	factory AppState() => _instance;
	AppState._internal() {
		_loadPersistedData();
	}

	final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

	Future<void> _loadPersistedData() async {
		// Get the secure storage instance
		_email = await _secureStorage.read(key: 'user_email') ?? '';
		_password = await _secureStorage.read(key: 'user_password') ?? '';

		// Get the shared preferences instance
		final prefs = await SharedPreferences.getInstance();
		_darkMode = prefs.getBool('dark_mode') ?? false;
		_firstLaunch = prefs.getBool('first_launch') ?? true;
    _locale = AppLocale(prefs.getString('language_code') ?? 'en');
    
		notifyListeners();
	}

	void update(VoidCallback callback) {
		callback();
		notifyListeners();
	}

	// 🚀 First launch (Persistant)
	bool _firstLaunch = true;
	bool get FirstLaunch => _firstLaunch;
	Future<void> setFirstLaunch(bool value) async {
		_firstLaunch = value;
		final prefs = await SharedPreferences.getInstance();
		await prefs.setBool('first_launch', value);
		notifyListeners();
	}

  // 🌍 Language (Persistant)
  AppLocale _locale = AppLocale('en');
  AppLocale get Locale => _locale;
  Future<void> setLocale(String locale) async {
    _locale = AppLocale(locale);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', locale);
    notifyListeners();  
  }

	// 🌙 Dark mode (Persistant)
	bool _darkMode = false;
	bool get DarkMode => _darkMode;
	Future<void> setDarkMode(bool value) async {
		_darkMode = value;
		final prefs = await SharedPreferences.getInstance();
		await prefs.setBool('dark_mode', value);
		notifyListeners();
	}




	// 🔑 Email (Persistant and secured)
	String _email = '';
	String get Email => _email;
	Future<void> setEmail(String value) async {
		_email = value;
		await _secureStorage.write(key: 'user_email', value: value);
		notifyListeners();
	}

	// 🔑 Password (Persistant and secured)
	String _password = '';
	String get Password => _password;
	Future<void> setPassword(String value) async {
		_password = value;
		await _secureStorage.write(key: 'user_password', value: value);
		notifyListeners();
	}




	// 🔄 Reset to default params
	Future<void> clearSecureData() async {
		await _secureStorage.deleteAll();
		_email = '';
		_password = '';

		final prefs = await SharedPreferences.getInstance();
		await prefs.remove('dark_mode');
		_darkMode = false;

		notifyListeners();
	}
}
