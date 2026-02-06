import 'package:flutter/material.dart';
import '../../AppManager/Services/AccountS/send_login_service.dart';
import '../../Model/AccountM/send_login_model.dart';



class SendLoginViewModel extends ChangeNotifier {
  final SendLoginService _service = SendLoginService();

  bool isLoading = false;
  String errorMessage = "";
  SendLoginResponseModel? responseModel;

  Future<bool> sendOtp(String mobileNumber) async {
    try {
      isLoading = true;
      errorMessage = "";
      notifyListeners();

      responseModel = await _service.sendLoginOtp(mobileNumber: mobileNumber);

      if (responseModel?.status == true) {
        return true;
      } else {
        errorMessage = responseModel?.message ?? "OTP failed";
        return false;
      }
    } catch (e) {
      errorMessage = "Error: $e";
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
