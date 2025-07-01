import 'package:stora/index.dart';

import '../viewmodel/log_display_screen_vm.dart';

class LogDisplayScreen extends StatefulWidget {
  final String logId;

  const LogDisplayScreen({super.key, required this.logId});

  @override
  State<LogDisplayScreen> createState() => _LogDisplayScreenState();
}

class _LogDisplayScreenState extends State<LogDisplayScreen> {
  late LogDisplayScreenViewModel viewModel;

  late ThemeController theme;
  late AppLocalizations locale;

  @override
  void initState() {
    super.initState();

    if (ApiService.jwt == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go(Routes.login);
      });
    }

    viewModel = LogDisplayScreenViewModel();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!context.watch<AppState>().isAdmin) {
      context.go(Routes.home);
    }

    theme = context.watch<ThemeController>();
    locale = AppLocalizations.of(context)!;

    viewModel.init(context);
    _fetchAndRefresh();
  }

  Future<void> _fetchAndRefresh() async {
    await viewModel.fetchLogId(widget.logId);
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = viewModel.theme;
    final locale = viewModel.locale;
    final log = viewModel.log;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.currentTheme.Primary,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: theme.currentTheme.PrimaryBackground,
          ),
          onPressed: () => context.go(Routes.log),
        ),
        title: Text(
          locale.log_display_logs,
          style: TextStyle(
            color: theme.currentTheme.PrimaryBackground,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      backgroundColor: theme.currentTheme.PrimaryBackground,
      body:
          viewModel.isLoading
              ? Center(child: CircularProgressIndicator())
              : log == null
              ? Center(child: Text(locale.log_display_error))
              : Padding(
                padding: const EdgeInsets.all(16),
                child: ListView(
                  children: [
                    _buildInfoRow(locale.log_display_logId, log.id),
                    _buildInfoRow(
                      locale.log_display_actionType,
                      log.actionType,
                    ),
                    _buildInfoRow(locale.log_display_username, log.username),
                    _buildInfoRow(locale.log_display_userId, log.userId),
                    _buildInfoRow(
                      locale.log_display_date,
                      log.actionDate.toString(),
                    ),
                    _buildInfoRow(
                      locale.log_display_targetTable,
                      log.targetTable,
                    ),
                    _buildInfoRow(locale.log_display_targetId, log.targetId),
                    _buildInfoRow(locale.log_display_state, log.state),
                    _buildInfoRow(locale.log_display_details, log.details),
                    if (log.originalData.isNotEmpty)
                      _buildInfoRow(
                        locale.log_display_originalData,
                        log.originalData!,
                      ),
                  ],
                ),
              ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    final theme = viewModel.theme;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.currentTheme.SecondaryBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.currentTheme.Primary.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: theme.currentTheme.PrimaryText,
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(color: theme.currentTheme.SecondaryText),
          ),
        ],
      ),
    );
  }
}
