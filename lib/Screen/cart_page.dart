import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Scaffold background white
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "My Cart",
          style: TextStyle(color: Colors.white), // AppBar title color white
        ),
        iconTheme: const IconThemeData(color: Colors.white), // Back button white
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          if (cartProvider.cartList.isEmpty) {
            return const Center(
              child: Text(
                "Cart is Empty",
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: cartProvider.cartList.length,
            itemBuilder: (context, index) {
              final item = cartProvider.cartList[index];

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Left Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        item.imageUrl,
                        height: 70,
                        width: 70,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 70,
                            width: 70,
                            color: Colors.grey.shade200,
                            child: const Icon(Icons.image_not_supported),
                          );
                        },
                      ),
                    ),

                    const SizedBox(width: 12),

                    // Middle Content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.productName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Qty: ${item.qty}",
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Right Button
                    item.qty == 1
                        ? SizedBox(
                      height: 36,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.blue),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          cartProvider.removeFromCart(index);
                        },
                        child: const Text(
                          "Remove",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                        : Container(
                      height: 36,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove, color: Colors.blue),
                            onPressed: () {
                              cartProvider.decreaseQty(item.productName);
                            },
                          ),
                          Text(
                            '${item.qty}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add, color: Colors.blue),
                            onPressed: () {
                              cartProvider.increaseQty(item.productName);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
