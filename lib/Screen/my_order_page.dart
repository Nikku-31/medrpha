import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../Provider/cart_provider.dart';

class MyOrderPage extends StatefulWidget {
  const MyOrderPage({super.key});

  @override
  State<MyOrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<MyOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "My Order",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: Consumer<CartProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [

              /// 🔍 SEARCH + FILTER (UNCHANGED)
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: "Search your order here",
                            prefixIcon: Icon(Icons.search,
                                color: Colors.grey),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 120,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: "Filters",
                          prefixIcon:
                          Icon(Icons.filter_list, color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ORDER LIST
              Expanded(
                child: provider.cartList.isEmpty
                    ? const Center(child: Text("No Orders Yet"))
                    : ListView.builder(
                  itemCount: provider.cartList.length,
                  itemBuilder: (context, index) {
                    final item = provider.cartList[index];

                    return Card(
                        color: Colors.white,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.shopping_bag),
                        ),
                        title: Text(item.productName),
                        subtitle: Text("Qty: ${item.qty}"),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}