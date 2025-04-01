import 'package:flutter/material.dart';

class CustomfavAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CustomfavAppBar({required this.title});

  @override
  Size get preferredSize => Size.fromHeight(150); // ความสูงของ AppBar

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0XFFFEDB71), // สีพื้นหลัง
      elevation: 0,
      automaticallyImplyLeading: false, // ไม่ใช้ปุ่ม back อัตโนมัติ
      flexibleSpace: SafeArea(
        child: Stack(
          children: [
            // 🔽 รูปถุงกระดาษด้านล่าง
            Align(
              alignment: Alignment.bottomCenter,
              child: _buildPaperBagImage(),
            ),
            // 🔼 Row ด้านบน ← Categories 🔔
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // ← + Categories
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(width: 8),
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  // 🔔
                  IconButton(
                    icon: Icon(Icons.notifications),
                    onPressed: () {
                      // การกระทำเมื่อกด Bell
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
    );
  }

  // ภาพถุงกระดาษ
  Widget _buildPaperBagImage() {
    return Padding(
      padding: const EdgeInsets.only(left: 150.0, bottom: 0.5555),
      child: Center(
        child: Image.asset(
          'assets/images/ui/favorite_page.png',
          width: 200,
          height: 120,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
