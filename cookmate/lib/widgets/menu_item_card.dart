import 'package:flutter/material.dart';

class MenuItemCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final bool isFavorited; // ตรวจสอบว่าเป็นเมนูโปรด
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle; // เพิ่มฟังก์ชันสำหรับกด/ไม่กดใจ

  const MenuItemCard({
    super.key,
    required this.imagePath,
    required this.name,
    this.isFavorited = false,
    required this.onTap,
    required this.onFavoriteToggle, // รับฟังก์ชันใหม่
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 246,
        height: 120,
        margin: const EdgeInsets.only(right: 4, bottom: 8),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              spreadRadius: 0,
              blurRadius: 4,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // รูปเมนู
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    imagePath,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),

            // ข้อมูลเมนู
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: 'NotoSansThai',
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ไอคอนหัวใจ
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8, right: 8),
                child: GestureDetector(
                  onTap: onFavoriteToggle, // เรียกฟังก์ชันเมื่อกดไอคอน
                  child: Image.asset(
                    isFavorited
                        ? 'assets/images/icon/heart_sl.png' // ใช้ภาพหัวใจที่ถูกเลือก
                        : 'assets/images/icon/heart.png', // ใช้ภาพหัวใจที่ไม่ได้เลือก
                    width: 22,
                    height: 22,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
