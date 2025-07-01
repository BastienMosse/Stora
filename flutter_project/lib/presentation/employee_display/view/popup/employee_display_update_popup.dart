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
  final _dobController = TextEditingController();
  final _phoneController = TextEditingController();
  final _payController = TextEditingController();
  final _noteController = TextEditingController();
  Role? _selectedRole;

  File? _profileImage;

  late AppLocalizations locale;
  late ThemeController theme;

  @override
  void initState() {
    super.initState();
    _loginController.text = widget.user.login;
    _selectedRole = Role.values.firstWhere((r) => r.value == widget.user.role);
    _emailController.text = widget.user.email;
    _dobController.text = widget.user.birth.split('T').first;
    _phoneController.text = widget.user.tel;
    _payController.text = widget.user.pay.toString();
    _noteController.text = widget.user.note;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    locale = AppLocalizations.of(context)!;
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
                  title: Text(
                    locale.employee_display_update_popup_annuler,
                    style: GoogleFonts.interTight(color: Colors.green),
                  ),
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          );
        },
      );
    } catch (e) {
      print('${locale.employee_display_update_popup_err_img_opt}$e');
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
    _dobController.dispose();
    _phoneController.dispose();
    _payController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    theme = context.watch<ThemeController>();

    return Dialog(
      backgroundColor: theme.currentTheme.PrimaryBackground,
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
                  locale.employee_display_update_update_create,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: theme.currentTheme.PrimaryText,
                  ),
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
                          color: theme.currentTheme.PrimaryBackground,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: theme.currentTheme.Primary,
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          size: 16,
                          color: theme.currentTheme.PrimaryBackground,
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
                        style: GoogleFonts.interTight(
                          color: theme.currentTheme.PrimaryText,
                        ),
                        controller: _loginController,
                        decoration: InputDecoration(
                          labelText:
                              locale.employee_display_update_update_login,
                          border: OutlineInputBorder(),
                        ),
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
                                child: Text(
                                  role.value,
                                  style: TextStyle(
                                    color: theme.currentTheme.PrimaryText,
                                  ),
                                ),
                              );
                            }).toList(),
                        onChanged: (val) {
                          setState(() {
                            _selectedRole = val;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextFormField(
                  style: GoogleFonts.interTight(
                    color: theme.currentTheme.PrimaryText,
                  ),
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',

                    hintText: 'xavier.login@stora.com',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.mail_outline),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  style: GoogleFonts.interTight(
                    color: theme.currentTheme.PrimaryText,
                  ),
                  controller: _dobController,
                  decoration: InputDecoration(
                    labelText: locale.employee_display_update_popup_date,
                    hintText: locale.employee_display_update_popup_date_ex,
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  keyboardType: TextInputType.datetime,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  style: GoogleFonts.interTight(
                    color: theme.currentTheme.PrimaryText,
                  ),
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: locale.employee_display_update_popup_phone,
                    hintText: locale.employee_display_update_popup_phone_ex,
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.phone),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  style: GoogleFonts.interTight(
                    color: theme.currentTheme.PrimaryText,
                  ),
                  controller: _payController,
                  decoration: InputDecoration(
                    labelText: locale.employee_display_update_popup_pay,
                    hintText: 'XXXX',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.monetization_on_sharp),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  style: GoogleFonts.interTight(
                    color: theme.currentTheme.PrimaryText,
                  ),
                  controller: _noteController,
                  decoration: InputDecoration(
                    labelText: locale.employee_display_update_popup_note,
                    hintText: locale.employee_display_update_popup_note,
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.note),
                  ),
                  keyboardType: TextInputType.text,
                  maxLines: 3,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: theme.currentTheme.Primary,
                        ),
                        onPressed: () => context.pop(),
                        child: Text(
                          locale.employee_display_update_popup_annuler,
                          style: TextStyle(
                            color: theme.currentTheme.PrimaryBackground,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.currentTheme.Primary,
                        ),
                        onPressed: () async {
                          final userId = widget.user.id;
                          final request = UserUpdateRequest(
                            login: _loginController.text,
                            username: _loginController.text
                                .replaceAll('.', ' ')
                                .split(' ')
                                .map(
                                  (word) =>
                                      word.isNotEmpty
                                          ? '${word[0].toUpperCase()}${word.substring(1)}'
                                          : '',
                                )
                                .join(' '),
                            role: _selectedRole ?? Role.USER,
                            email: _emailController.text,
                            birth: DateTime.tryParse(
                              RegExp(
                                    r'^\d{4}-\d{2}-\d{2}$',
                                  ).hasMatch(_dobController.text)
                                  ? _dobController.text
                                  : '',
                            ),
                            tel: _phoneController.text,
                            pay: double.tryParse(_payController.text) ?? 0.0,
                            note: _noteController.text,
                          );

                          UserUpdateResponse? response =
                              await Endpoints.updateUser(userId, request);

                          if (response != null) {
                            bool uploadSuccess = true;
                            if (_profileImage != null) {
                              final uploadResponse =
                                  await Endpoints.uploadUserPhoto(
                                    userId,
                                    _profileImage!,
                                  );
                              uploadSuccess = uploadResponse != null;
                            }

                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    uploadSuccess
                                        ? locale
                                            .employee_display_update_popup_success
                                        : locale
                                            .employee_display_create_popup_err_upload,
                                  ),
                                  backgroundColor:
                                      uploadSuccess
                                          ? theme.currentTheme.Success
                                          : theme.currentTheme.Error,
                                  duration: const Duration(seconds: 3),
                                ),
                              );
                            }

                            context.pop();
                          } else {
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    locale.employee_display_update_popup_error,
                                  ),
                                  backgroundColor: theme.currentTheme.Error,
                                  duration: const Duration(seconds: 3),
                                ),
                              );
                            }
                          }
                        },
                        child: Text(
                          locale.employee_display_update_update_button,
                          style: GoogleFonts.interTight(
                            color: theme.currentTheme.PrimaryBackground,
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
