import 'package:flutter/material.dart';
import '../widgets/bottom_navbar.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      bottomNavigationBar: BottomNavBar(), // ✅ BottomNavBar แบบเต็มระบบ
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              child: Image.asset(
                'assets/Menu/REC014.jpg',
                width: double.infinity,
                height: 380,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.only(left: 22.0),
              child: Text(
                'ไข่ตุ๋น',
                style: TextStyle(
                  fontFamily: 'NotoSansThai',
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 8),
            _buildSectionHeader('วัตถุดิบ', 0xFFC3E090),
            _buildIngredients(),
            const SizedBox(height: 16),
            _buildSectionHeader('วิธีทำ', 0xFFFFDB71),
            _buildInstructions(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, int colorHex) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 22),
        decoration: BoxDecoration(
          color: Color(colorHex),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontFamily: 'NotoSansThai',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildIngredients() {
    const ingredients = ['ไข่ไก่', 'หมูสับ', 'ต้นหอมซอย'];
    return Padding(
      padding: const EdgeInsets.only(left: 40),
      child: Column(
        children: ingredients
            .map(
              (item) => ListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                leading: Checkbox(
                  value: false,
                  onChanged: (value) {},
                ),
                title: Text(
                  item,
                  style: const TextStyle(
                    fontFamily: 'NotoSansThai',
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildInstructions() {
    return Padding(
      padding: const EdgeInsets.only(left: 40),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: const Text(
          '1.ตอกไข่ไก่ใส่ชาม ตีเล็กน้อย จากนั้นใส่หมูสับ นมสด ซอสปรุงรส และน้ำเปล่า คนส่วนผสมทั้งหมดให้เข้ากัน แล้วเทใส่ถ้วยที่เตรียมจะนึ่ง\n'
          '2.เตรียมหม้อนึ่ง ใส่น้ำและตั้งไฟจนเดือด นำถ้วยไข่ที่ผสมแล้ววางในหม้อนึ่ง ปิดฝา นึ่งประมาณ 10-15 นาที\n'
          '3.เปิดฝา ใช้ตะเกียบจิ้มลงในไข่ หากไม่มีส่วนผสมติดตะเกียบแสดงว่าสุกแล้ว ยกออกจากหม้อนึ่ง โรยด้วยต้นหอมซอย พร้อมเสิร์ฟ',
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'NotoSansThai',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
