import '/index.dart';

class StockSortPopup extends StatefulWidget {
  final Function(StockSortData)? onSortsApplied;
  final StockSortData? initialSorts;

  const StockSortPopup({super.key, this.onSortsApplied, this.initialSorts});

  @override
  State<StockSortPopup> createState() => _StockSortPopupState();
}

class _StockSortPopupState extends State<StockSortPopup> {
  final List<String> order = [];

  bool isActiveID = false;
  bool isActiveName = false;
  bool isActiveQuantity = false;

  late AppLocalizations locale;
  late ThemeController theme;

  @override
  void initState() {
    super.initState();

    if (widget.initialSorts != null) {
      final sorts = widget.initialSorts!;
      order.addAll(sorts.order ?? []);
      if (sorts.isActiveID != null) {
        isActiveID = sorts.isActiveID!;
      }
      if (sorts.isActiveName != null) {
        isActiveName = sorts.isActiveName!;
      }
      if (sorts.isActiveQuantity != null) {
        isActiveQuantity = sorts.isActiveQuantity!;
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    locale = AppLocalizations.of(context)!;
    theme = context.watch<ThemeController>();
  }

  void moveUp(int index) {
    if (index > 0) {
      setState(() {
        final temp = order[index];
        order[index] = order[index - 1];
        order[index - 1] = temp;
      });
    }
  }

  void moveDown(int index) {
    if (index < order.length - 1) {
      setState(() {
        final temp = order[index];
        order[index] = order[index + 1];
        order[index + 1] = temp;
      });
    }
  }

  void removeItem(int index) {
    setState(() {
      final removed = order.removeAt(index);
      if (removed == locale.sort_popup_name)
        isActiveName = false;
      else if (removed == "ID")
        isActiveID = false;
      else if (removed == locale.sort_popup_quantity)
        isActiveQuantity = false;
    });
  }

  void _toggleSortItem(
    String label,
    bool isActive,
    void Function(bool) onToggle,
  ) {
    final newValue = !isActive;
    setState(() {
      onToggle(newValue);
      if (newValue) {
        if (!order.contains(label)) {
          order.add(label);
        }
      } else {
        order.remove(label);
      }
    });
  }

  Widget _buildSortToggleRow(
    String label,
    bool isActive,
    void Function(bool) onToggle,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontWeight:
                Theme.of(context).textTheme.bodyMedium?.fontWeight ??
                FontWeight.normal,
            fontStyle:
                Theme.of(context).textTheme.bodyMedium?.fontStyle ??
                FontStyle.normal,
            letterSpacing: 0.0,
            color:
                isActive
                    ? theme.currentTheme.PrimaryText//Theme.of(context).textTheme.bodyMedium?.color
                    : theme.currentTheme.PrimaryText,
          ),
        ),
        Switch(
          value: isActive,
          onChanged: (_) => _toggleSortItem(label, isActive, onToggle),
          activeColor: theme.currentTheme.Primary,//Theme.of(context).colorScheme.primary,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: theme.currentTheme.PrimaryBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
          maxWidth: MediaQuery.of(context).size.width * 0.9,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  locale.sort_popup_sort_items,
                  style: TextStyle(
                    fontFamily: 'InterTight',
                    fontSize:
                        Theme.of(context).textTheme.headlineMedium?.fontSize,
                    fontWeight:
                        Theme.of(context).textTheme.headlineMedium?.fontWeight,
                    fontStyle:
                        Theme.of(context).textTheme.headlineMedium?.fontStyle,
                    letterSpacing: 0.0,
                    color : theme.currentTheme.PrimaryText,
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                const SizedBox(height: 8),
                Text(
                  locale.sort_log_popup_sort_by,
                  style: GoogleFonts.interTight(
                    fontWeight:
                        Theme.of(context).textTheme.titleMedium?.fontWeight ??
                        FontWeight.normal,
                    fontStyle:
                        Theme.of(context).textTheme.titleMedium?.fontStyle ??
                        FontStyle.normal,
                    letterSpacing: 0.0,
                    color: theme.currentTheme.PrimaryText,
                  ),
                ),
                const SizedBox(height: 8),
                _buildSortToggleRow(
                  locale.sort_popup_name,
                  isActiveName,
                  (val) => isActiveName = val,
                ),
                _buildSortToggleRow(
                  "ID",
                  isActiveID,
                  (val) => isActiveID = val,
                ),
                _buildSortToggleRow(
                  locale.sort_popup_quantity,
                  isActiveQuantity,
                  (val) => isActiveQuantity = val,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  width: double.infinity,
                  height: 1,
                  color: Theme.of(context).dividerColor,
                ),
                Text(
                  locale.sort_log_popup_priotity_order,
                  style: GoogleFonts.interTight(
                    /*textStyle: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(letterSpacing: 0.0),*/
                    color : theme.currentTheme.PrimaryText,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: theme.currentTheme.PrimaryBackground,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Theme.of(
                        context,
                      ).colorScheme.onBackground.withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                  padding: const EdgeInsets.all(12),
                  
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(order.length, (index) {
                      
                      return Row(
                        
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          
                          Text(
                            '${index + 1}. ${order[index]}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                              color: theme.currentTheme.PrimaryText,//Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_upward,
                                  color:
                                      index == 0
                                          ? theme.currentTheme.PrimaryText//Colors.grey
                                          : Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                  size: 20,
                                ),
                                onPressed:
                                    index == 0 ? null : () => moveUp(index),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_downward,
                                  color:
                                      index == order.length - 1
                                          ? theme.currentTheme.PrimaryText//Colors.grey
                                        
                                          : Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                  size: 20,
                                ),
                                onPressed:
                                    index == order.length - 1
                                        ? null
                                        : () => moveDown(index),
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  width: double.infinity,
                  height: 1,
                  color: Theme.of(
                    context,
                  ).colorScheme.onBackground.withOpacity(0.1),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 40,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.all(8),
                          side: BorderSide(
                            color: Theme.of(
                              context,
                            ).colorScheme.onBackground.withOpacity(0.1),
                            width: 1,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor:
                              theme.currentTheme.Primary,//Theme.of(context).colorScheme.secondary,
                        ),
                        child: Text(
                          locale.filter_log_popup_cancel,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            color: theme.currentTheme.PrimaryBackground,/* Theme.of(
                              context,
                            ).textTheme.bodyMedium?.color?.withOpacity(0.7),*/
                            letterSpacing: 0.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 100,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          final sortsData = StockSortData(
                            order: order.isNotEmpty ? order : null,
                            isActiveName: isActiveName,
                            isActiveID: isActiveID,
                            isActiveQuantity: isActiveQuantity,
                          );
                          widget.onSortsApplied?.call(sortsData);
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(8),
                          backgroundColor:
                              theme.currentTheme.Primary,//Theme.of(context).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          locale.sort_log_popup_apply,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            color: theme.currentTheme.PrimaryBackground,//Theme.of(context).colorScheme.onPrimary,
                            letterSpacing: 0.0,
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
