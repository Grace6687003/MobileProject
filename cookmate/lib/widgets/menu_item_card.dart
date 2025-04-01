import 'package:flutter/material.dart';

class MenuItemCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final bool isFavorited; // ตรวจสอบว่าเป็นเมนูโปรด
  final VoidCallback onTap;

  const MenuItemCard({
    super.key,
    required this.imagePath,
    required this.name,
    this.isFavorited = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 246,
        height: 120, // ความสูงเพิ่มจากเดิมเพื่อรองรับคำอธิบาย
        margin: const EdgeInsets.only(right: 16, bottom: 8),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25), // สีของเงา
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
                borderRadius: BorderRadius.circular(15), // ทำให้รูปมีมุมโค้ง
              ),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15), // ทำให้รูปกลม
                  child: Image.asset(
                    imagePath,
                    width: 100, // ขนาดที่เหมาะสม
                    height: 100, // ขนาดที่เหมาะสม
                    fit: BoxFit.cover, // รักษาสัดส่วนของรูป
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14), // ระยะห่างระหว่างรูปและข้อมูล

            // ข้อมูลเมนู
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // เพิ่มการขยับชื่อเมนูลงมาด้วยการเพิ่ม Padding
                  Padding(
                    padding: const EdgeInsets.only(top: 10), // ขยับชื่อลง
                    child: Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: 'NotoSansThai',
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4), // ช่องว่างระหว่างชื่อและคำอธิบาย
                ],
              ),
            ),

            // ไอคอนหัวใจ (ถ้าเป็นเมนูโปรด)
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8, right: 8), // เพิ่ม Padding
                child: Image.asset(
                  isFavorited
                      ? 'assets/images/icon/heart_sl.png' // ใช้ภาพหัวใจที่ถูกเลือก
                      : 'assets/images/icon/heart.png', // ใช้ภาพหัวใจที่ไม่ได้เลือก
                  width: 22,
                  height: 22,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
