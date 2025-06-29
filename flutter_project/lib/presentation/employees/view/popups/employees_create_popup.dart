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
  Role? _selectedRole;
  bool _obscurePassword = true;

  File? _profileImage;

  Future<void> _showImageOptions() async {
    try {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Galerie'),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImageFromGallery();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Caméra'),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImageFromCamera();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.cancel),
                  title: const Text('Annuler'),
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          );
        },
      );
    } catch (e) {
      print('Error showing image options: $e');
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
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Erreur: Image picker non disponible sur cet émulateur. Testez sur un appareil physique.',
          ),
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                const Text(
                  'Create New Employee',
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
                        controller: _firstNameController,
                        decoration: const InputDecoration(
                          labelText: 'First Name',
                          border: OutlineInputBorder(),
                        ),
                        validator:
                            (v) => v == null || v.isEmpty ? 'Required' : null,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        controller: _lastNameController,
                        decoration: const InputDecoration(
                          labelText: 'Last Name',
                          border: OutlineInputBorder(),
                        ),
                        validator:
                            (v) => v == null || v.isEmpty ? 'Required' : null,
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
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 12),
                StatefulBuilder(
                  builder: (context, setState) {
                    return TextFormField(
                      controller: _passwdController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
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
                          (v) => v == null || v.isEmpty ? 'Required' : null,
                    );
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _dobController,
                  decoration: const InputDecoration(
                    labelText: 'Date of Birth',
                    hintText: 'YYYY/MM/DD',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  keyboardType: TextInputType.datetime,
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    hintText: '12 34 56 78 90',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.phone),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _payController,
                  decoration: const InputDecoration(
                    labelText: 'Pay',
                    hintText: 'XXXX',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.monetization_on_sharp),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 12),
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
                          child: Text(role.value),
                        );
                      }).toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedRole = val;
                    });
                  },
                  validator: (v) => v == null ? 'Required' : null,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            final request = RegisterRequest(
                              login:
                                  '${_firstNameController.text.toLowerCase()}.${_lastNameController.text.toLowerCase()}',
                              username:
                                  '${_firstNameController.text} ${_lastNameController.text}',
                              // email: _emailController.text,
                              password: _passwdController.text,
                              // dateOfBirth: _dobController.text,
                              // phoneNumber: _phoneController.text,
                              // pay: double.tryParse(_payController.text) ?? 0.0,
                              role: _selectedRole?.value ?? 'USER',
                              // profileImage: _profileImage,
                            );
                            final response = await Endpoints.register(request);

                            if (response == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Error creating employee'),
                                  backgroundColor: Colors.red,
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
                                      content: Text('Error uploading image'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Employee created successfully!',
                                      ),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                  Navigator.pop(context, true);
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Employee created successfully!',
                                    ),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                                Navigator.pop(context, true);
                              }
                            }
                          }
                        },
                        child: const Text('Create'),
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
