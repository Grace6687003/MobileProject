// class MenuFromIngredientsModel {
//   final String name;
//   final String imagePath;
//   final bool isFavorited;

//   MenuFromIngredientsModel({
//     required this.name,
//     required this.imagePath,
//     required this.isFavorited,
//   });

//   static List<MenuFromIngredientsModel> getMenus() {
//     return [
//       MenuFromIngredientsModel(
//         name: 'ลาบหมู',
//         imagePath: 'assets/images/menu/REC001.jpg',
//         isFavorited: false,
//       ),
//       MenuFromIngredientsModel(
//         name: 'ข้าวกะเพราหมูสับ ไข่ดาว',
//         imagePath: 'assets/images/menu/REC006.jpg',
//         isFavorited: true,
//       ),
//       MenuFromIngredientsModel(
//         name: 'ข้าวกะเพราหมูสับ ไข่ดาว',
//         imagePath: 'assets/images/menu/REC006.jpg',
//         isFavorited: true,
//       ),
//       MenuFromIngredientsModel(
//         name: 'ข้าวกะเพราหมูสับ ไข่ดาว',
//         imagePath: 'assets/images/menu/REC006.jpg',
//         isFavorited: true,
//       ),
//     ];
//   }
// }

import 'package:flutter/material.dart';
import 'package:cookmate/DatabaseHelper.dart';

// class MenuFromIngredientsModel {
//   final String name;
//   final String imagePath;
//   // final bool isFavorited;

//   MenuFromIngredientsModel({
//     required this.name,
//     required this.imagePath,
//     // this.isFavorited = false, // ค่าเริ่มต้น
//   });

//   // ดึงเมนูจากฐานข้อมูล
//   static Future<List<MenuFromIngredientsModel>> getMenus() async {
//     final results = await DatabaseHelper.fetchRecipes();
//     print(results);
//     List<MenuFromIngredientsModel> menus = [];
//     for (var row in results) {
//       menus.add(MenuFromIngredientsModel(
//         name: row['recipe_name'],
//         imagePath: row['recipe_image'],
//         // isFavorited: row['Fav_id'] == 1, // ถ้ามี field นี้ใน DB
//       ));
//     }

//     return menus;
//   }
// }





// import 'package:flutter/material.dart';
// import 'package:cookmate/DatabaseHelper.dart';

class MenuFromIngredientsModel {
  final String name;
  final String imagePath;
  final String instruction;  // กำหนดประเภทเป็น String

  // ปรับ constructor ให้รับ instruction ด้วย
  MenuFromIngredientsModel({
    required this.name,
    required this.imagePath,
    required this.instruction,  // เพิ่ม instruction ที่รับข้อมูล
  });

  // ดึงเมนูจากฐานข้อมูล
  static Future<List<MenuFromIngredientsModel>> getMenus() async {
    final results = await DatabaseHelper.fetchRecipes(); // ดึงข้อมูลเมนูจากฐานข้อมูล
    List<MenuFromIngredientsModel> menus = [];
    
    for (var row in results) {
      // ตรวจสอบว่า row ค่าของ 'recipe_name', 'recipe_image', และ 'instruction' มีข้อมูลหรือไม่
      menus.add(MenuFromIngredientsModel(
        name: row['recipe_name'], // ชื่อเมนู
        imagePath: row['recipe_image'] ?? 'assets/images/menu/default.jpg', // ใส่ default ถ้าไม่มี 'recipe_image'
        instruction: row['instruction'] ?? '', // หากไม่มีข้อมูล instruction ให้ใส่ค่าว่าง
      ));
    }

    return menus;
  }
}
