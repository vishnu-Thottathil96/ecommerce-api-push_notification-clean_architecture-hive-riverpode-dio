import 'package:aqua_assignment/features/cart/data/models/cart_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

class CartStateNotifier extends StateNotifier<List<CartElement>> {
  CartStateNotifier() : super([]);

  // Function to initialize the Hive box
  Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(CartElementAdapter());
    await Hive.openBox<CartElement>('cartBox');
    state = Hive.box<CartElement>('cartBox').values.toList();
  }

  // Function to add an item to the cart
  void addItem(CartElement item) {
    final box = Hive.box<CartElement>('cartBox');
    box.put(item.id, item);
    state = box.values.toList();
  }

  // Function to remove an item from the cart
  void removeItem(CartElement item) {
    final box = Hive.box<CartElement>('cartBox');
    box.delete(item.id);
    state = box.values.toList();
  }

  // Function to update an item in the cart
  void updateItem(CartElement item, bool isAdd) {
    final box = Hive.box<CartElement>('cartBox');
    if (isAdd) {
      item.count += 1;
    } else {
      if (item.count > 1) {
        item.count -= 1;
      }
    }
    box.put(item.id, item);
    state = box.values.toList();
  }
}

// The provider for the CartStateNotifier
final cartStateNotifierProvider =
    StateNotifierProvider<CartStateNotifier, List<CartElement>>((ref) {
  final cartStateNotifier = CartStateNotifier();
  cartStateNotifier.initHive();
  return cartStateNotifier;
});
