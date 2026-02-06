import 'package:flutter/material.dart';
import 'package:medrpha/Screen/login_with_password.dart';
import 'package:provider/provider.dart';
import '../../Screen/otp_verification.dart';
import '../../ViewModel/AccountVM/send_login_view_model.dart';


class SendLoginView extends StatefulWidget {
  const SendLoginView({super.key});

  @override
  State<SendLoginView> createState() => _SendLoginViewState();
}

class _SendLoginViewState extends State<SendLoginView> {
  final TextEditingController mobileController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ChangeNotifierProvider(
      create: (_) => SendLoginViewModel(),
      child: Consumer<SendLoginViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(),
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(size.width * 0.05),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: size.height * 0.02),

                      Image.asset(
                        'assets/images/img.png',
                        height: 130,
                        width: 130,
                      ),

                      const SizedBox(height: 25),

                      const Text(
                        "Enter Mobile Number",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        "Enter your 10-digit mobile number to receive the verification code.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),

                      const SizedBox(height: 30),

                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Mobile Number",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),

                      const SizedBox(height: 8),

                      TextFormField(
                        controller: mobileController,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        decoration: InputDecoration(
                          hintText: "Enter Mobile Number",
                          counterText: "",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter mobile number";
                          } else if (value.length != 10) {
                            return "Please enter 10 digit mobile number";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 30),

                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginWithPassword(
                                    // mobileNumber: mobileController.text.trim(),
                                    // otp: vm?.responseModel?.otp ?? "",
                                  ),
                                ),
                              );

                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            "Login With Password",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: vm.isLoading
                              ? null
                              : () async {
                            if (_formKey.currentState!.validate()) {
                              final ok = await vm.sendOtp(
                                mobileController.text.trim(),
                              );

                              if (ok) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      vm.responseModel?.message ??
                                          "OTP Sent",
                                    ),
                                  ),
                                );

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        OtpVerification(
                                          mobileNumber:
                                          mobileController.text.trim(),
                                          otp: vm.responseModel?.otp ?? "",
                                        ),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      vm.errorMessage.isNotEmpty
                                          ? vm.errorMessage
                                          : "OTP failed",
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: vm!.isLoading
                              ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                              : const Text(
                            "Get Verification Code (OTP)",
                            style: TextStyle(
                                fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

extension on Object? {
  get responseModel => null;

  bool? get isLoading => null;
}
