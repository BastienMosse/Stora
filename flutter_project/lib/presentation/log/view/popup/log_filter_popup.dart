import '/index.dart';

import 'package:intl/intl.dart';

class LogFilterPopup extends StatefulWidget {
  final Function(LogFilterData)? onFiltersApplied;
  final LogFilterData? initialFilters;

  const LogFilterPopup({super.key, this.onFiltersApplied, this.initialFilters});

  @override
  State<LogFilterPopup> createState() => _LogFilterPopupState();
}

class _LogFilterPopupState extends State<LogFilterPopup> {
  EntityType selectedEntity = EntityType.NONE;

  final TextEditingController _productIdController = TextEditingController();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _employeeIdController = TextEditingController();
  final TextEditingController _employeeUsernameController =
      TextEditingController();
  final List<ActionType> actions = [];
  DateTime? from;
  DateTime? to;

  late AppLocalizations locale;
  late ThemeController theme;

  @override
  void initState() {
    super.initState();

    if (widget.initialFilters != null) {
      final filters = widget.initialFilters!;
      if (filters.action != null) {
        actions.addAll(filters.action!);
      }
      // if (filters.userId != null) {
      //   _userIdController.text = filters.userId!;
      // }
      // if (filters.username != null) {
      //   _userNameController.text = filters.username!;
      // }
      if (filters.from != null) {
        from = filters.from;
      }
      if (filters.to != null) {
        to = filters.to;
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
    _productIdController.dispose();
    _productNameController.dispose();
    _employeeIdController.dispose();
    _employeeUsernameController.dispose();
    super.dispose();
  }

  void toggleAction(ActionType action) {
    setState(() {
      if (actions.contains(action)) {
        actions.remove(action);
      } else {
        actions.add(action);
      }
    });
  }

  Widget buildDatePickerField({
    required BuildContext context,
    required String label,
    required DateTime? selectedDate,
    required void Function(DateTime date) onDateSelected,
  }) {
    final locale = AppLocalizations.of(context)!;
    final theme = context.read<ThemeController>();

    return TextFormField(
      readOnly: true,
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
        );
        if (picked != null) {
          onDateSelected(picked);
        }
      },
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        suffixIcon: const Icon(Icons.calendar_today),
        hintText: locale.filter_log_popup_date_pick,
        filled: true,
        fillColor: theme.currentTheme.SecondaryBackground,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
      ),
      controller: TextEditingController(
        text:
            selectedDate != null
                ? DateFormat('dd/MM/yyyy').format(selectedDate)
                : '',
      ),
      style: TextStyle(
        color:
            selectedDate != null
                ? theme.currentTheme.PrimaryText
                : Colors.grey.shade600,
      ),
    );
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
                // Title
                Text(
                  locale.filter_log_popup_option_filter,
                  style: GoogleFonts.interTight(
                    color: theme.currentTheme.PrimaryText,
                  ),
                ),
                const SizedBox(height: 20),

                // Action Type Selection
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    locale.filter_log_popup_type_filter,
                    style: GoogleFonts.interTight(
                      color: theme.currentTheme.PrimaryText,
                    ),
                  ),
                ),
                Wrap(
                  spacing: 8,
                  children:
                      ActionType.values.map((action) {
                        return FilterChip(
                          label: Text(action.name),
                          selected: actions.contains(action),
                          onSelected: (_) => toggleAction(action),
                          selectedColor: theme.currentTheme.Primary,
                        );
                      }).toList(),
                ),
                const SizedBox(height: 8),

                // Date from and to fields
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    locale.filter_log_popup_date_pick,
                    style: GoogleFonts.interTight(
                      color: theme.currentTheme.PrimaryText,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: buildDatePickerField(
                        context: context,
                        label: locale.filter_log_popup_start_date,
                        selectedDate: from,
                        onDateSelected: (date) => setState(() => from = date),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: buildDatePickerField(
                        context: context,
                        label: locale.filter_log_popup_end_date,
                        selectedDate: to,
                        onDateSelected: (date) => setState(() => to = date),
                      ),
                    ),
                  ],
                ),

                // Entity type
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    locale.filter_log_popup_type_filter,
                    style: GoogleFonts.interTight(
                      color: theme.currentTheme.PrimaryText,
                    ),
                  ),
                ),
                DropdownButtonFormField<EntityType>(
                  value: selectedEntity,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    filled: true,
                    fillColor: theme.currentTheme.SecondaryBackground,
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: EntityType.NONE,
                      child: Text('None'),
                    ),
                    DropdownMenuItem(
                      value: EntityType.PRODUCT,
                      child: Text('Product'),
                    ),
                    DropdownMenuItem(
                      value: EntityType.EMPLOYEE,
                      child: Text('Employee'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedEntity = value;
                      });
                    }
                  },
                ),
                const SizedBox(height: 8),
                if (selectedEntity == EntityType.PRODUCT) ...[
                  TextField(
                    controller: _productIdController,
                    decoration: InputDecoration(
                      labelText: locale.filter_log_popup_product_id,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _productNameController,
                    decoration: InputDecoration(
                      labelText: locale.filter_log_popup_product_name,
                    ),
                  ),
                ] else if (selectedEntity == EntityType.EMPLOYEE) ...[
                  TextField(
                    controller: _employeeIdController,
                    decoration: InputDecoration(
                      labelText: locale.filter_log_popup_employee_id,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _employeeUsernameController,
                    decoration: InputDecoration(
                      labelText: locale.filter_log_popup_employee_name,
                    ),
                  ),
                ],
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.currentTheme.Primary,
                        ),
                        onPressed: () {
                          setState(() {
                            selectedEntity = EntityType.NONE;
                            _productIdController.clear();
                            _productNameController.clear();
                            _employeeIdController.clear();
                            _employeeUsernameController.clear();
                            actions.clear();
                            from = null;
                            to = null;
                          });
                        },
                        child: Text(
                          locale.stock_filter_popup_reset,
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
                          final filterData = LogFilterData(
                            action: actions.isNotEmpty ? actions : null,
                            productId:
                                _productIdController.text.isNotEmpty
                                    ? _productIdController.text
                                    : null,
                            productName:
                                _productNameController.text.isNotEmpty
                                    ? _productNameController.text
                                    : null,
                            employeeId:
                                _employeeIdController.text.isNotEmpty
                                    ? _employeeIdController.text
                                    : null,
                            employeeName:
                                _employeeUsernameController.text.isNotEmpty
                                    ? _employeeUsernameController.text
                                    : null,
                            from: from,
                            to: to,
                          );
                          widget.onFiltersApplied?.call(filterData);
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          locale.stock_filter_popup_apply,
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
