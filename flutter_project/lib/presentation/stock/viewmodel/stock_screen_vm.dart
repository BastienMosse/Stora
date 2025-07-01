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

  StockFilterData? currentFilters;
  StockSortData? currentSorts;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  StockScreenViewModel() {
    searchNode = FocusNode();
    searchController = TextEditingController();

    searchController.addListener(() {
      applyFiltersAndSort();
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
      applyFiltersAndSort();
    } catch (e) {
      print('Error getting product list: $e');
      productList = [];
      filteredProductList = [];
    } finally {
      _isLoading = false;
    }
  }

  void setFilters(StockFilterData filters) {
    currentFilters = filters;
    applyFiltersAndSort();
  }

  void setSortOrder(StockSortData sorts) {
    currentSorts = sorts;
    applyFiltersAndSort();
  }

  void applyFiltersAndSort() {
    final searchQuery = searchController.text.toLowerCase();

    filteredProductList =
        productList.where((product) {
          final matchesSearch =
              searchQuery.isEmpty ||
              product.name.toLowerCase().contains(searchQuery) ||
              product.description.toLowerCase().contains(searchQuery);

          if (!matchesSearch) return false;

          if (currentFilters != null) {
            final filter = currentFilters!;

            // Keywords
            if (filter.keywords != null && filter.keywords!.isNotEmpty) {
              final matchesKeywords = filter.keywords!.any((kw) {
                final lowerKw = kw.toLowerCase();
                return product.name.toLowerCase().contains(lowerKw) ||
                    (product.description.toLowerCase()).contains(lowerKw);
              });

              if (!matchesKeywords) return false;
            }

            // Categories
            if (filter.category != null &&
                filter.category!.isNotEmpty &&
                !filter.category!
                    .map((c) => c.name)
                    .contains(product.category)) {
              return false;
            }

            // Quantity
            if (filter.minQuantity != null &&
                product.stockQuantity < filter.minQuantity!) {
              return false;
            }

            if (filter.maxQuantity != null &&
                product.stockQuantity > filter.maxQuantity!) {
              return false;
            }
          }

          return true;
        }).toList();

    if (currentSorts != null && currentSorts!.order != null) {
      filteredProductList.sort((a, b) {
        for (var crit in currentSorts!.order!) {
          int cmp = 0;
          if (crit == locale.sort_popup_name) {
            cmp = a.name.compareTo(b.name);
          } else if (crit == "ID") {
            cmp = a.id.compareTo(b.id);
          } else if (crit == locale.sort_popup_quantity) {
            cmp = a.stockQuantity.compareTo(b.stockQuantity);
          }
          if (cmp != 0) return cmp;
        }
        return 0;
      });
    }
  }

  void clearFilters() {
    currentFilters = null;
    searchController.clear();
    applyFiltersAndSort();
  }

  Future<void> refreshProductList() async {
    _isLoading = false;
    await fetchProductList();
  }

  void dispose() {
    searchNode.dispose();
    searchController.dispose();
  }
}
