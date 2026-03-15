import 'package:grocergo/data/models/product_model.dart';
import 'package:grocergo/data/models/category_model.dart';
import 'package:grocergo/data/models/user_model.dart';
import 'package:grocergo/data/models/order_model.dart';

class ApiService {
  // Mock data for demonstration as real API is not available
  static List<CategoryModel> mockCategories = [
    CategoryModel(id: '1', name: 'Vegetables', imageUrl: 'https://images.unsplash.com/photo-1566385101042-1a000c1268cc'),
    CategoryModel(id: '2', name: 'Fruits', imageUrl: 'https://images.unsplash.com/photo-1619566636858-adf3ef46400b'),
    CategoryModel(id: '3', name: 'Dairy', imageUrl: 'https://images.unsplash.com/photo-1550583724-125581f778d3'),
    CategoryModel(id: '4', name: 'Bakery', imageUrl: 'https://images.unsplash.com/photo-1509440159596-0249088772ff'),
  ];

  static List<ProductModel> mockProducts = [
    ProductModel(id: '1', name: 'Fresh Tomato', description: 'Organic farm fresh tomatoes', price: 2.5, imageUrl: 'https://images.unsplash.com/photo-1518977676601-b53f82aba655', categoryId: '1'),
    ProductModel(id: '2', name: 'Potato', description: 'Fresh potatoes from hills', price: 1.5, imageUrl: 'https://images.unsplash.com/photo-1518977676601-b53f82aba655', categoryId: '1'),
    ProductModel(id: '3', name: 'Banana', description: 'Sweet yellow bananas', price: 1.2, imageUrl: 'https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e', categoryId: '2'),
    ProductModel(id: '4', name: 'Milk 1L', description: 'Pure cow milk', price: 3.0, imageUrl: 'https://images.unsplash.com/photo-1550583724-125581f778d3', categoryId: '3'),
  ];

  Future<UserModel> login(String email, String password) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    return UserModel(id: 'u1', name: 'John Doe', email: email, address: '123 Main St', phoneNumber: '1234567890');
  }

  Future<UserModel> register(String name, String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    return UserModel(id: 'u1', name: name, email: email);
  }

  Future<List<CategoryModel>> getCategories() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return mockCategories;
  }

  Future<List<ProductModel>> getProducts() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return mockProducts;
  }

  Future<List<ProductModel>> getProductsByCategory(String categoryId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return mockProducts.where((p) => p.categoryId == categoryId).toList();
  }

  Future<ProductModel> getProductById(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return mockProducts.firstWhere((p) => p.id == id);
  }

  Future<OrderModel> placeOrder(OrderModel order) async {
    await Future.delayed(const Duration(seconds: 2));
    return order;
  }

  Future<List<OrderModel>> getOrders() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [];
  }
}
