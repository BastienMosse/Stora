import '/index.dart';

class StockCreatePopup extends StatefulWidget {
  const StockCreatePopup({super.key});

  @override
  State<StockCreatePopup> createState() => _StockCreatePopupState();
}

class _StockCreatePopupState extends State<StockCreatePopup> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _positionController = TextEditingController();
  final _noteController = TextEditingController();
  Category? _selectedCategory;

  int _stock = 0;
  int _sell = 0;
  int _delivery = 0;

  File? _profileImage;

  late AppLocalizations locale;
  late ThemeController theme;

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    locale = AppLocalizations.of(context)!;
    theme = context.watch<ThemeController>();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _positionController.dispose();
    _noteController.dispose();
  }

  Widget buildMenuButton({
    required String text,
    required int counter,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              text,
              style: GoogleFonts.interTight(
                fontWeight: FontWeight.w500,
                color: theme.currentTheme.PrimaryText,
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(icon: Icon(Icons.remove), onPressed: onDecrement),
          SizedBox(
            width: 40,
            child: Center(
              child: Text(
                counter.toString(),
                style: GoogleFonts.interTight(
                  fontSize: 16,
                  color: theme.currentTheme.PrimaryText,
                ),
              ),
            ),
          ),
          IconButton(icon: Icon(Icons.add), onPressed: onIncrement),
        ],
      ),
    );
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
                  locale.stock_create_create,
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
                          color: Theme.of(context).primaryColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: theme.currentTheme.PrimaryBackground,
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
                TextFormField(
                  style: GoogleFonts.interTight(
                    color: theme.currentTheme.PrimaryText,
                  ),
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: locale.stock_create_name,
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
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
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: locale.stock_create_description,
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
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
                  controller: _priceController,
                  decoration: InputDecoration(
                    labelText: locale.stock_create_price,
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator:
                      (v) =>
                          v == null || v.isEmpty
                              ? locale.employee_display_update_popup_required
                              : null,
                ),
                const SizedBox(height: 6),
                buildMenuButton(
                  text: locale.stock_create_quantity_sto,
                  counter: _stock,
                  onIncrement: () => setState(() => _stock++),
                  onDecrement:
                      () => setState(() {
                        if (_stock > 0) _stock--;
                      }),
                ),
                buildMenuButton(
                  text: locale.stock_create_quantity_sel,
                  counter: _sell,
                  onIncrement: () => setState(() => _sell++),
                  onDecrement:
                      () => setState(() {
                        if (_sell > 0) _sell--;
                      }),
                ),
                buildMenuButton(
                  text: locale.stock_create_quantity_del,
                  counter: _delivery,
                  onIncrement: () => setState(() => _delivery++),
                  onDecrement:
                      () => setState(() {
                        if (_delivery > 0) _delivery--;
                      }),
                ),
                const SizedBox(height: 6),
                Theme(
                  data: Theme.of(
                    context,
                  ).copyWith(canvasColor: theme.currentTheme.PrimaryBackground),
                  child: DropdownButtonFormField<Category>(
                    decoration: const InputDecoration(
                      labelText: 'Category',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedCategory,
                    items:
                        Category.values.map((role) {
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
                        _selectedCategory = val;
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
                  controller: _positionController,
                  decoration: InputDecoration(
                    labelText: locale.stock_create_position,
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _noteController,
                  decoration: InputDecoration(
                    labelText: locale.stock_create_notes,
                    border: OutlineInputBorder(),
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
                            final request = ProductCreateRequest(
                              name: _nameController.text,
                              description: _descriptionController.text,
                              price:
                                  double.tryParse(_priceController.text) ?? 0.0,
                              category: _selectedCategory ?? Category.OTHER,
                              stockQuantity: _stock,
                              sellQuantity: _sell,
                              deliveryQuantity: _delivery,
                              position: _positionController.text,
                              note: _noteController.text,
                            );
                            final response = await Endpoints.postProducts(
                              request,
                            );

                            if (response == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    locale
                                        .employee_display_create_popup_err_create,
                                    style: TextStyle(
                                      color: theme.currentTheme.PrimaryText,
                                    ),
                                  ),
                                  backgroundColor:
                                      theme.currentTheme.PrimaryBackground,
                                ),
                              );
                            } else {
                              if (_profileImage != null) {
                                final uploadedImage =
                                    await Endpoints.uploadProductPhoto(
                                      response.product.id,
                                      _profileImage!,
                                    );
                                if (uploadedImage == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        locale
                                            .employee_display_create_popup_err_upload,
                                        style: TextStyle(
                                          color: theme.currentTheme.PrimaryText,
                                        ),
                                      ),
                                      backgroundColor:
                                          theme.currentTheme.PrimaryBackground,
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        locale
                                            .employee_display_create_popup_succ_create,
                                        style: TextStyle(
                                          color: theme.currentTheme.PrimaryText,
                                        ),
                                      ),
                                      backgroundColor:
                                          theme.currentTheme.PrimaryBackground,
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
                                      style: TextStyle(
                                        color: theme.currentTheme.PrimaryText,
                                      ),
                                    ),
                                    backgroundColor:
                                        theme.currentTheme.PrimaryBackground,
                                  ),
                                );
                                Navigator.pop(context, true);
                              }
                            }
                          }
                        },
                        child: Text(
                          locale.stock_create_create,
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
