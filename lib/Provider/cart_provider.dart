import 'package:flutter/material.dart';

/// Model class for a Cart Item
class CartItem {
  final String productName;
  final String imageUrl;
  final String available;
  int qty; // Quantity of the product

  CartItem({
    required this.productName,
    required this.imageUrl,
    required this.available,
    this.qty = 1,
  });
}

/// Cart Provider using ChangeNotifier
class CartProvider with ChangeNotifier {
  // List to store cart items
  List<CartItem> cartList = [];

  /// Add an item to cart
  void addToCart(String productName, String imageUrl, String available) {
    int index = cartList.indexWhere((item) => item.productName == productName);
    if (index != -1) {
      // If already in cart, increase quantity
      cartList[index].qty += 1;
    } else {
      // If not in cart, add new item
      cartList.add(CartItem(
        productName: productName,
        imageUrl: imageUrl,
        available: available,
        qty: 1,
      ));
    }
    notifyListeners();
  }

  /// Remove an item from cart by index
  void removeFromCart(int index) {
    if (index >= 0 && index < cartList.length) {
      cartList.removeAt(index);
      notifyListeners();
    }
  }

  /// Remove an item from cart by product name
  void removeFromCartByName(String productName) {
    cartList.removeWhere((item) => item.productName == productName);
    notifyListeners();
  }

  /// Increase quantity of an item
  void increaseQty(String productName) {
    int index = cartList.indexWhere((item) => item.productName == productName);
    if (index != -1) {
      cartList[index].qty += 1;
      notifyListeners();
    }
  }

  /// Decrease quantity of an item
  /// If qty reaches 0, remove the item
  void decreaseQty(String productName) {
    int index = cartList.indexWhere((item) => item.productName == productName);
    if (index != -1) {
      if (cartList[index].qty > 1) {
        cartList[index].qty -= 1;
      } else {
        cartList.removeAt(index);
      }
      notifyListeners();
    }
  }

  /// Clear entire cart
  void clearCart() {
    cartList.clear();
    notifyListeners();
  }

  /// Get total number of items in cart
  int get totalItems {
    int total = 0;
    for (var item in cartList) {
      total += item.qty;
    }
    return total;
  }
}
