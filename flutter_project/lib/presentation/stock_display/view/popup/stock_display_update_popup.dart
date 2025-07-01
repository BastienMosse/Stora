import '/index.dart';

class ProductUpdatePopup extends StatefulWidget {
  final Product product;

  const ProductUpdatePopup({super.key, required this.product});

  @override
  State<ProductUpdatePopup> createState() => _ProductUpdatePopupState();
}

class _ProductUpdatePopupState extends State<ProductUpdatePopup> {
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
  void initState() {
    super.initState();
    _stock = widget.product.stockQuantity;
    _sell = widget.product.sellQuantity;
    _delivery = widget.product.deliveryQuantity;
    _selectedCategory = Category.values.firstWhere(
      (category) => category.value == widget.product.category,
      orElse: () => Category.OTHER,
    );
    _nameController.text = widget.product.name;
    _descriptionController.text = widget.product.description;
    _priceController.text = widget.product.price.toString();
    _positionController.text = widget.product.position;
    _noteController.text = widget.product.note;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(icon: const Icon(Icons.remove), onPressed: onDecrement),
          SizedBox(
            width: 40,
            child: Center(
              child: Text(
                counter.toString(),
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
          IconButton(icon: const Icon(Icons.add), onPressed: onIncrement),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
          maxWidth: 400,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    locale.product_update_popup_update_product,
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
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
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
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Description',
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
                    controller: _priceController,
                    decoration: const InputDecoration(
                      labelText: 'Price',
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
                    text: 'Stock',
                    counter: _stock,
                    onIncrement: () => setState(() => _stock++),
                    onDecrement:
                        () => setState(() {
                          if (_stock > 0) _stock--;
                        }),
                  ),
                  buildMenuButton(
                    text: 'Sell',
                    counter: _sell,
                    onIncrement: () => setState(() => _sell++),
                    onDecrement:
                        () => setState(() {
                          if (_sell > 0) _sell--;
                        }),
                  ),
                  buildMenuButton(
                    text: 'Delivery',
                    counter: _delivery,
                    onIncrement: () => setState(() => _delivery++),
                    onDecrement:
                        () => setState(() {
                          if (_delivery > 0) _delivery--;
                        }),
                  ),
                  const SizedBox(height: 6),
                  DropdownButtonFormField<Category>(
                    decoration: const InputDecoration(
                      labelText: 'Category',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedCategory,
                    items:
                        Category.values.map((role) {
                          return DropdownMenuItem(
                            value: role,
                            child: Text(role.value),
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
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _positionController,
                    decoration: InputDecoration(
                      labelText: 'Position',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.note),
                    ),
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _noteController,
                    decoration: InputDecoration(
                      labelText: 'Notes',
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
                              final request = ProductUpdateRequest(
                                name: _nameController.text,
                                description: _descriptionController.text,
                                price:
                                    double.tryParse(_priceController.text) ??
                                    0.0,
                                category:
                                    _selectedCategory?.value ??
                                    Category.OTHER.value,
                                stockQuantity: _stock,
                                sellQuantity: _sell,
                                deliveryQuantity: _delivery,
                                position: _positionController.text,
                                note: _noteController.text,
                              );
                              final response = await Endpoints.patchProductById(
                                widget.product.id,
                                request,
                              );

                              if (response == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      locale
                                          .employee_display_create_popup_err_create,
                                    ),
                                    backgroundColor: Colors.red,
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
                                        ),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          locale
                                              .employee_display_create_popup_succ_create,
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
                                        locale
                                            .employee_display_create_popup_succ_create,
                                      ),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                  Navigator.pop(context, true);
                                }
                              }
                            }
                          },
                          child: Text('Update product'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
