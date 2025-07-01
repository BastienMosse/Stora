import '/index.dart';

import 'popup/stock_sort_popup.dart';
import 'popup/stock_create_popup.dart';
import 'popup/stock_filter_popup.dart';
import '../viewmodel/stock_screen_vm.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  late AppState appState;
  late UserPrefs userPrefs;
  late ThemeController theme;
  late AppLocalizations locale;

  late StockScreenViewModel viewModel;
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

    viewModel = StockScreenViewModel();
    _initialFetchFuture = viewModel.fetchProductList();
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
    _refreshData();
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

    await viewModel.refreshProductList();

    setState(() {
      _isRefreshing = false;
    });
  }

  Widget buildStockCard(Product product) {
    return InkWell(
      onTap: () {
        context.go(Routes.stockDisplay, extra: product.id);
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
                        product.photo.isNotEmpty
                            ? Image.network(
                              product.photo,
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
                        product.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        'id: ${product.id}',
                        style: TextStyle(
                          color: theme.currentTheme.PrimaryText,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        '${product.price} \$',
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
        title: Align(
          alignment: AlignmentDirectional(0, 0),
          child: Text(
            locale.stock_manage_page_title,
            style: GoogleFonts.interTight(
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              color:  theme.currentTheme.PrimaryBackground,
              fontSize: 22,
              letterSpacing: 0.0,
            ),
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
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder:
                            (context) => StockFilterPopup(
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
                            (context) => StockSortPopup(
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
                                  itemCount:
                                      viewModel.filteredProductList.length,
                                  itemBuilder: (context, index) {
                                    return buildStockCard(
                                      viewModel.filteredProductList[index],
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
                        builder: (context) => const StockCreatePopup(),
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
                        color: theme.currentTheme.PrimaryBackground,
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
