import 'dart:convert';

import 'package:flutter_application_1/data/productModel.dart';
import 'package:http/http.dart' as http;

class ProductServices {
  final String baseUrl = "https://dummyjson.com/products";
  Future<Products> fetchProducts() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      return Products.fromJson(jsonBody);
    } else {
      throw Exception('failed to load : ${response.statusCode}');
    }
  }
}
