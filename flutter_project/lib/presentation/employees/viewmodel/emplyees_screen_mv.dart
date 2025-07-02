import '/index.dart';

class EmplyeesScreenViewModel {
  late AppState appState;
  late UserPrefs userPrefs;
  late ThemeController theme;
  late AppLocalizations locale;

  late FocusNode searchNode;
  late TextEditingController searchController;

  late List<User> userList;
  late List<User> filteredUserList;

  EmployeesFilterData? currentFilters;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  EmplyeesScreenViewModel() {
    searchNode = FocusNode();
    searchController = TextEditingController();
    userList = [];
    filteredUserList = [];

    searchController.addListener(() {
      applyFilters();
    });
  }

  void init(BuildContext context) {
    appState = context.read<AppState>();
    theme = context.read<ThemeController>();
    locale = AppLocalizations.of(context)!;
  }

  Future<void> fetchUserList() async {
    if (_isLoading) return;

    _isLoading = true;
    try {
      UserListResponse? response = await Endpoints.getUserList();
      userList = response != null ? response.users : [];
      filteredUserList = List.from(userList);
      applyFilters();
    } catch (e) {
      print('Error getting user list: $e');
      userList = [];
      filteredUserList = [];
    } finally {
      _isLoading = false;
    }
  }

  void setFilters(EmployeesFilterData filters) {
    currentFilters = filters;
    applyFilters();
  }

  void applyFilters() {
    filteredUserList =
        userList.where((user) {
          final searchQuery = searchController.text.toLowerCase();
          final matchesSearch =
              searchQuery.isEmpty ||
              user.login.toLowerCase().contains(searchQuery) ||
              user.username.toLowerCase().contains(searchQuery) ||
              user.email.toLowerCase().contains(searchQuery);

          if (!matchesSearch) return false;

          if (currentFilters != null) {
            if (currentFilters!.login.isNotEmpty &&
                !user.login.toLowerCase().contains(
                  currentFilters!.login.toLowerCase(),
                )) {
              return false;
            }

            if (currentFilters!.firstName.isNotEmpty &&
                !user.username.toLowerCase().contains(
                  currentFilters!.firstName.toLowerCase(),
                )) {
              return false;
            }

            if (currentFilters!.lastName.isNotEmpty &&
                !user.username.toLowerCase().contains(
                  currentFilters!.lastName.toLowerCase(),
                )) {
              return false;
            }
          }

          return true;
        }).toList();
  }

  void clearFilters() {
    currentFilters = null;
    searchController.clear();
    applyFilters();
  }

  Future<void> refreshUserList() async {
    _isLoading = false;
    await fetchUserList();
  }

  void dispose() {
    searchNode.dispose();
    searchController.dispose();
  }
}
