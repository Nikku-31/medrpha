class CartItem {
  final String imageUrl;
  final String productName;
  final String status;
  final String available;
  int qty;

  CartItem({
    required this.imageUrl,
    required this.productName,
    required this.status,
    required this.available,
    this.qty = 1,
  });
}
