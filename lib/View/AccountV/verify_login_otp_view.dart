import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:medrpha/Screen/home_page.dart';
import 'package:provider/provider.dart';
import '../../AppManager/Services/AccountS/send_login_service.dart';
import '../../ViewModel/AccountVM/verify_login_otp_view_model.dart';



class VerifyLoginOtpView extends StatefulWidget {
  final String mobileNumber;

  const VerifyLoginOtpView({
    super.key,
    required this.mobileNumber,
  });

  @override
  State<VerifyLoginOtpView> createState() => _VerifyLoginOtpViewState();
}

class _VerifyLoginOtpViewState extends State<VerifyLoginOtpView> {
  final otp1Controller = TextEditingController();
  final otp2Controller = TextEditingController();
  final otp3Controller = TextEditingController();
  final otp4Controller = TextEditingController();

  final otp1Focus = FocusNode();
  final otp2Focus = FocusNode();
  final otp3Focus = FocusNode();
  final otp4Focus = FocusNode();

  bool isResending = false;

  String get enteredOtp =>
      otp1Controller.text +
          otp2Controller.text +
          otp3Controller.text +
          otp4Controller.text;

  Future<void> resendOtp() async {
    try {
      setState(() => isResending = true);

      final service = SendLoginService();
      final response =
      await service.sendLoginOtp(mobileNumber: widget.mobileNumber);

      if (response.status == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.message)),
        );

        otp1Controller.clear();
        otp2Controller.clear();
        otp3Controller.clear();
        otp4Controller.clear();

        FocusScope.of(context).requestFocus(otp1Focus);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.message)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      setState(() => isResending = false);
    }
  }

  Future<void> verifyOtpApi() async {
    if (enteredOtp.length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter valid 4 digit OTP")),
      );
      return;
    }

    final vm = context.read<VerifyLoginOtpViewModel>();

    final response = await vm.verifyOtp(
      mobileNumber: widget.mobileNumber,
      otp: enteredOtp,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(response.message)),
    );

    if (response.status == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(selectedIndex: 0, mobileNumber: null,),
        ),
      );
    }
  }

  Widget otpBox({
    required TextEditingController controller,
    required FocusNode focusNode,
  }) {
    return SizedBox(
      width: 45,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: "",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.blue.shade200,
              width: 2,
            ),
          ),
        ),
        onChanged: (value) {
          if (value.length == 1) {
            if (focusNode == otp1Focus) {
              FocusScope.of(context).requestFocus(otp2Focus);
            } else if (focusNode == otp2Focus) {
              FocusScope.of(context).requestFocus(otp3Focus);
            } else if (focusNode == otp3Focus) {
              FocusScope.of(context).requestFocus(otp4Focus);
            } else {
              FocusScope.of(context).unfocus();
            }
          }

          if (value.isEmpty) {
            if (focusNode == otp2Focus) {
              FocusScope.of(context).requestFocus(otp1Focus);
            } else if (focusNode == otp3Focus) {
              FocusScope.of(context).requestFocus(otp2Focus);
            } else if (focusNode == otp4Focus) {
              FocusScope.of(context).requestFocus(otp3Focus);
            }
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    otp1Controller.dispose();
    otp2Controller.dispose();
    otp3Controller.dispose();
    otp4Controller.dispose();

    otp1Focus.dispose();
    otp2Focus.dispose();
    otp3Focus.dispose();
    otp4Focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ChangeNotifierProvider(
      create: (_) => VerifyLoginOtpViewModel(),
      child: Consumer<VerifyLoginOtpViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text("Verification"),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(size.width * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: size.height * 0.02),

                    Image.asset(
                      'assets/images/img.png',
                      fit: BoxFit.contain,
                      height: 130,
                      width: 130,
                    ),

                    const SizedBox(height: 25),

                    const Text(
                      "Mobile Phone Verification",
                      style:
                      TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "Please enter the 4-digit verification code sent to ${widget.mobileNumber}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 30),

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Enter OTP",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),

                    const SizedBox(height: 8),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        otpBox(controller: otp1Controller, focusNode: otp1Focus),
                        const SizedBox(width: 10),
                        otpBox(controller: otp2Controller, focusNode: otp2Focus),
                        const SizedBox(width: 10),
                        otpBox(controller: otp3Controller, focusNode: otp3Focus),
                        const SizedBox(width: 10),
                        otpBox(controller: otp4Controller, focusNode: otp4Focus),
                      ],
                    ),

                    const SizedBox(height: 20),

                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "Didn't receive the code? ",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: isResending ? "Sending..." : "Resend",
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = isResending ? null : resendOtp,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: (vm.isLoading || isResending)
                            ? null
                            : verifyOtpApi,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: vm.isLoading
                            ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                            : const Text(
                          "Submit",
                          style: TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
