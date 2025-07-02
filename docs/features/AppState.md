# Feature: AppState

## Description

`AppState` is a central application class that manages sensitive and critical user data, such as login details (email, password) and administrator status. It uses `FlutterSecureStorage` to guarantee the confidentiality and security of stored information.

## SecureStorage

### Description

`SecureStorage` is a Flutter package that provides a secure way to store sensitive data, such as user credentials (e.g., email and password). It uses platform-specific secure storage mechanisms to encrypt and store data securely. This ensures that sensitive information is protected from unauthorized access. Data stored in `SecureStorage` is not directly accessible by the user or other applications, making it ideal for storing confidential information.

### How it works:

- Data is encrypted before being stored on the device.
- Each platform uses its native secure storage system to manage encryption keys.
- Access to the stored data requires explicit permissions and is sandboxed to the application.

### Example Use Case:

- Storing user credentials securely:
	```dart
	final appState = context.watch<AppState>();
	appState.setEmail("user@example.com");
	appState.setPassword("securePassword123");
	await appState.setIsAdmin(true);
	```

- Accessing credentials securely:
  ```dart
  final appState = AppState();
  final email = await appState.Email;
  final password = await appState.Password;
  final isAdmin = await appState.isAdmin;
  print('Email: $email, Password: $password, Admin: $isAdmin');
  ```
