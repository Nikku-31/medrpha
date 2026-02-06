import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("About us",
          style: GoogleFonts.poppins(
              color: Colors.white
          ),),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                AboutSection(

                  title: "What We Do",
                  text:
                  "Medrpha began its journey as a Digital Medical Hub, providing wholesale and retail access to medicines, healthcare products, and chemical supplies. Through our mobile platform and business operations, we aimed to simplify the medical supply chain and offer pharmacies, hospitals, and clinics quick access to affordable, genuine products.",
                ),
                SizedBox(height: 12),

                Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      "assets/medicine/img_1.png",
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 20),

                AboutSection(

                  title: "How We Operate",
                  text:
                  "Medrpha focused on digital distribution of pharmaceutical and chemical products.\n"
                      "We built a mobile app-based marketplace, available on the Google Play Store with over 2,000 downloads. Our operational model supported B2B clients such as chemists, hospitals, and small distributors. We offer bulk ordering, competitive pricing, and fast delivery.",
                ),

                SizedBox(height: 12),

                Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      "assets/medicine/img.png",
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SizedBox(height: 20),

                AboutSection(
                  title: "Market Position in India",
                  text:
                  "India's pharmaceutical sector is valued at over USD 50 billion by 2030\n"
                      "Medrpha is part of the new wave of digitally driven pharmaceutical suppliers catering to the evolving needs of the healthcare sector\n"
                      "While currently operating at a lean scale, Medrpha has positioned itself as a forward-thinking brand, aiming to bridge the gap between pharma manufacturing and last-mile delivery through digital innovation.",
                ),

                SizedBox(height: 12),

                AboutSection(

                  title: "Digital Identity",
                  text:
                  "Registered Trademark: Medrpha – Online Medical Hub (Class 35) CIN: U24290UP2021PTC157397 Incorporation Date: 27-Dec-2021 Company Type: Private, Non-Government, Limited by Shares Current Status: Active Registered Address: D‑43, Sector‑6, Noida, Gautam Buddha Nagar, Uttar Pradesh – 201301 Official Website: www.medrpha.com Email: admin@medrpha.com | info@medrpha.com Phone: +91‑8076813227",
                ),

                SizedBox(height: 20),
                AboutSection(

                  title: "Our Vision",
                  text:
                  "To become a trusted name in India’s pharmaceutical ecosystem  by leveraging digital tools, ensuring high-quality product supply, and offering exceptional B2B services with speed, affordability, and transparency.",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AboutSection extends StatelessWidget {
  final String title;
  final String text;

  const AboutSection({
    super.key,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// ✅ TITLE (NO ROW)
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 26, // 28 bhi rakh sakti ho
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
          softWrap: true,
        ),

        const SizedBox(height: 8),

        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 15,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}
