import '/index.dart';

class EmplyeeDisplayScreenViewModel {
  late AppState appState;
  late UserPrefs userPrefs;
  late ThemeController theme;
  late AppLocalizations locale;

  late UserResponse? user;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  EmplyeeDisplayScreenViewModel();

  void init(BuildContext context) {
    appState = context.read<AppState>();
    userPrefs = context.read<UserPrefs>();
    theme = context.read<ThemeController>();
    locale = AppLocalizations.of(context)!;
    user = null;
  }

  Future<void> fetchUserId(String id) async {
    if (_isLoading) return;

    _isLoading = true;
    try {
      UserResponse? response = await Endpoints.getUserById(id);
      if (response != null) {
        user = response;
      }
    } catch (e) {
      print('Error getting user : $e');
    } finally {
      _isLoading = false;
    }
  }

  Future<void> deleteUser(String id) async {
    print('Deleting user with ID: $id');
    if (_isLoading) return;

    _isLoading = true;
    try {
      Message? response = await Endpoints.deleteUserById(id);
      if (response != null) {
        user = null;
      }
    } catch (e) {
      print('Error deleting user : $e');
    } finally {
      _isLoading = false;
    }
  }
}
