import '/index.dart';

class LoginScreenViewModel {
  late final BuildContext context;

  late final UserPrefs userPrefs;

  void init(BuildContext context) {
    this.context = context;
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
        onError('Login and password cannot be empty');
        return;
      }

      AuthLoginRequest request = AuthLoginRequest(
        login: login,
        password: password,
      );
      AuthLoginResponse? response = await Endpoints.login(request);

      if (response == null) {
        onError('Login failed. Please check your credentials.');
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

  void dispose() {}
}
