// import 'package:flutter/material.dart';
// import 'package:jurysoft/model/DataModel.dart';
// import 'package:provider/provider.dart';
//
// class Cart extends ChangeNotifier {
//   List<Product> items = [];
//
//   void addToCart(Product product) {
//     items.add(product);
//     notifyListeners(); // Notify listeners when the cart is updated
//   }
//
//   int get itemCount => items.length;
// }


import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider extends ChangeNotifier {
  int cartItemCount = 0;

  CartProvider() {
    loadCartItemCount();
  }

  Future<void> loadCartItemCount() async {
    final prefs = await SharedPreferences.getInstance();
    cartItemCount = prefs.getInt('cartItemCount') ?? 0;
    notifyListeners();
  }

  Future<void> updateCartItemCount(int itemCount) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('cartItemCount', itemCount);
    cartItemCount = itemCount;
    notifyListeners();
  }
}
