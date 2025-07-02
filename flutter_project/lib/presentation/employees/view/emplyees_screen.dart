import '/index.dart';

import 'popup/employees_filter_popup.dart';
import 'popup/employees_create_popup.dart';

import '../viewmodel/emplyees_screen_mv.dart';

class EmployeesScreen extends StatefulWidget {
  const EmployeesScreen({super.key});

  @override
  State<EmployeesScreen> createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends State<EmployeesScreen> {
  late AppState appState;
  late UserPrefs userPrefs;
  late ThemeController theme;
  late AppLocalizations locale;

  late EmplyeesScreenViewModel viewModel;
  late Future<void> _initialFetchFuture;

  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();

    if (ApiService.jwt == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go(Routes.login);
      });
    }

    viewModel = EmplyeesScreenViewModel();
    _initialFetchFuture = viewModel.fetchUserList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!context.watch<AppState>().isAdmin) {
      context.go(Routes.home);
    }

    appState = context.read<AppState>();
    theme = context.read<ThemeController>();
    locale = AppLocalizations.of(context)!;

    viewModel.init(context);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  Future<void> _refreshData() async {
    if (_isRefreshing) return;

    setState(() {
      _isRefreshing = true;
    });

    await viewModel.refreshUserList();

    setState(() {
      _isRefreshing = false;
    });
  }

  Widget buildEmployeeCard(User user) {
    return InkWell(
      onTap: () {
        context.go(Routes.employeesDisplay, extra: user.id);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: theme.currentTheme.Primary, width: 2),
          borderRadius: BorderRadius.circular(12),
          color: theme.currentTheme.PrimaryBackground,
        ),
        child: Card(
          elevation: 0,
          color: theme.currentTheme.PrimaryBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: theme.currentTheme.Primary,
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child:
                        user.photo.isNotEmpty
                            ? Image.network(
                              user.photo,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.person,
                                  size: 32,
                                  color: theme.currentTheme.PrimaryBackground,
                                );
                              },
                            )
                            : Icon(
                              Icons.person,
                              size: 32,
                              color: theme.currentTheme.PrimaryText,
                            ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.login,
                        style: TextStyle(
                          color: theme.currentTheme.PrimaryText,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        '${locale.employee_screen_username} ${user.username.isEmpty ? '-' : user.username}',
                        style: TextStyle(
                          color: theme.currentTheme.PrimaryText,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        'email: ${user.email.isEmpty ? '-' : user.email}',
                        style: TextStyle(
                          color: theme.currentTheme.PrimaryText,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.currentTheme.PrimaryBackground,
      appBar: AppBar(
        backgroundColor: theme.currentTheme.Primary,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: theme.currentTheme.PrimaryBackground,
            size: 24,
          ),
          onPressed: () {
            context.go(Routes.home);
          },
        ),
        title: Text(
          locale.employee_screen_Employer,
          style: GoogleFonts.interTight(
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal,
            color: theme.currentTheme.PrimaryBackground,
            fontSize: 22,
            letterSpacing: 0.0,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        top: true,
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 16),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    iconSize: 40,
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder:
                            (context) => EmployeesFilterPopup(
                              initialFilters: viewModel.currentFilters,
                              onFiltersApplied: (filterData) {
                                viewModel.setFilters(filterData);
                                setState(() {});
                              },
                            ),
                      );
                    },
                    icon: Container(
                      decoration: BoxDecoration(
                        color: theme.currentTheme.Primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      width: 40,
                      height: 40,
                      child: Icon(
                        Icons.filter_alt,
                        color: theme.currentTheme.PrimaryBackground,
                        size: 24,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        width: 200,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: theme.currentTheme.Primary,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextFormField(
                          controller: viewModel.searchController,
                          focusNode: viewModel.searchNode,
                          onChanged: (value) {
                            setState(() {});
                          },
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: locale.employee_screen_hint,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: theme.currentTheme.PrimaryBackground,
                            prefixIcon: Icon(
                              FontAwesomeIcons.magnifyingGlass,
                              color: theme.currentTheme.Primary,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Expanded(
                child:
                    _isRefreshing
                        ? Center(child: CircularProgressIndicator())
                        : FutureBuilder<void>(
                          future: _initialFetchFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${locale.employee_screen_err}: ${snapshot.error}',
                                    ),
                                    ElevatedButton(
                                      onPressed: _refreshData,
                                      child: Text(locale.employee_screen_retry),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return RefreshIndicator(
                                onRefresh: _refreshData,
                                child: ListView.builder(
                                  itemCount: viewModel.filteredUserList.length,
                                  itemBuilder: (context, index) {
                                    return buildEmployeeCard(
                                      viewModel.filteredUserList[index],
                                    );
                                  },
                                ),
                              );
                            }
                          },
                        ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: SizedBox(
                  width: 250,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () async {
                      final result = await showDialog<bool>(
                        context: context,
                        builder: (context) => const EmployeeCreatePopup(),
                      );

                      if (result == true) {
                        await _refreshData();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.currentTheme.Primary,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                      textStyle: Theme.of(
                        context,
                      ).textTheme.titleSmall?.copyWith(
                        color: theme.currentTheme.Primary,
                        fontFamily: GoogleFonts.interTight().fontFamily,
                      ),
                    ),
                    child: Text(
                      '+',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: theme.currentTheme.PrimaryBackground,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
