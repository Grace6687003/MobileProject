import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/splashScreen.dart'; 
import 'DatabaseHelperTest.dart';

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
      home: const SplashScreen(), 
      debugShowCheckedModeBanner: false,
    );
  }
}
