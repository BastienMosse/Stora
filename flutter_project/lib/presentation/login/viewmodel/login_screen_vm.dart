import '/index.dart';

late AppLocalizations locale;

class LoginScreenViewModel {
  BuildContext? _context;
  late final UserPrefs userPrefs;

  void init(BuildContext context) {
    if (_context != null) return;

    locale = AppLocalizations.of(context)!;
    _context = context;
  }

  BuildContext get context {
    if (_context == null) {
      throw StateError(
        'LoginScreenViewModel not initialized. Call init() first.',
      );
    }
    return _context!;
  }

  void toggleRememberMe(bool value) {
    final userPrefs = context.read<UserPrefs>();
    userPrefs.setRememberMe(value);

    if (!value) {
      context.read<AppState>().setLogin('');
      context.read<AppState>().setPassword('');
    }
  }

  Future<void> login(
    String login,
    String password, {
    required Function(String) onError,
  }) async {
    try {
      if (login.isEmpty || password.isEmpty) {
        onError(locale.login_screen_vm_err_login_password_empty);
        return;
      }

      AuthLoginRequest request = AuthLoginRequest(
        login: login,
        password: password,
      );
      AuthLoginResponse? response = await Endpoints.login(request);

      if (response == null) {
        onError(locale.login_screen_vm_err_login_failed);
        return;
      }

      if (context.read<UserPrefs>().RememberMe) {
        context.read<AppState>().setLogin(login);
        context.read<AppState>().setPassword(password);
      }

      context.read<AppState>().setIsAdmin(
        response.user.role == Role.ADMIN.value,
      );

      context.go('/home');
    } catch (e) {
      onError(e.toString());
    }
  }

  void dispose() {
    _context = null;
  }
}
