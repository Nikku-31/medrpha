import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medrpha/Screen/profile_page.dart';
import 'package:provider/provider.dart';
import '../Product_Categories/category_product.dart';
import '../Provider/cart_provider.dart';
import '../widgets/register_user.dart';

import 'cart_page.dart';

class HomePage extends StatefulWidget {
  final StringmobileNumber;
  final int selectedIndex;

  final dynamic mobileNumber;
  
  const HomePage({super.key, required this.mobileNumber, this.StringmobileNumber, required this.selectedIndex});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget homeScreen() {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            registerBanner(),

            buildVerticalCard(
              CupertinoIcons.person_add,
              "Create An Account",
              "Register using your mobile number, enter your name, shop name and pincode",
            ),
            buildVerticalCard(
              CupertinoIcons.check_mark_circled_solid,
              "Complete KYC",
              "Upload any one of shop's KYC documents like GSTIN or licence",
            ),
            buildVerticalCard(
              CupertinoIcons.shopping_cart,
              "Start Ordering Now",
              "Browse and order products for your shop from top sellers",
            ),

            const SizedBox(height: 16),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Categories",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildCategoryContainer(
                  'assets/products_img/ethical.png',
                  "ETHICAL",
                  const Color(0xffE8F5E9),
                  1,
                ),
                buildCategoryContainer(
                  'assets/products_img/generic.png',
                  "GENERIC",
                  const Color(0xffF3E5F5),
                  2,
                ),
                buildCategoryContainer(
                  'assets/products_img/surgical.png',
                  "SURGICAL",
                  const Color(0xffFFEBEE),
                  3,
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildCategoryContainer(
                  'assets/products_img/veterinary.png',
                  "VETERINARY",
                  const Color(0xffFFFDE7),
                  4,
                ),
                buildCategoryContainer(
                  'assets/products_img/ayurvedic.png',
                  "AYURVEDIC",
                  const Color(0xffE6F7FF),
                  5,
                ),
                buildCategoryContainer(
                  'assets/products_img/general.png',
                  "GENERAL",
                  const Color(0xffF3E5F5),
                  6,
                ),
              ],
            ),

            const SizedBox(height: 30),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Our Pharma Gallery",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 15),

            horizontalMoreCategoryList(),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget registerBanner() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xffdff3f8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xffdff3f8), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "MEDRPHA",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff00a9e0),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  "India's Genuine B2B Platform For Medicines",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "A WIDE VARIETY OF QUALITY\nHEALTHCARE PRODUCTS",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff00a9e0),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RegisterUser(mobileNumber: widget.mobileNumber,),
                      ),
                    );
                  },
                  child: const Text(
                    "Register Now",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            children: const [
              Image(
                image: AssetImage('assets/banner_img/banner_2.png'),
                height: 80,
                width: 80,
              ),
              SizedBox(height: 6),
            ],
          )
        ],
      ),
    );
  }

  Widget buildVerticalCard(IconData icon, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade50, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.blue.shade100,
            child: Icon(icon, color: Colors.blue, size: 26),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //  CATEGORY CARD WITH categoryId
  Widget buildCategoryContainer(
      String imgPath,
      String title,
      Color bgColor,
      int categoryId,
      ) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryProduct(
              title: title,
              categoryId: categoryId,
            ),
          ),
        );
      },
      child: Container(
        width: 110,
        height: 150,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: bgColor, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Image.asset(
              imgPath,
              height: 70,
              width: 70,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMoreCategoryContainer(String imgPath, String title) {
    return Container(
      width: 140,
      height: 150,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade50, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imgPath,
            height: 80,
            width: 80,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget horizontalMoreCategoryList() {
    List<Map<String, String>> items = [
      {
        "img": "assets/products/Alka-Seltzer Original Effervescent.jpg",
        "title": "Alka-Seltzer Original Effervescent"
      },
      {"img": "assets/products/Garden of Life RAW.jpg", "title": "Garden of Life RAW"},
      {
        "img": "assets/products/Herb Pharm Stone Breaker Compound.jpg",
        "title": "Herb Pharm Stone Breaker Compound"
      },
      {
        "img": "assets/products/Himalaya Herbal Healthcare Comfort.jpg",
        "title": "Himalaya Herbal Healthcare Comfort"
      },
      {"img": "assets/products/Hyland's Bioplasma Tablets.jpg", "title": "Hyland's Bioplasma Tablets"},
      {"img": "assets/products/Natrol Biotin 10000 MCG Tablets.jpg", "title": "Natrol Biotin 10000 MCG Tablets"},
      {
        "img": "assets/products/Nature's Way Umcka Original Alcohol Free.jpg",
        "title": "Nature's Way Umcka Original Alcohol Free"
      },
      {"img": "assets/products/Nature Made Vitamin.jpg", "title": "Nature Made Vitamin"},
    ];

    return SizedBox(
      height: 200,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (context, index) => const SizedBox(width: 20),
        itemBuilder: (context, index) {
          return buildMoreCategoryContainer(
            items[index]["img"]!,
            items[index]["title"]!,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_selectedIndex != 0) {
          setState(() {
            _selectedIndex = 0;
          });
          return false;
        }

        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(

        appBar:(_selectedIndex == 1 || _selectedIndex == 2)
            ? null
            : AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 60,
          backgroundColor: Colors.blue,

          title: Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white, width: 1),
            ),
            child: const TextField(
              decoration: InputDecoration(
                hintText: "Search...",
                prefixIcon: Icon(CupertinoIcons.search),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            IndexedStack(
              index: _selectedIndex,
              children: [
                homeScreen(),
                const CartPage(),
                const ProfilePage(mobileNumber: '',),
              ],
            ),

            // MINI CART BAR
            if (_selectedIndex == 0)
              Positioned(
                bottom: 10,
                left: 10,
                right: 10,
                child: Consumer<CartProvider>(
                  builder: (context, cart, child) {

                    if (cart.cartList.isEmpty) {
                      return const SizedBox();
                    }
                    int totalQty = cart.cartList.fold(
                      0,
                          (sum, item) => sum + item.qty,
                    );

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIndex = 1; // open cart page
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "$totalQty items added",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),

                            const Text(
                              "View Cart",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            splashFactory: NoSplash.splashFactory,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.blue,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 14,
            ),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home, size: 24),
                activeIcon: Icon(CupertinoIcons.home, size: 26),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.shopping_cart,  size: 24),
                activeIcon: Icon(CupertinoIcons.shopping_cart,  size: 26),
                label: "Cart",
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person, size: 24),
                activeIcon: Icon(CupertinoIcons.person, size: 26),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

