import '/index.dart';

class EmployeesFilterPopup extends StatefulWidget {
  final Function(EmployeesFilterData)? onFiltersApplied;

  const EmployeesFilterPopup({Key? key, this.onFiltersApplied})
    : super(key: key);

  @override
  State<EmployeesFilterPopup> createState() => _EmployeesFilterPopupState();
}

class _EmployeesFilterPopupState extends State<EmployeesFilterPopup> {
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController loginController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  @override
  void dispose() {
    startDateController.dispose();
    endDateController.dispose();
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
              startDateController.clear();
              endDateController.clear();
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
