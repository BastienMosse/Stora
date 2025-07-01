import '/index.dart';

class EmployeesFilterPopup extends StatefulWidget {
  final Function(EmployeesFilterData)? onFiltersApplied;
  final EmployeesFilterData? initialFilters;

  const EmployeesFilterPopup({
    super.key,
    this.onFiltersApplied,
    this.initialFilters,
  });

  @override
  State<EmployeesFilterPopup> createState() => _EmployeesFilterPopupState();
}

class _EmployeesFilterPopupState extends State<EmployeesFilterPopup> {
  final TextEditingController loginController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.initialFilters != null) {
      final filters = widget.initialFilters!;
      loginController.text = filters.login;
      firstNameController.text = filters.firstName;
      lastNameController.text = filters.lastName;
    }
  }

  @override
  void dispose() {
    loginController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(locale.employee_filter_popup_option),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: loginController,
              decoration: const InputDecoration(
                labelText: 'Login',
                suffixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: firstNameController,
                    decoration: InputDecoration(
                      labelText: locale.employee_display_update_popup_firstname,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: lastNameController,
                    decoration: InputDecoration(
                      labelText: locale.employee_display_create_popup_lastname,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            setState(() {
              loginController.clear();
              firstNameController.clear();
              lastNameController.clear();
            });
          },
          child: Text(locale.employee_filter_popup_reset),
        ),
        ElevatedButton(
          onPressed: () {
            final filterData = EmployeesFilterData(
              login: loginController.text,
              firstName: firstNameController.text,
              lastName: lastNameController.text,
            );

            if (widget.onFiltersApplied != null) {
              widget.onFiltersApplied!(filterData);
            }

            context.pop();
          },
          child: Text(locale.employee_filter_popup_apply),
        ),
      ],
    );
  }
}
