import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  HomeAppBar({required this.title});

  @override
  Size get preferredSize => Size.fromHeight(100); // เพิ่มความสูงของ AppBar

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFFFFD54F), // สีเหลืองที่ตรงกับในภาพ
      elevation: 0,
      automaticallyImplyLeading: false, // ไม่ใช้ปุ่ม back อัตโนมัติ
      flexibleSpace: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0), // เพิ่ม padding ด้านซ้าย
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start, // จัดตำแหน่งให้ข้อความไปทางซ้าย
            crossAxisAlignment: CrossAxisAlignment.center, // ขยับข้อความลงเล็กน้อย
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 32,
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
          bottomLeft: Radius.circular(40), // มุมโค้งที่ด้านล่าง
          bottomRight: Radius.circular(40),
        ),
      ),
    );
  }
}
