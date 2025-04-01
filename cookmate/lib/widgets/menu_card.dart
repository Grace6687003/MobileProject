import 'package:flutter/material.dart';
import '../models/menu_from_ingredients_model.dart';

class MenuCard extends StatelessWidget {
  final MenuFromIngredientsModel menu;

  const MenuCard({super.key, required this.menu});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        width: 160,
        height: 270,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            // 🔹 เงารอบการ์ด
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 4,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // 🔸 รูปภาพที่มีเงาใต้รูป
            Container(
         
              decoration: BoxDecoration(
                boxShadow: [
                  // 🔸 เงาใต้รูป
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 4,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Image.asset(
                  menu.imagePath,
                  height: 152.7,
                  width: 160,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // 🔻 กล่องชื่อเมนู + หัวใจ
            Container(
              height: 89,
              width: 160,
              decoration: const BoxDecoration(
                color: Color(0xFF54BDB8),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
                top: 7, 
                bottom: 13,
                ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    menu.name,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Image.asset(
                      menu.isFavorited
                          ? 'assets/images/icon/heart_sl.png'
                          : 'assets/images/icon/heart.png',
                      width: 22,
                      height: 22,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
