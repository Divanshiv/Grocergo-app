import 'package:flutter/material.dart';
import 'package:grocergo/data/models/order_model.dart';
import 'package:grocergo/data/services/api_service.dart';

class OrderProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<OrderModel> _orders = [];
  bool _isLoading = false;
  String? _error;

  List<OrderModel> get orders => _orders;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<bool> placeOrder(OrderModel order) async {
    _setLoading(true);
    try {
      final newOrder = await _apiService.placeOrder(order);
      _orders.insert(0, newOrder);
      _setLoading(false);
      return true;
    } catch (e) {
      _error = e.toString();
      _setLoading(false);
      return false;
    }
  }

  Future<void> fetchOrders() async {
    _setLoading(true);
    try {
      _orders = await _apiService.getOrders();
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
