# Feature: UserPrefs

## SharedPreferences

### Description

`SharedPreferences` is a Flutter package used for storing simple key-value pairs persistently on the device. It is ideal for saving non-sensitive data, such as user preferences (e.g., selected language, dark mode status, or first launch detection). Unlike `SecureStorage`, data stored in `SharedPreferences` is not encrypted, so it should not be used for sensitive information. However, it is lightweight and efficient for managing application settings.

### How it works:

- Data is stored in a local file on the device in plain text.
- It provides a simple API to save, retrieve, and delete key-value pairs.
- Data persists across app sessions and is accessible as long as the app is installed.

### Example Use Case:

- Accessing user preferences:
  ```dart
  final userPrefs = context.watch<UserPrefs>();
  final locale = userPrefs.Locale; // Retrieve the selected language
  final theme = userPrefs.TypeTheme; // Retrieve dark mode status
  print('Locale: ${locale.languageCode}, Theme: ${theme.value}');
  ```
- Setting user preferences:
  ```dart
  final userPrefs = context.watch<UserPrefs>();
  await appState.setLocale('fr'); // Save the selected language
  await appState.setDarkMode(true); // Enable dark mode
  ```