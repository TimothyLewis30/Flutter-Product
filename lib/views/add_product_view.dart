import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import '../controllers/product_controller.dart';


class AddProductView extends StatefulWidget {
  const AddProductView({Key? p_key}) : super(key: p_key);

  @override
  State<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  final GlobalKey<FormState> v_formKey                = GlobalKey<FormState>();
  final TextEditingController v_titleController       = TextEditingController();
  final TextEditingController v_descriptionController = TextEditingController();
  final TextEditingController v_priceController       = TextEditingController();
  final TextEditingController v_categoryController    = TextEditingController();
  final TextEditingController v_brandController       = TextEditingController();
  String? v_selectedCategory;
  
  @override
  void dispose() {
    v_titleController.dispose();
    v_descriptionController.dispose();
    v_priceController.dispose();
    v_categoryController.dispose();
    v_brandController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (v_formKey.currentState!.validate()) {
      final ProductController v_controller = Get.find<ProductController>();
      
      final v_success = await v_controller.addProduct(
        p_title      : v_titleController.text,
        p_description: v_descriptionController.text,
        p_price      : double.parse(v_priceController.text),
        p_category   : v_categoryController.text,
        p_brand      : v_brandController.text.isEmpty ? null : v_brandController.text,
      );

      if (v_success) {
        Get.back(); // Navigate back to product list
      }
    }
  }

  @override
  Widget build(BuildContext p_context) {
    final ProductController v_controller = Get.find<ProductController>();

    return Scaffold(
      appBar: AppBar(
        title    : const Text('Add New Product'),
        elevation: 2,
      ),
      body: Obx(() {
        return Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child  : Form(
                key: v_formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children          : [
                    // Title field
                    TextFormField(
                      controller: v_titleController,
                      decoration: InputDecoration(
                        labelText : 'Product Title *',
                        hintText  : 'Enter product title',
                        border    : OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.title),
                      ),
                      validator: (p_value) {
                        if (p_value == null || p_value.isEmpty) {
                          return 'Please enter product title';
                        }
                        if (p_value.length < 3) {
                          return 'Title must be at least 3 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    
                    // Description field
                    TextFormField(
                      controller: v_descriptionController,
                      decoration: InputDecoration(
                        labelText : 'Description *',
                        hintText  : 'Enter product description',
                        border    : OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.description),
                      ),
                      maxLines : 4,
                      validator: (p_value) {
                        if (p_value == null || p_value.isEmpty) {
                          return 'Please enter product description';
                        }
                        if (p_value.length < 10) {
                          return 'Description must be at least 10 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    
                    // Price field
                    TextFormField(
                      controller      : v_priceController,
                      decoration      : InputDecoration(
                        labelText : 'Price *',
                        hintText  : 'Enter product price',
                        border    : OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon    : const Icon(Icons.attach_money),
                      ),
                      keyboardType    : const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters : [
                        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                      ],
                      validator   : (p_value) {
                        if (p_value == null || p_value.isEmpty) {
                          return 'Please enter product price';
                        }
                        final v_price = double.tryParse(p_value);
                        if (v_price == null) {
                          return 'Please enter a valid number';
                        }
                        if (v_price <= 0) {
                          return 'Price must be greater than 0';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    
                    // Category field
                  DropdownButtonFormField<String>(
                    value: v_selectedCategory,
                    decoration: InputDecoration(
                      labelText: 'Category *',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.category),
                    ),
                    hint: const Text('Select category'),
                    items: const [
                      DropdownMenuItem(
                        value: 'electronics',
                        child: Text('Electronics'),
                      ),
                      DropdownMenuItem(
                        value: 'clothing',
                        child: Text('Clothing'),
                      ),
                      DropdownMenuItem(
                        value: 'food',
                        child: Text('Food'),
                      ),
                      DropdownMenuItem(
                        value: 'Beverages',
                        child: Text('Beverages'),
                      ),
                      DropdownMenuItem(
                        value: 'Skincare',
                        child: Text('Skincare'),
                      ),
                      DropdownMenuItem(
                        value: 'Toys',
                        child: Text('Toys'),
                      ),
                    ],
                    onChanged: (value) {
                      v_selectedCategory = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select product category';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                    
                    // Brand field (optional)
                    TextFormField(
                      controller: v_brandController,
                      decoration: InputDecoration(
                        labelText : 'Brand (Optional)',
                        hintText  : 'Enter product brand',
                        border    : OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.business),
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Submit button
                    ElevatedButton(
                      onPressed: v_controller.v_isLoading.value ? null : _submitForm,
                      style    : ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape  : RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Add Product',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Helper text
                    const Text(
                      '* Required fields',
                      style: TextStyle(
                        fontSize: 12,
                        color   : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Loading overlay
            if (v_controller.v_isLoading.value)
              Container(
                color: Colors.black.withOpacity(0.3),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        );
      }),
    );
  }
}
