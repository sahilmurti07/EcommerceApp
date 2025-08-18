import 'package:flutter_application_1/data/productModel.dart';

class ProductSearch {
  /// Search products by title, description, brand, category, or tags
  static List<Product> searchProducts(List<Product> products, String query) {
    if (query.isEmpty) return products;

    query = query.toLowerCase();

    return products.where((product) {
      final titleMatch = product.title.toLowerCase().contains(query);
      final descMatch = product.description.toLowerCase().contains(query);
      final brandMatch = (product.brand ?? "").toLowerCase().contains(query);
      final tagsMatch = product.tags.any(
        (tag) => tag.toLowerCase().contains(query),
      );
      final categoryMatch = product.category.toString().toLowerCase().contains(
        query,
      );

      return titleMatch ||
          descMatch ||
          brandMatch ||
          tagsMatch ||
          categoryMatch;
    }).toList();
  }
}
