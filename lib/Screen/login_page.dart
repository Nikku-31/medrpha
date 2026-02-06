import 'package:flutter/material.dart';
import 'login_with_password.dart';
import 'otp_verification.dart';

class OtpLoginScreen extends StatefulWidget {
  const OtpLoginScreen({super.key});

  @override
  State<OtpLoginScreen> createState() => _OtpLoginScreenState();
}

class _OtpLoginScreenState extends State<OtpLoginScreen> {
  final TextEditingController mobileController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),

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
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Login With Password..",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  OtpVerification(
                              mobileNumber: mobileController.text.trim(),
                              otp: '',),
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
                      "Get Verification Code (OTP)",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

