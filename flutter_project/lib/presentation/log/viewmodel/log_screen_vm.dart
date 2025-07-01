import '/index.dart';

class LogScreenViewModel extends ChangeNotifier {
  late AppLocalizations locale;

  late FocusNode searchNode;
  late TextEditingController searchController;

  late List<Log> logList;
  late List<Log> filteredLogList;

  LogFilterData? currentFilters;
  LogSortData? currentSorts;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  LogScreenViewModel() {
    searchNode = FocusNode();
    searchController = TextEditingController();

    searchController.addListener(() {
      applyFiltersAndSort();
    });
  }

  void init(BuildContext context) {
    locale = AppLocalizations.of(context)!;
  }

  Future<void> fetchLogList() async {
    if (_isLoading) return;

    _isLoading = true;
    try {
      LogsListResponse? response = await Endpoints.getLogsList();
      logList = response != null ? response.logs : [];
      filteredLogList = List.from(logList);
      applyFiltersAndSort();
    } catch (e) {
      print('Error getting log list: $e');
      logList = [];
      filteredLogList = [];
    } finally {
      _isLoading = false;
    }
  }

  void setFilters(LogFilterData filters) {
    currentFilters = filters;
    applyFiltersAndSort();
  }

  void setSortOrder(LogSortData sorts) {
    currentSorts = sorts;
    applyFiltersAndSort();
  }

  void applyFiltersAndSort() {
    final searchQuery = searchController.text.toLowerCase();

    if (logList.isEmpty) {
      filteredLogList = [];
      notifyListeners();
      return;
    }

    filteredLogList = logList.where((log) {
      final matchesSearch = searchQuery.isEmpty ||
          log.details.toLowerCase().contains(searchQuery) ||
          log.username.toLowerCase().contains(searchQuery);

      if (!matchesSearch) return false;

      if (currentFilters != null) {
        final filter = currentFilters!;

        if (filter.action != null && filter.action!.isNotEmpty) {
          if (!filter.action!.any((a) => a.name == log.actionType)) return false;
        }

        if (filter.from != null && log.actionDate.isBefore(filter.from!)) return false;
        if (filter.to != null && log.actionDate.isAfter(filter.to!)) return false;

        if (log.targetTable.toLowerCase() == 'products') {
          if (filter.productId != null && filter.productId!.isNotEmpty) {
            if (log.targetId != filter.productId) return false;
          }
          if (filter.productName != null && filter.productName!.isNotEmpty) {
            if (!log.details.toLowerCase().contains(filter.productName!.toLowerCase())) return false;
          }
        }

        if (filter.employeeId != null && filter.employeeId!.isNotEmpty) {
          if (log.userId != filter.employeeId) return false;
        }
        if (filter.employeeName != null && filter.employeeName!.isNotEmpty) {
          if (!log.username.toLowerCase().contains(filter.employeeName!.toLowerCase())) return false;
        }
      }

      return true;
    }).toList();

    if (currentSorts != null && currentSorts!.order != null && currentSorts!.order!.isNotEmpty) {
      final orderKeys = currentSorts!.order!;
      filteredLogList.sort((a, b) {
        for (final key in orderKeys) {
          int cmp = 0;

          switch (key) {
            case 'date':
              if (currentSorts!.isActiveDate == true) {
                cmp = b.actionDate.compareTo(a.actionDate);
              }
              break;

            case 'product_id':
              if (currentSorts!.isActiveProductID == true) {
                if (a.targetTable.toLowerCase() == 'products' &&
                    b.targetTable.toLowerCase() == 'products') {
                  cmp = a.targetId.compareTo(b.targetId);
                }
              }
              break;

            case 'product_name':
              if (currentSorts!.isActiveProductName == true) {
                if (a.targetTable.toLowerCase() == 'products' &&
                    b.targetTable.toLowerCase() == 'products') {
                  cmp = a.details.toLowerCase().compareTo(b.details.toLowerCase());
                }
              }
              break;

            case 'employee_id':
              if (currentSorts!.isActiveEmployeeID == true) {
                cmp = a.userId.compareTo(b.userId);
              }
              break;

            case 'employee_name':
              if (currentSorts!.isActiveEmployeeName == true) {
                cmp = a.username.toLowerCase().compareTo(b.username.toLowerCase());
              }
              break;
          }

          if (cmp != 0) return cmp;
        }
        return 0;
      });
    }

    notifyListeners();
  }

  void clearFilters() {
    currentFilters = null;
    searchController.clear();
    applyFiltersAndSort();
  }

  Future<void> refreshProductList() async {
    _isLoading = false;
    await fetchLogList();
  }
}
