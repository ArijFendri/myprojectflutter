// services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';


class ApiService {
  final String apiUrl = "https://dummyjson.com/products";

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(apiUrl));
    
    if (response.statusCode == 200) {
      List products = json.decode(response.body)['products'];
      return products.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
