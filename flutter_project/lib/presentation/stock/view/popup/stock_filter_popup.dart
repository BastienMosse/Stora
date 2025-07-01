import '/index.dart';

class StockFilterPopup extends StatefulWidget {
  final Function(StockFilterData)? onFiltersApplied;
  final StockFilterData? initialFilters;

  const StockFilterPopup({
    super.key,
    this.onFiltersApplied,
    this.initialFilters,
  });

  @override
  State<StockFilterPopup> createState() => _StockFilterPopupState();
}

class _StockFilterPopupState extends State<StockFilterPopup> {
  final TextEditingController keysController = TextEditingController();
  final List<String> keywords = [];
  final List<Category> categories = [];

  late AppLocalizations locale;
  late ThemeController theme;

  int minQuantity = 0;
  int maxQuantity = 0;

  @override
  void initState() {
    super.initState();

    if (widget.initialFilters != null) {
      final filters = widget.initialFilters!;
      keywords.addAll(filters.keywords ?? []);
      if (filters.category != null) {
        categories.addAll(filters.category!);
      }
      if (filters.minQuantity != null) {
        minQuantity = filters.minQuantity!;
      }
      if (filters.maxQuantity != null) {
        maxQuantity = filters.maxQuantity!;
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    locale = AppLocalizations.of(context)!;
    theme = context.watch<ThemeController>();
  }

  @override
  void dispose() {
    keysController.dispose();
    super.dispose();
  }

  void incrementMin() => setState(() => minQuantity++);
  void decrementMin() =>
      setState(() => minQuantity = minQuantity > 0 ? minQuantity - 1 : 0);
  void incrementMax() => setState(() => maxQuantity++);
  void decrementMax() =>
      setState(() => maxQuantity = maxQuantity > 0 ? maxQuantity - 1 : 0);

  void addKeyword(String keyword) {
    if (keyword.isNotEmpty && !keywords.contains(keyword)) {
      setState(() => keywords.add(keyword));
      keysController.clear();
    }
  }

  void removeKeyword(String keyword) {
    setState(() => keywords.remove(keyword));
  }

  void toggleCategory(Category category) {
    setState(() {
      if (categories.contains(category)) {
        categories.remove(category);
      } else {
        categories.add(category);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: theme.currentTheme.PrimaryBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  locale.stock_filter_popup_title,
                  style: GoogleFonts.interTight(
                    color: theme.currentTheme.PrimaryText,
                  ),
                ),
                const SizedBox(height: 20),

                // Keywords Input
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(locale.stock_filter_popup_keyword),
                ),
                TextField(
                  style: GoogleFonts.interTight(
                    color: theme.currentTheme.PrimaryText,
                  ),
                  controller: keysController,
                  onSubmitted: addKeyword,
                  decoration: InputDecoration(
                    hintText: locale.stock_filter_popup_keyword,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () => addKeyword(keysController.text),
                    ),
                  ),
                ),
                Wrap(
                  spacing: 8,
                  children:
                      keywords.map((word) {
                        return Chip(
                          label: Text(word,
                          style: GoogleFonts.interTight(
                              color: theme.currentTheme.PrimaryText,
                            ),
                          ),
                          onDeleted: () => removeKeyword(word),
                          backgroundColor: theme.currentTheme.Primary,
                        );
                      }).toList(),
                ),
                const SizedBox(height: 20),

                // Category selection
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(locale.stock_filter_popup_categories,
                  style: GoogleFonts.interTight(
                      color: theme.currentTheme.PrimaryText,
                    ),
                  ),
                ),
                Wrap(
                  spacing: 8,
                  children:
                      Category.values.map((category) {
                        final isSelected = categories.contains(category);
                        return FilterChip(
                          label: Text(category.name),
                          selected: isSelected,
                          onSelected: (_) => toggleCategory(category),
                          selectedColor: theme.currentTheme.Primary,
                        );
                      }).toList(),
                ),
                const SizedBox(height: 20),

                // Quantity fields
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(locale.stock_filter_popup_quantity,
                    style: GoogleFonts.interTight(
                      color: theme.currentTheme.PrimaryText,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(locale.stock_filter_popup_moreThan,
                            style: GoogleFonts.interTight(
                              color: theme.currentTheme.PrimaryText,
                            ),
                          ),
                          const SizedBox(height: 4),
                          QuantitySelector(
                            value: minQuantity,
                            onAdd: incrementMin,
                            onRemove: decrementMin,
                            color:theme.currentTheme.PrimaryText
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            locale.stock_filter_popup_lessThan,
                            style: GoogleFonts.interTight(
                              color: theme.currentTheme.PrimaryText,
                            ),
                          ),
                          const SizedBox(height: 4),
                          QuantitySelector(
                            value: maxQuantity,
                            onAdd: incrementMax,
                            onRemove: decrementMax,
                            color:theme.currentTheme.PrimaryText
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Buttons
                Row(
                  children: [
                    Expanded(
                      child:ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.currentTheme.Primary,
                        ),
                        onPressed: () {
                          setState(() {
                            keysController.clear();
                            keywords.clear();
                            categories.clear();
                            minQuantity = 0;
                            maxQuantity = 0;
                          });
                        },
                        child: Text(locale.stock_filter_popup_reset,
                          style: GoogleFonts.interTight(
                            color: theme.currentTheme.PrimaryText,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.currentTheme.Primary,
                        ),
                        onPressed: () {
                          final filterData = StockFilterData(
                            keywords: keywords,
                            category: categories,
                            minQuantity: minQuantity > 0 ? minQuantity : null,
                            maxQuantity: maxQuantity > 0 ? maxQuantity : null,
                          );
                          widget.onFiltersApplied?.call(filterData);
                          Navigator.of(context).pop();
                        },
                        child: Text(locale.stock_filter_popup_apply,
                          style: GoogleFonts.interTight(
                            color: theme.currentTheme.PrimaryText,
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
      ),
    );
  }
}
