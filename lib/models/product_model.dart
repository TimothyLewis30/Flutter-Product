class Product {
  final int          v_id;
  final String       v_title;
  final String       v_description;
  final double       v_price;
  final double?      v_discountPercentage;
  final double       v_rating;
  final int          v_stock;
  final String?      v_brand;
  final String       v_category;
  final String       v_thumbnail;
  final List<String> v_images;

  Product({
    required int          p_id,
    required String       p_title,
    required String       p_description,
    required double       p_price,
             double?      p_discountPercentage,
    required double       p_rating,
    required int          p_stock,
             String?      p_brand,
    required String       p_category,
    required String       p_thumbnail,
    required List<String> p_images,
  })  : v_id                 = p_id,
        v_title              = p_title,
        v_description        = p_description,
        v_price              = p_price,
        v_discountPercentage = p_discountPercentage,
        v_rating             = p_rating,
        v_stock              = p_stock,
        v_brand              = p_brand,
        v_category           = p_category,
        v_thumbnail          = p_thumbnail,
        v_images             = p_images;

  // Factory constructor untuk parsing dari JSON
  factory Product.fromJson(Map<String, dynamic> p_json) {
    return Product(
      p_id                 : p_json['id'] ?? 0,
      p_title              : p_json['title'] ?? '',
      p_description        : p_json['description'] ?? '',
      p_price              : (p_json['price'] ?? 0).toDouble(),
      p_discountPercentage : p_json['discountPercentage']?.toDouble(),
      p_rating             : (p_json['rating'] ?? 0).toDouble(),
      p_stock              : p_json['stock'] ?? 0,
      p_brand              : p_json['brand'],
      p_category           : p_json['category'] ?? '',
      p_thumbnail          : p_json['thumbnail'] ?? '',
      p_images             : p_json['images'] != null 
          ? List<String>.from(p_json['images']) 
          : [],
    );
  }

  // Method untuk convert ke JSON (untuk POST request)
  Map<String, dynamic> toJson() {
    return {
      'title'              : v_title,
      'description'        : v_description,
      'price'              : v_price,
      'discountPercentage' : v_discountPercentage,
      'rating'             : v_rating,
      'stock'              : v_stock,
      'brand'              : v_brand,
      'category'           : v_category,
      'thumbnail'          : v_thumbnail,
      'images'             : v_images,
    };
  }
}

// Response model untuk list products
class ProductsResponse {
  final List<Product> v_products;
  final int           v_total;
  final int           v_skip;
  final int           v_limit;

  ProductsResponse({
    required List<Product> p_products,
    required int           p_total,
    required int           p_skip,
    required int           p_limit,
  })  : v_products = p_products,
        v_total    = p_total,
        v_skip     = p_skip,
        v_limit    = p_limit;

  factory ProductsResponse.fromJson(Map<String, dynamic> p_json) {
    return ProductsResponse(
      p_products : (p_json['products'] as List)
          .map((p_productJson) => Product.fromJson(p_productJson))
          .toList(),
      p_total    : p_json['total'] ?? 0,
      p_skip     : p_json['skip'] ?? 0,
      p_limit    : p_json['limit'] ?? 0,
    );
  }
}
