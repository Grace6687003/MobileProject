import 'package:flutter/material.dart';
import 'home_page.dart'; // หรือหน้าเริ่มต้นที่ต้องการ

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // หน่วงเวลา 2 วินาที แล้วไปหน้า HomePage
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    });
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    body: Align(
      alignment: const Alignment(0, 0), // 👈 ขยับขึ้น (-1 คือบนสุด, 0 คือกลาง)
      child: Image.asset(
        'assets/images/ui/cookmate_logo.png',
        width: 300,
        height: 300,
        fit: BoxFit.contain,
      ),
    ),
  );
}

}
