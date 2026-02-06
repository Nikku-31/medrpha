import 'package:flutter/material.dart';

import '../../AppManager/Services/CategoryS/category_detail_service.dart';
import '../../Model/CategoryM/category_detail_model.dart';

class CategoryDetailViewModel extends ChangeNotifier {
  final CategoryDetailService _service = CategoryDetailService();

  bool isLoading = false;
  String errorMessage = "";

  List<CategoryDetailProductModel> products = [];

  Future<void> fetchCategoryDetail(int categoryId) async {
    try {
      isLoading = true;
      errorMessage = "";
      notifyListeners();

      final response = await _service.getCategoryDetail(categoryId);

      if (response.success == true) {
        products = response.data;
      } else {
        products = [];
        errorMessage = response.message ?? "Something went wrong!";
      }
    } catch (e) {
      products = [];
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
