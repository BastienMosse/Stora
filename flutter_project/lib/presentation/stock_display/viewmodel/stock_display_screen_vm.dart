import '/index.dart';

class StockDisplayScreenViewModel {
  late AppState appState;
  late UserPrefs userPrefs;
  late ThemeController theme;
  late AppLocalizations locale;

  late Product? product;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  StockDisplayScreenViewModel();

  void init(BuildContext context) {
    appState = context.read<AppState>();
    userPrefs = context.read<UserPrefs>();
    theme = context.read<ThemeController>();
    locale = AppLocalizations.of(context)!;
    product = null;
  }

  Future<void> fetchProductId(String id) async {
    if (_isLoading) return;

    _isLoading = true;
    try {
      ProductGetResponse? response = await Endpoints.getProductById(id);
      if (response != null) {
        product = response.products;
      }
    } catch (e) {
      print('Error getting product : $e');
    } finally {
      _isLoading = false;
    }
  }

  Future<void> deleteProduct(String id) async {
    print('Deleting product with ID: $id');
    if (_isLoading) return;

    _isLoading = true;
    try {
      Message? response = await Endpoints.deleteProductById(id);
      if (response != null) {
        product = null;
      }
    } catch (e) {
      print('Error deleting product : $e');
    } finally {
      _isLoading = false;
    }
  }
}
