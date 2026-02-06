import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  // Call Launcher
  static void launchCall(String number) async {
    final Uri callUri = Uri(scheme: 'tel', path: number);
    await launchUrl(callUri);
  }

  // Map Launcher
  static void launchMap() async {
    final Uri mapUri = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=Noida+Sector+6+India",
    );
    await launchUrl(mapUri, mode: LaunchMode.externalApplication);
  }

  // Email Launcher
  static void launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'info@medrpha.com',
    );
    await launchUrl(emailUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          "Contact us",
          style: GoogleFonts.poppins(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 25),

              /// 🔹 Card 1
              buildCard([
                infoRow(
                  Icons.location_on,
                  "MEDRPHA Noida Sec-6 India",
                  onTap: launchMap,
                ),
                const SizedBox(height: 40),
                infoRow(
                  Icons.phone,
                  "Call Us:\n+91-8076813227",
                  onTap: () => launchCall("8076813227"),
                ),
              ]),

              const SizedBox(height: 20),

              /// 🔹 Card 2
              buildCard([
                infoRow(
                  Icons.phone_forwarded,
                  "Toll Free:\n0120-5200262",
                  onTap: () => launchCall("01205200262"),
                ),
                const SizedBox(height: 30),
                infoRow(
                  Icons.mail,
                  "Email Us:\nInfo@Medrpha.Com",
                  onTap: launchEmail,
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.blue, Colors.lightBlue],
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextButton.icon(
                    onPressed: launchEmail,
                    icon: const Icon(Icons.mail, color: Colors.white),
                    label: Text(
                      "Email Us",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 Card UI
  Widget buildCard(List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.2),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  /// 🔹 Info Row with Blue Arrow
  Widget infoRow(
      IconData icon,
      String text, {
        VoidCallback? onTap,
      }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blue, size: 26),
          const SizedBox(width: 15),

          /// Text
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          const Icon(
            CupertinoIcons.chevron_right,
            color: Colors.blue,
            size: 20,
          ),
        ],
      ),
    );
  }
}
