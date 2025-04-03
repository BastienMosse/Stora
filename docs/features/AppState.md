# Feature: AppState

## Description
`AppState` is a core class in the application that manages global app state.
It uses the `ChangeNotifier` class to notify widgets about state changes.

## Features

### SecureStorage

#### Description

`SecureStorage` is a Flutter package that provides a secure way to store sensitive data, such as user credentials (e.g., email and password). It uses platform-specific secure storage mechanisms to encrypt and store data securely. This ensures that sensitive information is protected from unauthorized access. Data stored in `SecureStorage` is not directly accessible by the user or other applications, making it ideal for storing confidential information.

#### How it works:

- Data is encrypted before being stored on the device.
- Each platform uses its native secure storage system to manage encryption keys.
- Access to the stored data requires explicit permissions and is sandboxed to the application.

#### Example Use Case:

- Storing user credentials securely:
	```dart
	final appState = AppState();
	await appState.setEmail("user@example.com");
	await appState.setPassword("securePassword123");
	```

- Accessing credentials securely:
  ```dart
  final appState = AppState();
  final email = await appState.Email;
  final password = await appState.Password;
  print('Email: $email, Password: $password');
  ```

### SharedPreferences

#### Description

`SharedPreferences` is a Flutter package used for storing simple key-value pairs persistently on the device. It is ideal for saving non-sensitive data, such as user preferences (e.g., selected language, dark mode status, or first launch detection). Unlike `SecureStorage`, data stored in `SharedPreferences` is not encrypted, so it should not be used for sensitive information. However, it is lightweight and efficient for managing application settings.

#### How it works:

- Data is stored in a local file on the device in plain text.
- It provides a simple API to save, retrieve, and delete key-value pairs.
- Data persists across app sessions and is accessible as long as the app is installed.

#### Example Use Case:

- Accessing user preferences:
  ```dart
  final appState = AppState();
  final locale = appState.Locale; // Retrieve the selected language
  final isDarkMode = appState.DarkMode; // Retrieve dark mode status
  print('Locale: $locale, Dark Mode: $isDarkMode');
  ```
- Setting user preferences:
  ```dart
  final appState = AppState();
  await appState.setLocale('fr'); // Save the selected language
  await appState.setDarkMode(true); // Enable dark mode
  ```

### Key Differences:
| Feature               | SecureStorage                          | SharedPreferences                     |
|-----------------------|----------------------------------------|---------------------------------------|
| **Purpose**           | Securely store sensitive data          | Store non-sensitive key-value pairs   |
| **Encryption**        | Yes                                    | No                                    |
| **Use Cases**         | User credentials, tokens               | Preferences, settings, flags          |
| **Performance**       | Slightly slower due to encryption      | Fast and lightweight                  |

## Params

### 🌍 Language Management (Persistent)
- Dynamically change the application's language.
- Persist the selected language across sessions using `SharedPreferences`.
- **Methods**:
  - `AppLocale get Locale`: Retrieves the current language.
  - `Future<void> setLocale(String locale)`: Updates the language and persists it.

### 🌙 Dark Mode (Persistent)
- Enable or disable dark mode for the application.
- Persist the dark mode preference using `SharedPreferences`.
- **Methods**:
  - `bool get darkMode`: Retrieves the current dark mode status.
  - `Future<void> setDarkMode(bool value)`: Updates the dark mode preference and persists it.

### 🚀 First Launch Detection (Persistent)
- Detect whether the application is being launched for the first time.
- Persist this information using `SharedPreferences`.
- **Methods**:
  - `bool get FirstLaunch`: Retrieves the first launch status.
  - `Future<void> setFirstLaunch(bool value)`: Updates the first launch status and persists it.

### 🔑 Secure User Data (Persistent and Secured)
- Store sensitive user data (e.g., email and password) securely using `FlutterSecureStorage`.
- **Methods**:
  - `String get Email`: Retrieves the stored email.
  - `Future<void> setEmail(String value)`: Updates and securely stores the email.
  - `String get Password`: Retrieves the stored password.
  - `Future<void> setPassword(String value)`: Updates and securely stores the password.

### 🔄 Reset to Default Parameters
- Clear all stored data, including secure data and preferences.
- **Methods**:
  - `Future<void> clearSecureData()`: Resets all secure and persistent data to default values.
