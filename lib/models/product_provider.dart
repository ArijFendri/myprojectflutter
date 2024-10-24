import 'package:flutter/material.dart';
import '../models/product.dart'; 
import '../services/api_service.dart';

class ProductProvider with ChangeNotifier {
  final ApiService apiService = ApiService();
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  String _searchQuery = "";

  List<Product> get products => _filteredProducts;
  String get searchQuery => _searchQuery;

  ProductProvider() {
    fetchProducts();
  }

  // Récupérer les produits depuis l'API
  Future<void> fetchProducts() async {
    _products = await apiService.fetchProducts();
    _filteredProducts = _products;
    notifyListeners();
  }

  // Filtrer les produits en fonction de la recherche
  void searchProducts(String query) {
    _searchQuery = query;
    if (query.isEmpty) {
      _filteredProducts = _products;
    } else {
      _filteredProducts = _products
          .where((product) =>
              product.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  // Changer l'état du produit favori
  void toggleFavorite(Product product) {
    product.isFavorite = !product.isFavorite;
    notifyListeners();
  }
}
