import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  HomeAppBar({required this.title});

  @override
  Size get preferredSize => Size.fromHeight(64); // ความสูงของ AppBar

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFFFFD54F), // สีเหลืองที่ตรงกับในภาพ
      elevation: 0,
      automaticallyImplyLeading: false, // ไม่ใช้ปุ่ม back อัตโนมัติ
      flexibleSpace: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 120.0, vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start, // จัดตำแหน่งให้ซ้าย
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // ตัวอักษรเป็นสีดำ
                ),
              ),
            ],
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30), // มุมโค้งที่ด้านล่าง
          bottomRight: Radius.circular(30),
        ),
      ),
    );
  }
}
