import 'package:flutter/material.dart';
import '../pages/detail_page.dart';

class SearchMenuCard extends StatelessWidget {
  final String recipeId;
  final String menuName;
  final String imagePath;
  final bool isFavorited;
  final VoidCallback? onFavoriteToggle;

  const SearchMenuCard({
    super.key,
    required this.recipeId,
    required this.menuName,
    required this.imagePath,
    this.isFavorited = false,
    this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(recipeId: recipeId), // ✅ ส่ง recipeId ไป
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
              Padding(
                padding: const EdgeInsets.only(top: 48),
                child: IconButton(
                  icon: Image.asset(
                    isFavorited
                        ? 'assets/images/icon/heart_sl.png'
                        : 'assets/images/icon/heart.png',
                    width: 24,
                    height: 24,
                  ),
                  onPressed: onFavoriteToggle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
