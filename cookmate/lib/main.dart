import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'DatabaseHelper.dart';
import 'DatabaseHelperTest.dart';
import '../models/menu_from_ingredients_model.dart';
void main() {
  // ทดสอบการเชื่อมต่อฐานข้อมูล
  DatabaseHelperTest.testConnection();

  runApp(const CookMateApp());
}

class CookMateApp extends StatelessWidget {
  const CookMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'NotoSansThai', // กำหนดฟอนต์หลัก
        textTheme: TextTheme(
          // ไม่จำเป็นต้องกำหนดฟอนต์ในแต่ละตัว เช่น bodyText1, bodyText2, headline1, ...
        ),
      ),
      home:  HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
