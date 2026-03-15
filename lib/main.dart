import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:grocergo/utils/themes/theme.dart';
import 'package:grocergo/data/models/product_model.dart';
import 'package:grocergo/data/models/cart_item_model.dart';
import 'package:grocergo/data/models/category_model.dart';
import 'package:grocergo/presentation/providers/auth_provider.dart';
import 'package:grocergo/presentation/providers/product_provider.dart';
import 'package:grocergo/presentation/providers/cart_provider.dart';
import 'package:grocergo/presentation/providers/order_provider.dart';
import 'package:grocergo/presentation/providers/address_provider.dart';
import 'package:grocergo/presentation/screens/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  
  // Register Adapters
  Hive.registerAdapter(ProductModelAdapter());
  Hive.registerAdapter(CartItemModelAdapter());
  Hive.registerAdapter(CategoryModelAdapter());
  
  await Hive.openBox('settings');
  await Hive.openBox('cart');
  await Hive.openBox('addresses');
  
  runApp(const GrocerGoApp());
}

class GrocerGoApp extends StatelessWidget {
  const GrocerGoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => AddressProvider()),
      ],
      child: MaterialApp(
        title: 'GrocerGo',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
