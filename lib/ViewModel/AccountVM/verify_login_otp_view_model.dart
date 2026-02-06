import 'package:flutter/material.dart';
import '../../AppManager/Services/AccountS/verify_login_otp_service.dart';
import '../../Model/AccountM/verify_login_otp_model.dart';

class VerifyLoginOtpViewModel extends ChangeNotifier {
  final VerifyLoginOtpService _service = VerifyLoginOtpService();

  bool isLoading = false;
  VerifyLoginOtpModel? verifyOtpResponse;

  Future<VerifyLoginOtpModel> verifyOtp({
    required String mobileNumber,
    required String otp,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      verifyOtpResponse = await _service.verifyLoginOtp(
        mobileNumber: mobileNumber,
        otp: otp,
      );
      return verifyOtpResponse!;
    } catch (e) {
      return VerifyLoginOtpModel(
        status: false,
        message: "Error: $e",
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
