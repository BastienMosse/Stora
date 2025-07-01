import 'package:stora/index.dart';

class LogDisplayScreenViewModel {
  late ThemeController theme;
  late AppLocalizations locale;

  late Log? log;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  LogDisplayScreenViewModel();

  void init(BuildContext context) {
    locale = AppLocalizations.of(context)!;
    theme = context.read<ThemeController>();
    log = null;
  }

  Future<void> fetchLogId(String id) async {
    if (_isLoading) return;

    _isLoading = true;
    try {
      LogsGetResponse? response = await Endpoints.getLogById(id);
      if (response != null) {
        log = response.log;
      }
    } catch (e) {
      print('Error getting log : $e');
    } finally {
      _isLoading = false;
    }
  }
}
