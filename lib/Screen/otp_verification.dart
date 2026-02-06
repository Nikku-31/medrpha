import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:medrpha/Screen/home_page.dart';
import '../AppManager/Services/AccountS/send_login_service.dart';

class OtpVerification extends StatefulWidget {
  final String mobileNumber;
  final String otp;

  const OtpVerification({
    super.key,
    required this.mobileNumber,
    required this.otp,
  });

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  final otp1Controller = TextEditingController();
  final otp2Controller = TextEditingController();
  final otp3Controller = TextEditingController();
  final otp4Controller = TextEditingController();

  final otp1Focus = FocusNode();
  final otp2Focus = FocusNode();
  final otp3Focus = FocusNode();
  final otp4Focus = FocusNode();

  bool isLoading = false;
  String apiOtp = "";

  @override
  void initState() {
    super.initState();

    apiOtp = widget.otp;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("OTP Sent Successfully\nOTP is : $apiOtp")),
      );
    });
  }

  Future<void> resendOtp() async {
    try {
      setState(() => isLoading = true);

      final service = SendLoginService();
      final response =
      await service.sendLoginOtp(mobileNumber: widget.mobileNumber);

      if (response.status == true) {
        apiOtp = response.otp ?? "";

        // clear old otp boxes
        otp1Controller.clear();
        otp2Controller.clear();
        otp3Controller.clear();
        otp4Controller.clear();


        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("New OTP is : $apiOtp")),
        );
      } else {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.message)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> verifyOtp() async {
    String enteredOtp = otp1Controller.text +
        otp2Controller.text +
        otp3Controller.text +
        otp4Controller.text;

    if (enteredOtp.length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter valid 4 digit OTP")),
      );
      return;
    }

    if (enteredOtp != apiOtp) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid OTP")),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("OTP Verified Successfully")),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) =>  HomePage (mobileNumber: widget.mobileNumber, selectedIndex: 0,)),
    );
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
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                      text: isLoading ? "Sending..." : "Resend",
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = isLoading ? null : resendOtp,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: isLoading ? null : verifyOtp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: isLoading
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
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
