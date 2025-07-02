import '/index.dart';
import 'package:intl/intl.dart';

import '../viewmodel/log_screen_vm.dart';
import 'popup/log_filter_popup.dart';
import 'popup/log_sort_popup.dart';

class GestionLogsWidget extends StatefulWidget {
  const GestionLogsWidget({super.key});

  @override
  State<GestionLogsWidget> createState() => _GestionLogsWidgetState();
}

class _GestionLogsWidgetState extends State<GestionLogsWidget> {
  late AppState appState;
  late AppLocalizations locale;
  late ThemeController theme;

  late LogScreenViewModel viewModel;
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

    viewModel = LogScreenViewModel();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!context.watch<AppState>().isAdmin) {
      context.go(Routes.home);
    }

    locale = AppLocalizations.of(context)!;
    theme = context.read<ThemeController>();

    viewModel.init(context);
    _initialFetchFuture = viewModel.fetchLogList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _refreshData() async {
    if (_isRefreshing) return;

    setState(() {
      _isRefreshing = true;
    });

    await viewModel.refreshProductList();

    setState(() {
      _isRefreshing = false;
    });
  }

  String _formatDate(DateTime date) {
    final formatter = DateFormat('dd/MM/yyyy HH:mm');
    return formatter.format(date);
  }
  

  IconData _getActionIcon(String action) {
    switch (action.toUpperCase()) {
      case 'CREATE':
        return Icons.add_circle_outline;
      case 'UPDATE':
        return Icons.edit;
      case 'DELETE':
        return Icons.delete_outline;
      default:
        return Icons.info_outline;
    }
  }

  Widget buildStockCard(Log log) {
    return InkWell(
      onTap: () {
        context.go(Routes.logDisplay, extra: log.id);
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
                Icon(
                  _getActionIcon(log.actionType),
                  color: theme.currentTheme.Primary,
                  size: 28,
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${log.actionType} • ${_formatDate(log.actionDate)}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: theme.currentTheme.PrimaryText,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        log.details,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          color: theme.currentTheme.SecondaryText,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Par ${log.username}',
                        style: TextStyle(
                          fontSize: 13,
                          color: theme.currentTheme.SecondaryText,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'ID: ${log.id}',
                        style: TextStyle(
                          fontSize: 11,
                          color: theme.currentTheme.PrimaryText,
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
        title: Align(
          alignment: AlignmentDirectional(0, 0),
          child: Text(
            locale.log_screen_title,
            style: GoogleFonts.interTight(
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              color: theme.currentTheme.PrimaryBackground,
              fontSize: 22,
              letterSpacing: 0.0,
            ),
          ),
        ),
        elevation: 2,
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
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder:
                            (context) => LogFilterPopup(
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
                            hintText: locale.stock_manage_page_bar_de_recherche,
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
                  IconButton(
                    iconSize: 40,
                    padding: EdgeInsets.zero,
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder:
                            (context) => LogSortPopup(
                              initialSorts: viewModel.currentSorts,
                              onSortsApplied: (sortData) {
                                viewModel.setSortOrder(sortData);
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
                        Icons.sort,
                        color: theme.currentTheme.PrimaryBackground,
                        size: 24,
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
                                  itemCount: viewModel.filteredLogList.length,
                                  itemBuilder: (context, index) {
                                    return buildStockCard(
                                      viewModel.filteredLogList[index],
                                    );
                                  },
                                ),
                              );
                            }
                          },
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
