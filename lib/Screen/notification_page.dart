import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Colors.blue;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Notification",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: const Center(
        child: Text(
          "No notifications",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
