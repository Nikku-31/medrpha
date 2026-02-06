import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../Model/AccountM/send_login_model.dart';


class SendLoginService {
  static const String _baseUrl =
      "https://retailer.medrpha.com/api/Account/send-login-otp";

  Future<SendLoginResponseModel> sendLoginOtp({
    required String mobileNumber,
  }) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"mobileNumber": mobileNumber}),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return SendLoginResponseModel.fromJson(data);
    } else {
      return SendLoginResponseModel(
        status: false,
        message: data["message"] ?? "Something went wrong",
      );
    }
  }
}
