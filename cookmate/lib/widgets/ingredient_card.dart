import 'package:flutter/material.dart';
import '../models/ingredient_model.dart';
import 'package:cookmate/DatabaseHelperTest.dart'; 

class IngredientCard extends StatelessWidget {
  final IngredientModel ingredient;
  final VoidCallback onDelete;

  const IngredientCard({
    super.key,
    required this.ingredient,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 254,
      height: 128,
      margin: const EdgeInsets.only(
        right: 0,
        left: 10,
        bottom: 8,
      ), // เพิ่มการเว้นจากขอบซ้าย
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xffc3e090),
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25), // สีของเงา
            spreadRadius: 0, // ความกว้างของเงา
            blurRadius: 6, // ความเบลอของเงา
            offset: const Offset(0, 4), // การขยับเงาในแนวนอนและแนวตั้ง
          ),
        ],
      ),
      child: Row(
        children: [
          // รูปวัตถุดิบ
          Container(
            width: 100, // ขนาดของ Container เป็น 100x100
            height: 100, // ขนาดของ Container เป็น 100x100
            decoration: BoxDecoration(
              color: Colors.white, // เพิ่มสีขาวให้รอบๆ
              borderRadius: BorderRadius.circular(50), // ทำให้ขอบกลม
            ),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50), // ทำให้รูปกลม
                child: Image.asset(
                  ingredient.imagePath,
                  width: 80, // ขนาดของรูป 80x80
                  height: 80, // ขนาดของรูป 80x80
                  fit: BoxFit.cover, // รักษาสัดส่วนของรูป
                ),
              ),
            ),
          ),
          const SizedBox(width: 14), // ระยะห่างระหว่างรูปกับข้อมูล (20px)
          // ข้อมูลวัตถุดิบ
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment:
                  MainAxisAlignment.start, // ขยับให้เริ่มที่ด้านบน
              children: [
                // ชื่อวัตถุดิบ
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 0,
                    right: 0,
                  ), // ขยับขึ้นเล็กน้อย
                  child: Text(
                    ingredient.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: 'NotoSansThai',
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,  // เพิ่มเพื่อให้แสดง ...
                    maxLines: 1,  // ให้แสดงแค่บรรทัดเดียว
                  ),
                ),
                const SizedBox(height: 0), // ช่องว่างระหว่างชื่อและสถานะ
                // สถานะวัตถุดิบ
                Text(
                  ingredient.status, // แสดงสถานะ
                  style: TextStyle(
                    color: Color(0xFFE23D3D),
                    fontSize: 14,
                    fontFamily: 'NotoSansThai',
                    fontWeight: FontWeight.w500,
                  ),
                  softWrap: false, // ป้องกันการขึ้นบรรทัดใหม่
                  overflow: TextOverflow.visible, // ข้อความไม่หาย
                ),
              ],
            ),
          ),

          // ปุ่มลบ - ถังขยะ
          Align(
            alignment: Alignment.bottomCenter, // ทำให้ปุ่มอยู่ล่างสุด
            child: IconButton(
              onPressed: () async {
                await DatabaseHelperTest.clearIngredientDetails(
                  ingredientName: ingredient.name,
                );
                onDelete(); // ลบจาก UI หรือ refresh
              },
              // ลบวัตถุดิบจาก UI
              icon: const Icon(Icons.delete, color: Colors.red),
              iconSize: 34,
              padding: EdgeInsets.only(right: 20),
              constraints: const BoxConstraints(),
            ),
          ),
        ],
      ),
    );
  }
}
