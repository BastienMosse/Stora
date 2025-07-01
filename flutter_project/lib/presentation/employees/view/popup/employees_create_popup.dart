import '/index.dart';

class EmployeeCreatePopup extends StatefulWidget {
  const EmployeeCreatePopup({super.key});

  @override
  State<EmployeeCreatePopup> createState() => _EmployeeCreatePopupState();
}

class _EmployeeCreatePopupState extends State<EmployeeCreatePopup> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwdController = TextEditingController();
  final _dobController = TextEditingController();
  final _phoneController = TextEditingController();
  final _payController = TextEditingController();
  final _noteController = TextEditingController();

  Role? _selectedRole;
  bool _obscurePassword = true;
  late ThemeController theme;

  File? _profileImage;

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
      print('${locale.employee_display_update_popup_err_img_opt} $e');
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
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwdController.dispose();
    _dobController.dispose();
    _phoneController.dispose();
    _payController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme = context.read<ThemeController>();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
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
                  locale.employee_display_update_popup_create,
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
                          color: theme.currentTheme.Primary,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
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
                        controller: _firstNameController,
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
                      child: TextFormField(
                        style: GoogleFonts.interTight(
                          color: theme.currentTheme.PrimaryText,
                        ),
                        controller: _lastNameController,
                        decoration: InputDecoration(
                          labelText:
                              locale.employee_display_create_popup_lastname,
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
                  validator:
                      (v) =>
                          v == null || v.isEmpty
                              ? locale.employee_display_update_popup_required
                              : null,
                ),
                const SizedBox(height: 12),
                StatefulBuilder(
                  builder: (context, setState) {
                    return TextFormField(
                      style: GoogleFonts.interTight(
                        color: theme.currentTheme.PrimaryText,
                      ),
                      controller: _passwdController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText:
                            locale.employee_display_update_popup_password,
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      validator:
                          (v) =>
                              v == null || v.isEmpty
                                  ? locale
                                      .employee_display_update_popup_required
                                  : null,
                    );
                  },
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
                  validator:
                      (v) =>
                          v == null || v.isEmpty
                              ? locale.employee_display_update_popup_required
                              : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  style: GoogleFonts.interTight(
                    color: theme.currentTheme.PrimaryText,
                  ),
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: locale.employee_display_update_popup_phone,
                    hintText: '12 34 56 78 90',
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
                  validator:
                      (v) =>
                          v == null || v.isEmpty
                              ? locale.employee_display_update_popup_required
                              : null,
                ),
                const SizedBox(height: 12),
                Theme(
                  data:Theme.of(context).copyWith(
                    canvasColor: theme.currentTheme.PrimaryBackground,
                  ), 
                  child: 
                    DropdownButtonFormField<Role>(
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
                                role.value,style: TextStyle(
                                  color: theme.currentTheme.PrimaryText,
                                )
                              ),
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
                                  ? locale.employee_display_update_popup_required
                                  : null,
                    ),
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
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.currentTheme.Primary,
                        ),
                        onPressed: () => Navigator.pop(context, false),
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
                          if (_formKey.currentState?.validate() ?? false) {
                            final request = UserRegisterRequest(
                              login:
                                  '${_firstNameController.text.toLowerCase()}.${_lastNameController.text.toLowerCase()}',
                              username:
                                  '${_firstNameController.text} ${_lastNameController.text}',
                              email: _emailController.text,
                              password: _passwdController.text,
                              birth:
                                  _dobController.text.isNotEmpty
                                      ? DateTime.tryParse(_dobController.text)
                                      : null,
                              tel: _phoneController.text,
                              pay: double.tryParse(_payController.text) ?? 0.0,
                              role: _selectedRole ?? Role.USER,
                              note: _noteController.text,
                            );
                            final response = await Endpoints.register(request);

                            if (response == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    locale
                                        .employee_display_create_popup_err_create,
                                  ),
                                  backgroundColor: theme.currentTheme.Error,
                                ),
                              );
                            } else {
                              if (_profileImage != null) {
                                final uploadedImage =
                                    await Endpoints.uploadUserPhoto(
                                      response.user.id,
                                      _profileImage!,
                                    );
                                if (uploadedImage == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        locale
                                            .employee_display_create_popup_err_upload,
                                      ),
                                      backgroundColor: theme.currentTheme.Error,
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        locale
                                            .employee_display_create_popup_succ_create,
                                      ),
                                      backgroundColor:
                                          theme.currentTheme.Success,
                                    ),
                                  );
                                  Navigator.pop(context, true);
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      locale
                                          .employee_display_create_popup_succ_create,
                                    ),
                                    backgroundColor: theme.currentTheme.Success,
                                  ),
                                );
                                Navigator.pop(context, true);
                              }
                            }
                          }
                        },
                        child: Text(
                          locale.employee_display_update_popup_create,
                          style: TextStyle(
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
