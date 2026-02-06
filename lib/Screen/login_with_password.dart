import 'dart:math';
import 'package:flutter/material.dart';
import 'package:medrpha/Screen/home_page.dart';

class LoginWithPassword extends StatefulWidget {
  const LoginWithPassword({super.key});

  @override
  State<LoginWithPassword> createState() => _LoginWithPasswordState();
}

class _LoginWithPasswordState extends State<LoginWithPassword> {
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String generateOtp() {
    final random = Random();
    return (100000 + random.nextInt(900000)).toString();
  }

  void login() {
    String mobile = mobileController.text.trim();
    String password = passwordController.text.trim();

    if (mobile.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter valid mobile number")),
      );
      return;
    }

    if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter password")),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage(selectedIndex: 0, mobileNumber: null,)),
    );

    String otp = generateOtp();
  }

  @override
  void dispose() {
    mobileController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
        child: Padding(
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

              const SizedBox(height: 10),

              const Text(
                "Login",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              const Text(
                "Enter your mobile number and password",
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

              TextField(
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
              ),

              const SizedBox(height: 20),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Password",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),

              const SizedBox(height: 8),

              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Enter Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Login",
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
