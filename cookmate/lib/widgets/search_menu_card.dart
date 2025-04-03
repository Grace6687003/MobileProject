import 'package:flutter/material.dart';
import '../pages/detail_page.dart'; // ✅ เพิ่ม import

class SearchMenuCard extends StatelessWidget {
  final String menuName;
  final String imagePath;

  const SearchMenuCard({
    super.key,
    required this.menuName,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // ✅ ไปหน้า DetailPage เมื่อคลิกการ์ด
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DetailPage(),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16, left: 10, right: 10),
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              offset: const Offset(0, 4),
              blurRadius: 4,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              // รูปเมนู
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  imagePath,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),

              // ชื่อเมนู
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      menuName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'NotoSansThai',
                      ),
                    ),
                  ],
                ),
              ),

              // ปุ่มหัวใจ
              Padding(
                padding: const EdgeInsets.only(top: 48),
                child: IconButton(
                  icon: Image.asset(
                    'assets/images/icon/heart.png',
                    width: 24,
                    height: 24,
                  ),
                  onPressed: () {
                    // TODO: handle favorite toggle
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
