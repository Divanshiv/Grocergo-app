import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static const String cartBoxName = 'cart';
  static const String userBoxName = 'user_profile';
  static const String addressBoxName = 'addresses';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(cartBoxName);
    await Hive.openBox(userBoxName);
    await Hive.openBox(addressBoxName);
  }

  static Box get cartBox => Hive.box(cartBoxName);
  static Box get userBox => Hive.box(userBoxName);
  static Box get addressBox => Hive.box(addressBoxName);
}
