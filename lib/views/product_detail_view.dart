import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/product_model.dart';

class ProductDetailView extends StatelessWidget {
  const ProductDetailView({Key? p_key}) : super(key: p_key);

  @override
  Widget build(BuildContext p_context) {
    final Product v_product = Get.arguments as Product;

    return Scaffold(
      appBar: AppBar(
        title    : const Text('Product Detail'),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children          : [
            // Image carousel
            SizedBox(
              height: 300,
              child : PageView.builder(
                itemCount  : v_product.v_images.isNotEmpty ? v_product.v_images.length : 1,
                itemBuilder: (p_context, p_index) {
                  final v_imageUrl = v_product.v_images.isNotEmpty
                      ? v_product.v_images[p_index]
                      : v_product.v_thumbnail;
                  
                  return Container(
                    color: Colors.grey[200],
                    child: Image.network(
                      v_imageUrl,
                      fit         : BoxFit.contain,
                      errorBuilder: (p_context, p_error, p_stackTrace) {
                        return const Center(
                          child: Icon(
                            Icons.image_not_supported,
                            size : 64,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child  : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children          : [
                  // Title
                  Text(
                    v_product.v_title,
                    style: Theme.of(p_context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  
                  // Brand and Category
                  Row(
                    children: [
                      if (v_product.v_brand != null) ...[
                        Chip(
                          label : Text(v_product.v_brand!),
                          avatar: const Icon(Icons.business, size: 16),
                        ),
                        const SizedBox(width: 8),
                      ],
                      Chip(
                        label : Text(v_product.v_category),
                        avatar: const Icon(Icons.category, size: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Price and Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children         : [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children          : [
                          const Text(
                            'Price',
                            style: TextStyle(
                              color   : Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            '\$${v_product.v_price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color     : Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize  : 28,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical  : 8,
                        ),
                        decoration: BoxDecoration(
                          color       : Colors.amber.shade100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size : 24,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              v_product.v_rating.toStringAsFixed(1),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize  : 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Stock
                  Row(
                    children: [
                      const Text(
                        'Stock: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize  : 16,
                        ),
                      ),
                      Text(
                        '${v_product.v_stock} units',
                        style: TextStyle(
                          color   : v_product.v_stock > 0 ? Colors.green : Colors.red,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Description
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize  : 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    v_product.v_description,
                    style: const TextStyle(
                      fontSize: 16,
                      height  : 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Additional info
                  if (v_product.v_discountPercentage != null) ...[
                    Container(
                      padding   : const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color       : Colors.red.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border      : Border.all(color: Colors.red.shade200),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.discount,
                            color: Colors.red,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Discount: ${v_product.v_discountPercentage!.toStringAsFixed(1)}% OFF',
                            style: const TextStyle(
                              color     : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
