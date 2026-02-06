import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../Model/CategoryM/category_detail_model.dart';

class CategoryDetailService {
  Future<CategoryDetailResponseModel> getCategoryDetail(int categoryId) async {
    final Uri uri = Uri.parse(
      "https://retailer.medrpha.com/api/MasterApi/GetByCategory/$categoryId",
    );

    // ✅ Print URI + Request
    print("✅ CATEGORY DETAIL API CALL");
    print("➡️ URI: $uri");
    print("➡️ METHOD: GET");
    print("➡️ HEADERS: {'Content-Type': 'application/json'}");

    final response = await http.get(
      uri,
      headers: {"Content-Type": "application/json"},
    );

    // ✅ Print Response
    print("⬅️ STATUS CODE: ${response.statusCode}");
    print("⬅️ RESPONSE BODY: ${response.body}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return CategoryDetailResponseModel.fromJson(jsonData);
    } else {
      throw Exception("Failed to load category detail: ${response.statusCode}");
    }
  }
}
