import 'package:flutter/material.dart';
import '../models/menu_from_ingredients_model.dart';
import '../pages/detail_page.dart'; // ✅ เพิ่ม import ถ้ายังไม่มี

class MenuCard extends StatelessWidget {
  final MenuFromIngredientsModel menu;
  final VoidCallback? onTap; // ✅ เพิ่ม parameter

  const MenuCard({super.key, required this.menu, this.onTap}); // ✅ เพิ่ม this.onTap

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector( // ✅ ใส่ GestureDetector
        onTap: onTap ?? () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const DetailPage()),
          );
        },
        child: Container(
          width: 160,
          height: 270,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 4,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
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
      ),
    );
  }
}
