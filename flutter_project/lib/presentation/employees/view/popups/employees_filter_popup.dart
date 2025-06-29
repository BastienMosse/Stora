import '/index.dart';

class EmployeesFilterPopup extends StatefulWidget {
  final Function(EmployeesFilterData)? onFiltersApplied;

  const EmployeesFilterPopup({Key? key, this.onFiltersApplied})
    : super(key: key);

  @override
  State<EmployeesFilterPopup> createState() => _EmployeesFilterPopupState();
}

class _EmployeesFilterPopupState extends State<EmployeesFilterPopup> {
  String gender = 'All';
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController employeeIdController = TextEditingController();
  final TextEditingController loginController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  @override
  void dispose() {
    startDateController.dispose();
    endDateController.dispose();
    employeeIdController.dispose();
    loginController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Filter Options'),
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
            TextField(
              controller: employeeIdController,
              decoration: const InputDecoration(
                labelText: 'Employee ID',
                suffixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: firstNameController,
                    decoration: const InputDecoration(labelText: 'First Name'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: lastNameController,
                    decoration: const InputDecoration(labelText: 'Last Name'),
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
              employeeIdController.clear();
              loginController.clear();
              firstNameController.clear();
              lastNameController.clear();
            });
          },
          child: const Text('Reset'),
        ),
        ElevatedButton(
          onPressed: () {
            final filterData = EmployeesFilterData(
              login: loginController.text,
              employeeId: employeeIdController.text,
              firstName: firstNameController.text,
              lastName: lastNameController.text,
            );

            if (widget.onFiltersApplied != null) {
              widget.onFiltersApplied!(filterData);
            }

            context.pop();
          },
          child: const Text('Apply'),
        ),
      ],
    );
  }
}
