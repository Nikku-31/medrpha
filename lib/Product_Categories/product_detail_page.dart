import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/cart_provider.dart';

class ProductDetailPage extends StatelessWidget {
  final String productName;
  final String imageUrl;
  final String available;
  final String status;

  const ProductDetailPage({
    super.key,
    required this.productName,
    required this.imageUrl,
    required this.available,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      /// AppBar with blue background and white text
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Product Detail",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: Stack(
        children: [
          /// Scrollable content
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 100), // space for bottom button
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(height: 10), // extra gap after appbar

                /// Product Image
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  child: Image.network(
                    imageUrl,
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: double.infinity,
                        height: 300,
                        color: Colors.grey.shade200,
                        child: const Icon(Icons.image_not_supported, size: 50),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                /// Detail Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// Shopping Tag
                      Row(
                        children: const [
                          Icon(Icons.shopping_bag, size: 16, color: Colors.blue),
                          SizedBox(width: 5),
                          Text(
                            "Shopping",
                            style: TextStyle(
                                color: Colors.blue, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      /// Product Name
                      Text(
                        productName,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(height: 6),

                      //Category / company name
                      Text(
                        "Medicine • Allegra",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Row(
                        children: [
                          const Text("By: ", style: TextStyle(color: Colors.grey)),
                          Text(
                            available,
                            style: const TextStyle(
                                color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      //MRP CUT Price
                      const Text(
                        "₹ 2,499",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),

                      const SizedBox(height: 4),

                      /// SELLING PRICE + DISCOUNT
                      ///
                      Row(
                        children: const [
                          Text(
                            "₹ 1,999",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "20% OFF",
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 150),
                    ]
                  ),
                ),
              ],
            ),
          ),

          /// Bottom Add / Qty Button
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Consumer<CartProvider>(
              builder: (context, cartProvider, child) {
                final cartItemIndex = cartProvider.cartList
                    .indexWhere((item) => item.productName == productName);
                final bool isInCart = cartItemIndex != -1;
                final int qty =
                isInCart ? cartProvider.cartList[cartItemIndex].qty : 0;

                return isInCart
                    ? Container(
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove, color: Colors.blue),
                        onPressed: () {
                          if (qty > 1) {
                            cartProvider.decreaseQty(productName);
                          } else {
                            cartProvider.removeFromCartByName(productName);
                          }
                        },
                      ),
                      Text(
                        '$qty',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add, color: Colors.blue),
                        onPressed: () {
                          cartProvider.increaseQty(productName);
                        },
                      ),
                    ],
                  ),
                )
                    : SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      cartProvider.addToCart(productName, imageUrl, available);
                    },

                    label: const Text(
                      "Add to Cart",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
