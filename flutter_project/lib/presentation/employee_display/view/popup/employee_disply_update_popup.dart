import '/index.dart';

class EmployeeUpdatePopup extends StatefulWidget {
  final User user;

  const EmployeeUpdatePopup({super.key, required this.user});

  @override
  State<EmployeeUpdatePopup> createState() => _EmployeeUpdatePopupState();
}

class _EmployeeUpdatePopupState extends State<EmployeeUpdatePopup> {
  final _formKey = GlobalKey<FormState>();
  final _loginController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwdController = TextEditingController();
  final _dobController = TextEditingController();
  final _phoneController = TextEditingController();
  final _payController = TextEditingController();
  Role? _selectedRole;
  bool _obscurePassword = true;

  File? _profileImage;

  @override
  void initState() {
    super.initState();
    _loginController.text = widget.user.username.split(' ').first;
    _selectedRole = Role.values.firstWhere((r) => r.value == widget.user.role);
    _emailController.text = widget.user.email;
    _passwdController.text = '';
    _dobController.text = widget.user.birth.toString();
    _phoneController.text = widget.user.tel;
    _payController.text = widget.user.pay.toString();
  }

  Future<void> _showImageOptions() async {
    final locale = AppLocalizations.of(context)!;
    try {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: Text(locale.employee_display_update_popup_gallerie),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImageFromGallery();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: Text(locale.employee_display_update_popup_camera),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImageFromCamera();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.cancel),
                  title: Text(locale.employee_display_update_popup_annuler),
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          );
        },
      );
    } catch (e) {
      print(locale.employee_display_update_popup_err_img_opt + '$e');
    }
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _profileImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      _showImageError();
    }
  }

  Future<void> _pickImageFromCamera() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        setState(() {
          _profileImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      _showImageError();
    }
  }

  void _showImageError() {
    final locale = AppLocalizations.of(context)!;
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(locale.employee_display_update_popup_err_img_disp),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  void dispose() {
    _loginController.dispose();
    _emailController.dispose();
    _passwdController.dispose();
    _dobController.dispose();
    _phoneController.dispose();
    _payController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  locale.employee_display_update_popup_create,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          _profileImage != null
                              ? FileImage(_profileImage!)
                              : null,
                    ),
                    GestureDetector(
                      onTap: _showImageOptions,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _loginController,
                        decoration: InputDecoration(
                          labelText:
                              locale.employee_display_update_popup_firstname,
                          border: OutlineInputBorder(),
                        ),
                        validator:
                            (v) =>
                                v == null || v.isEmpty
                                    ? locale
                                        .employee_display_update_popup_required
                                    : null,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DropdownButtonFormField<Role>(
                        decoration: const InputDecoration(
                          labelText: 'Role',
                          border: OutlineInputBorder(),
                        ),
                        value: _selectedRole,
                        items:
                            Role.values.map((role) {
                              return DropdownMenuItem(
                                value: role,
                                child: Text(role.value),
                              );
                            }).toList(),
                        onChanged: (val) {
                          setState(() {
                            _selectedRole = val;
                          });
                        },
                        validator:
                            (v) =>
                                v == null
                                    ? locale
                                        .employee_display_update_popup_required
                                    : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'xavier.login@stora.com',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.mail_outline),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator:
                      (v) =>
                          v == null || v.isEmpty
                              ? locale.employee_display_update_popup_required
                              : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _dobController,
                  decoration: InputDecoration(
                    labelText: locale.employee_display_update_popup_date,
                    hintText: locale.employee_display_update_popup_date_ex,
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  keyboardType: TextInputType.datetime,
                  validator:
                      (v) =>
                          v == null || v.isEmpty
                              ? locale.employee_display_update_popup_required
                              : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: locale.employee_display_update_popup_phone,
                    hintText: locale.employee_display_update_popup_phone_ex,
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.phone),
                  ),
                  keyboardType: TextInputType.phone,
                  validator:
                      (v) =>
                          v == null || v.isEmpty
                              ? locale.employee_display_update_popup_required
                              : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _payController,
                  decoration: InputDecoration(
                    labelText: locale.employee_display_update_popup_pay,
                    hintText: 'XXXX',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.monetization_on_sharp),
                  ),
                  keyboardType: TextInputType.number,
                  validator:
                      (v) =>
                          v == null || v.isEmpty
                              ? locale.employee_display_update_popup_required
                              : null,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: Text(
                          locale.employee_display_update_popup_annuler,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            // TODO : update
                          }
                        },
                        child: Text(
                          locale.employee_display_update_popup_create,
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
