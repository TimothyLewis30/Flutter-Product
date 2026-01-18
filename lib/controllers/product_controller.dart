import 'package:get/get.dart';
import '../models/product_model.dart';
import '../services/api_service.dart';

class ProductController extends GetxController {
  final ApiService v_apiService = ApiService();

  // Observable lists and states
  var v_products     = <Product>[].obs;
  var v_isLoading    = false.obs;
  var v_errorMessage = ''.obs;
  var v_searchQuery  = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  // GET: Fetch products
  Future<void> fetchProducts() async {
    try {
      v_isLoading.value    = true;
      v_errorMessage.value = '';
      
      final v_response   = await v_apiService.fetchProducts(p_limit: 30, p_skip: 0);
      v_products.value = v_response.v_products;
    } catch (p_e) {
      v_errorMessage.value = p_e.toString();
      Get.snackbar(
        'Error',
        'Failed to load products: $p_e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      v_isLoading.value = false;
    }
  }

  // GET: Search products
  Future<void> searchProducts(String p_query) async {
    if (p_query.isEmpty) {
      fetchProducts();
      return;
    }

    try {
      v_isLoading.value    = true;
      v_errorMessage.value = '';
      v_searchQuery.value  = p_query;
      
      final v_response   = await v_apiService.searchProducts(p_query);
      v_products.value = v_response.v_products;
    } catch (p_e) {
      v_errorMessage.value = p_e.toString();
      Get.snackbar(
        'Error',
        'Failed to search products: $p_e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      v_isLoading.value = false;
    }
  }

  // POST: Add new product
  Future<bool> addProduct({
    required String p_title,
    required String p_description,
    required double p_price,
    required String p_category,
    String?         p_brand,
  }) async {
    try {
      v_isLoading.value    = true;
      v_errorMessage.value = '';

      // Create new product object
      final v_newProduct = Product(
        p_id          : 0, // API will assign ID
        p_title       : p_title,
        p_description : p_description,
        p_price       : p_price,
        p_rating      : 0,
        p_stock       : 100, // Default stock
        p_brand       : p_brand,
        p_category    : p_category,
        p_thumbnail   : 'https://via.placeholder.com/150',
        p_images      : ['https://via.placeholder.com/150'],
      );

      final v_addedProduct = await v_apiService.addProduct(v_newProduct);
      
      // Add to the beginning of the list
      v_products.insert(0, v_addedProduct);
      
      Get.snackbar(
        'Success',
        'Product "${v_addedProduct.v_title}" added successfully!',
        snackPosition: SnackPosition.BOTTOM,
      );
      
      return true;
    } catch (p_e) {
      v_errorMessage.value = p_e.toString();
      Get.snackbar(
        'Error',
        'Failed to add product: $p_e',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      v_isLoading.value = false;
    }
  }

  // Refresh products (for pull to refresh)
  Future<void> refreshProducts() async {
    await fetchProducts();
  }
}
