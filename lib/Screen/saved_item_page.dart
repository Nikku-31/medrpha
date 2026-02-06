import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/wishlist_provider.dart';
import '../Provider/cart_provider.dart';

class SavedItemsPage extends StatelessWidget {
  const SavedItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Colors.blue;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Saved Items",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Consumer<WishlistProvider>(
        builder: (context, wishlistProvider, _) {
          if (wishlistProvider.wishlist.isEmpty) {
            return const Center(child: Text("No saved items"));
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: wishlistProvider.wishlist.length,
            itemBuilder: (context, index) {
              final item = wishlistProvider.wishlist[index];

              return Container(
                margin:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// IMAGE
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        item.imageUrl,
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          width: 70,
                          height: 70,
                          color: Colors.grey.shade200,
                          child: const Icon(Icons.image, size: 22),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    /// TEXT
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.productName,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.status,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),


                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: const Icon(Icons.delete,
                              color: Colors.grey),
                          onPressed: () {
                            wishlistProvider.toggleWishlist(item);
                          },
                        ),

                        const SizedBox(height: 6),

                        SizedBox(
                          height: 34,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              final cartProvider =
                              context.read<CartProvider>();

                              /// ADD TO CART
                              cartProvider.addToCart(
                                item.productName,
                                item.imageUrl,
                                item.status,
                              );

                              /// REMOVE FROM SAVED
                              wishlistProvider.toggleWishlist(item);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                  Text("Item moved to cart"),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            },
                            child: const Text(
                              "Move to Cart",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
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
