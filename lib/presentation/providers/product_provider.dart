import 'package:flutter/material.dart';
import 'package:grocergo/data/models/product_model.dart';
import 'package:grocergo/data/models/category_model.dart';
import 'package:grocergo/data/services/api_service.dart';

class ProductProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<ProductModel> _products = [];
  List<CategoryModel> _categories = [];
  bool _isLoading = false;
  String? _error;

  List<ProductModel> get products => _products;
  List<CategoryModel> get categories => _categories;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchCategories() async {
    _setLoading(true);
    try {
      _categories = await _apiService.getCategories();
    } catch (e) {
      _error = e.toString();
    }
    _setLoading(false);
  }

  Future<void> fetchProducts() async {
    _setLoading(true);
    try {
      _products = await _apiService.getProducts();
    } catch (e) {
      _error = e.toString();
    }
    _setLoading(false);
  }

  Future<void> fetchProductsByCategory(String categoryId) async {
    _setLoading(true);
    try {
      _products = await _apiService.getProductsByCategory(categoryId);
    } catch (e) {
      _error = e.toString();
    }
    _setLoading(false);
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
