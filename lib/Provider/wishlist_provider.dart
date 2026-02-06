import 'package:flutter/material.dart';

class WishlistItem {
  final String productName;
  final String imageUrl;
  final String available;
  final String status;

  WishlistItem({
    required this.productName,
    required this.imageUrl,
    required this.available,
    required this.status,
  });
}

class WishlistProvider extends ChangeNotifier {
  final List<WishlistItem> _wishlist = [];

  List<WishlistItem> get wishlist => _wishlist;

  bool isSaved(String productName) {
    return _wishlist.any((item) => item.productName == productName);
  }

  void toggleWishlist(WishlistItem item) {
    final index =
    _wishlist.indexWhere((e) => e.productName == item.productName);

    if (index == -1) {
      _wishlist.add(item);
    } else {
      _wishlist.removeAt(index);
    }
    notifyListeners();
  }
}
