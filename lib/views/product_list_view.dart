import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/product_controller.dart';
import '../models/product_model.dart';
import '../routes/app_routes.dart';

class ProductListView extends StatelessWidget {
  const ProductListView({Key? p_key}) : super(key: p_key);

  @override
  Widget build(BuildContext p_context) {
    final ProductController v_controller = Get.find<ProductController>();

    return Scaffold(
      appBar: AppBar(
        title   : const Text('Products'),
        elevation: 2,
        actions : [
          IconButton(
            icon    : const Icon(Icons.refresh),
            onPressed: () => v_controller.refreshProducts(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child  : TextField(
              decoration: InputDecoration(
                hintText  : 'Search products...',
                prefixIcon: const Icon(Icons.search),
                border    : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled    : true,
                fillColor : Colors.grey[100],
              ),
              onChanged: (p_value) {
                v_controller.searchProducts(p_value);
              },
            ),
          ),
          
          // Products grid
          Expanded(
            child: Obx(() {
              if (v_controller.v_isLoading.value && v_controller.v_products.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (v_controller.v_errorMessage.isNotEmpty && v_controller.v_products.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children         : [
                      const Icon(
                        Icons.error_outline,
                        size : 64,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Error loading products',
                        style: Theme.of(p_context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child  : Text(
                          v_controller.v_errorMessage.value,
                          textAlign: TextAlign.center,
                          style    : Theme.of(p_context).textTheme.bodyMedium,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => v_controller.refreshProducts(),
                        child    : const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }

              if (v_controller.v_products.isEmpty) {
                return const Center(
                  child: Text('No products found'),
                );
              }

              return RefreshIndicator(
                onRefresh: v_controller.refreshProducts,
                child    : GridView.builder(
                  padding      : const EdgeInsets.all(16),
                  gridDelegate : const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount  : 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 12,
                    mainAxisSpacing : 12,
                  ),
                  itemCount : v_controller.v_products.length,
                  itemBuilder: (p_context, p_index) {
                    final v_product = v_controller.v_products[p_index];
                    return ProductCard(p_product: v_product);
                  },
                ),
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(AppRoutes.v_addProduct),
        child    : const Icon(Icons.add),
        tooltip  : 'Add Product',
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product v_product;

  const ProductCard({Key? p_key, required Product p_product})
      : v_product = p_product,
        super(key: p_key);

  @override
  Widget build(BuildContext p_context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation  : 2,
      shape      : RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Get.toNamed(AppRoutes.v_productDetail, arguments: v_product);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children          : [
            // Product image
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                color: Colors.grey[200],
                child: Image.network(
                  v_product.v_thumbnail,
                  fit         : BoxFit.cover,
                  errorBuilder: (p_context, p_error, p_stackTrace) {
                    return const Center(
                      child: Icon(
                        Icons.image_not_supported,
                        size : 48,
                        color: Colors.grey,
                      ),
                    );
                  },
                  loadingBuilder: (p_context, p_child, p_loadingProgress) {
                    if (p_loadingProgress == null) return p_child;
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),
            
            // Product info
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child  : Column(
                  crossAxisAlignment : CrossAxisAlignment.start,
                  mainAxisAlignment  : MainAxisAlignment.spaceBetween,
                  children           : [
                    Text(
                      v_product.v_title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style   : const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize  : 14,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children          : [
                        Text(
                          '\$${v_product.v_price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color     : Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize  : 16,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size : 16,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              v_product.v_rating.toStringAsFixed(1),
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
