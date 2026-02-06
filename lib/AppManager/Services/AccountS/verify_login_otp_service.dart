import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../Model/AccountM/verify_login_otp_model.dart';

class VerifyLoginOtpService {
  Future<VerifyLoginOtpModel> verifyLoginOtp({
    required String mobileNumber,
    required String otp,
  }) async {
    final uri = Uri.parse(
      "https://retailer.medrpha.com/api/Account/verify-login-otp",
    );

    final requestBody = {
      "mobileNumber": mobileNumber,
      "otp": otp,
    };

    print(" VERIFY OTP API URI => $uri");
    print(" VERIFY OTP REQUEST => ${jsonEncode(requestBody)}");

    final response = await http.post(
      uri,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(requestBody),
    );

    // PRINT RESPONSE
    print(" VERIFY OTP STATUS CODE => ${response.statusCode}");
    print(" VERIFY OTP RESPONSE => ${response.body}");

    if (response.statusCode == 200) {
      return VerifyLoginOtpModel.fromJson(jsonDecode(response.body));
    } else {
      return VerifyLoginOtpModel(
        status: false,
        message: "Something went wrong (${response.statusCode})",
      );
    }
  }
}
