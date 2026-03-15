import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:grocergo/data/models/cart_item_model.dart';
import 'package:grocergo/data/models/product_model.dart';

class CartProvider with ChangeNotifier {
  final Box _cartBox = Hive.box('cart');
  List<CartItemModel> _items = [];

  CartProvider() {
    _loadCart();
  }

  void _loadCart() {
    _items = _cartBox.values.cast<CartItemModel>().toList();
    notifyListeners();
  }

  void _saveCart() {
    _cartBox.clear();
    for (var item in _items) {
      _cartBox.add(item);
    }
  }

  List<CartItemModel> get items => [..._items];

  int get itemCount => _items.length;

  double get subtotal => _items.fold(0, (sum, item) => sum + item.totalPrice);

  double get deliveryFee => subtotal > 50 ? 0 : 5.0;

  double get totalAmount => subtotal + deliveryFee;

  void addToCart(ProductModel product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      _items[index].quantity += 1;
    } else {
      _items.add(CartItemModel(product: product));
    }
    _saveCart();
    notifyListeners();
  }

  void updateQuantity(String productId, int quantity) {
    final index = _items.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      if (quantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index].quantity = quantity;
      }
      _saveCart();
      notifyListeners();
    }
  }

  void removeItem(String productId) {
    _items.removeWhere((item) => item.product.id == productId);
    _saveCart();
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    _saveCart();
    notifyListeners();
  }
}
