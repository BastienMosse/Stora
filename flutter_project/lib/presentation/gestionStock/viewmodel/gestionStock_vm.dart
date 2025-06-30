import '/index.dart';

class StockScreenViewModel {
  late AppState appState;
  late UserPrefs productPrefs;
  late ThemeController theme;
  late AppLocalizations locale;

  late FocusNode searchNode;
  late TextEditingController searchController;

  late List<Product> productList;
  late List<Product> filteredProductList;
  //StockFilterData? currentFilters;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  StockScreenViewModel() {
    searchNode = FocusNode();
    searchController = TextEditingController();
    productList = [];
    filteredProductList = [];

    searchController.addListener(() {
     // applyFilters();
    });
  }

  void init(BuildContext context) {
    appState = context.read<AppState>();
    theme = context.read<ThemeController>();
    locale = AppLocalizations.of(context)!;
  }

  Future<void> fetchProductList() async {
    if (_isLoading) return;

    _isLoading = true;
    try {
      ProductListResponse? response = await Endpoints.getProducts();
      productList = response != null ? response.products : [];
      filteredProductList = List.from(productList);
      //applyFilters();
    } catch (e) {
      print('Error getting product list: $e');
      productList = [];
      filteredProductList = [];
    } finally {
      _isLoading = false;
    }
  }

/*
  void setFilters(EmployeesFilterData filters) {
    currentFilters = filters;
    applyFilters();
  }
*/
/*
  void applyFilters() {
    filteredProductList =
        productList.where((product) {
          final searchQuery = searchController.text.toLowerCase();
          final matchesSearch =
              searchQuery.isEmpty ||
              product.login.toLowerCase().contains(searchQuery) ||
              product.productname.toLowerCase().contains(searchQuery) ||
              product.email.toLowerCase().contains(searchQuery);

          if (!matchesSearch) return false;

          if (currentFilters != null) {
            if (currentFilters!.login.isNotEmpty &&
                !product.login.toLowerCase().contains(
                  currentFilters!.login.toLowerCase(),
                )) {
              return false;
            }

            if (currentFilters!.firstName.isNotEmpty &&
                !product.productname.toLowerCase().contains(
                  currentFilters!.firstName.toLowerCase(),
                )) {
              return false;
            }

            if (currentFilters!.lastName.isNotEmpty &&
                !product.productname.toLowerCase().contains(
                  currentFilters!.lastName.toLowerCase(),
                )) {
              return false;
            }
          }

          return true;
        }).toList();
  }*/
/*
  void clearFilters() {
    currentFilters = null;
    searchController.clear();
    applyFilters();
  }*/

  Future<void> refreshProductList() async {
    _isLoading = false;
    await fetchProductList();
  }

  void dispose() {
    searchNode.dispose();
    searchController.dispose();
  }
}
