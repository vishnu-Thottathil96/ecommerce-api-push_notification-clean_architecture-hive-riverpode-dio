import 'package:aqua_assignment/features/cart/data/models/cart_item.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class CartService {
  Future<void> initHive() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(CartElementAdapter().typeId)) {
      Hive.registerAdapter(CartElementAdapter());
    }

    await Hive.openBox<CartElement>('cartBox');
  }
}
