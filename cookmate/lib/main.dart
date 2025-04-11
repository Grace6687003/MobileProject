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
        fontFamily: 'NotoSansThai',
      ),
      initialRoute: '/home', // ระบุให้เริ่มต้นที่ /home
      routes: {
        '/home': (context) => HomePage(), // ✅ เพิ่ม route นี้
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
