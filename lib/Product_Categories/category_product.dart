import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../ViewModel/CategoryVM/category_detail_view_model.dart';
import '../widgets/category_detail_card.dart';

class CategoryProduct extends StatefulWidget {
  final String title;
  final int categoryId;

  const CategoryProduct({super.key, required this.title, required this.categoryId});

  @override
  State<CategoryProduct> createState() => _CategoryProductState();
}

class _CategoryProductState extends State<CategoryProduct> {
  @override
  void initState() {
    super.initState();

    // Fetch category details when widget is initialized
    Future.microtask(() {
      context.read<CategoryDetailViewModel>().fetchCategoryDetail(widget.categoryId);
    });
  }

  // Get image URL safely
  String _getImageUrl(String? productImg) {
    if (productImg == null || productImg.isEmpty) {
      return "https://via.placeholder.com/150";
    }
    if (productImg.startsWith("http")) return productImg;
    return "https://yourdomain.com/uploads/$productImg";
  }

  // Clean description to remove cut icon or unwanted characters
  String _cleanDescription(String? description) {
    if (description == null) return "";
    return description.replaceAll('✂️', '').trim(); // remove cut icon
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Consumer<CategoryDetailViewModel>(
        builder: (context, vm, child) {
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (vm.errorMessage.isNotEmpty) {
            return Center(
              child: Text(
                vm.errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (vm.products.isEmpty) {
            return const Center(child: Text("No Products Found"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: vm.products.length,
            itemBuilder: (context, index) {
              final item = vm.products[index];

              return CategoryDetailCard(
                imageUrl: _getImageUrl(item.productImg),
                productsname: item.productName ?? "",
                status: _cleanDescription(item.description), // cleaned description
                available: item.categoryName ?? "",
              );
            },
          );
        },
      ),
    );
  }
}
