import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ApiService {
  static const String v_baseUrl = 'https://dummyjson.com';

  // GET: Fetch products with pagination
  Future<ProductsResponse> fetchProducts({int p_limit = 30, int p_skip = 0}) async {
    try {
      final v_response = await http.get(
        Uri.parse('$v_baseUrl/products?limit=$p_limit&skip=$p_skip'),
      );

      if (v_response.statusCode == 200) {
        final v_data = json.decode(v_response.body);
        return ProductsResponse.fromJson(v_data);
      } else {
        throw Exception('Failed to load products: ${v_response.statusCode}');
      }
    } catch (p_e) {
      throw Exception('Error fetching products: $p_e');
    }
  }

  // GET: Fetch single product by ID
  Future<Product> fetchProductById(int p_id) async {
    try {
      final v_response = await http.get(
        Uri.parse('$v_baseUrl/products/$p_id'),
      );

      if (v_response.statusCode == 200) {
        final v_data = json.decode(v_response.body);
        return Product.fromJson(v_data);
      } else {
        throw Exception('Failed to load product: ${v_response.statusCode}');
      }
    } catch (p_e) {
      throw Exception('Error fetching product: $p_e');
    }
  }

  // GET: Search products by query
  Future<ProductsResponse> searchProducts(String p_query) async {
    try {
      final v_response = await http.get(
        Uri.parse('$v_baseUrl/products/search?q=$p_query'),
      );

      if (v_response.statusCode == 200) {
        final v_data = json.decode(v_response.body);
        return ProductsResponse.fromJson(v_data);
      } else {
        throw Exception('Failed to search products: ${v_response.statusCode}');
      }
    } catch (p_e) {
      throw Exception('Error searching products: $p_e');
    }
  }

  // POST: Add new product
  Future<Product> addProduct(Product p_product) async {
    try {
      final v_response = await http.post(
        Uri.parse('$v_baseUrl/products/add'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(p_product.toJson()),
      );

      if (v_response.statusCode == 200 || v_response.statusCode == 201) {
        final v_data = json.decode(v_response.body);
        return Product.fromJson(v_data);
      } else {
        throw Exception('Failed to add product: ${v_response.statusCode}');
      }
    } catch (p_e) {
      throw Exception('Error adding product: $p_e');
    }
  }
}
