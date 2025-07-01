import '/index.dart';

import 'popup/employee_display_update_popup.dart';
import '../viewmodel/employee_display_screen_vm.dart';

class EmployeeDisplayScreen extends StatefulWidget {
  final String userId;

  const EmployeeDisplayScreen({super.key, required this.userId});

  @override
  State<EmployeeDisplayScreen> createState() => _EmployeeDisplayScreenState();
}

class _EmployeeDisplayScreenState extends State<EmployeeDisplayScreen>
    with RouteAware {
  late EmplyeeDisplayScreenViewModel viewModel;

  late ThemeController theme;
  late AppLocalizations locale;

  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();

    if (ApiService.jwt == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go(Routes.login);
      });
    }

    viewModel = EmplyeeDisplayScreenViewModel();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!context.watch<AppState>().isAdmin) {
      context.go(Routes.home);
    }

    theme = context.read<ThemeController>();
    locale = AppLocalizations.of(context)!;

    viewModel.init(context);
    _fetchAndRefresh();
  }

  Future<void> _fetchAndRefresh() async {
    await viewModel.fetchUserId(widget.userId);
    if (mounted) setState(() {});
  }

  Future<void> _refreshData() async {
    if (_isRefreshing) return;

    setState(() {
      _isRefreshing = true;
    });

    await viewModel.fetchUserId(widget.userId);

    if (mounted) {
      setState(() {
        _isRefreshing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageWidth = MediaQuery.of(context).size.width * 0.4;
    final imageHeight = MediaQuery.of(context).size.height * 0.2;

    return Scaffold(
      backgroundColor: theme.currentTheme.PrimaryBackground,
      appBar: AppBar(
        backgroundColor: theme.currentTheme.Primary,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: theme.currentTheme.PrimaryBackground,
          ),
          onPressed: () => context.go(Routes.employees),
        ),
        elevation: 2,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: imageWidth,
                          height: imageHeight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: theme.currentTheme.Primary,
                              width: 2,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child:
                                (viewModel.user?.photo != null &&
                                        viewModel.user!.photo.isNotEmpty)
                                    ? Image.network(
                                      viewModel.user!.photo,
                                      width: imageWidth,
                                      height: imageHeight,
                                      fit: BoxFit.cover,
                                      loadingBuilder: (
                                        context,
                                        child,
                                        loadingProgress,
                                      ) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value:
                                                loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        (loadingProgress
                                                                .expectedTotalBytes ??
                                                            1)
                                                    : null,
                                          ),
                                        );
                                      },
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Center(
                                                child: Icon(
                                                  Icons.person,
                                                  size: 64,
                                                  color:
                                                      theme
                                                          .currentTheme
                                                          .PrimaryText,
                                                ),
                                              ),
                                    )
                                    : Center(
                                      child: Icon(
                                        Icons.person,
                                        size: 64,
                                        color: theme.currentTheme.PrimaryText,
                                      ),
                                    ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                viewModel.user?.username ?? '',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: theme.currentTheme.PrimaryText,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'id : ${viewModel.user?.id ?? ''}',
                                style: TextStyle(
                                  color: theme.currentTheme.PrimaryText,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'login : ${viewModel.user?.login ?? ''}',
                                style: TextStyle(
                                  color: theme.currentTheme.PrimaryText,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'role : ${viewModel.user?.role ?? ''}',
                                style: TextStyle(
                                  color: theme.currentTheme.PrimaryText,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${locale.employee_display_page_Born} ${viewModel.user?.birth != null ? viewModel.user!.birth.split('T').first : ''}',
                                style: TextStyle(
                                  color: theme.currentTheme.PrimaryText,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${locale.employee_display_page_phone} ${viewModel.user?.tel ?? ''}',
                                style: TextStyle(
                                  color: theme.currentTheme.PrimaryText,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'email : ${viewModel.user?.email ?? ''}',
                                style: TextStyle(
                                  color: theme.currentTheme.PrimaryText,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${locale.employee_display_page_pay} ${viewModel.user?.pay ?? ''} \$',
                                style: TextStyle(
                                  color: theme.currentTheme.PrimaryText,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Text(
                          locale.employee_display_update_popup_note,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: theme.currentTheme.PrimaryText,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      height: 80,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: theme.currentTheme.PrimaryBackground,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12),
                        ),
                        border: Border.all(
                          color: theme.currentTheme.Primary,
                          width: 1,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          viewModel.user?.note ?? '',
                          style: GoogleFonts.interTight(
                            color: theme.currentTheme.PrimaryText,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 150,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () async {
                        await showDialog<bool>(
                          context: context,
                          builder:
                              (context) =>
                                  EmployeeUpdatePopup(user: viewModel.user!),
                        );
                        await _refreshData();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.currentTheme.Primary,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        textStyle: GoogleFonts.interTight(
                          color: theme.currentTheme.PrimaryText,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      child: Text(
                        locale.employee_display_page_modify,
                        style: GoogleFonts.interTight(
                          color: theme.currentTheme.PrimaryBackground,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    width: 150,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          viewModel.deleteUser(widget.userId);
                          context.go(Routes.employees);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                locale.employee_display_page_supr_log,
                              ),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.currentTheme.Primary,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        textStyle: GoogleFonts.interTight(
                          color: theme.currentTheme.PrimaryText,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      child: Text(
                        locale.employee_display_page_supr,
                        style: GoogleFonts.interTight(
                          color: theme.currentTheme.PrimaryBackground,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
