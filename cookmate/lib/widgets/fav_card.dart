import 'package:flutter/material.dart';

class FavCard extends StatelessWidget {
  final String recipeId;
  final String imagePath;
  final String title;
  final bool isFavorited;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteToggle;

  const FavCard({
    super.key,
    required this.recipeId,
    required this.imagePath,
    required this.title,
    required this.isFavorited,
    this.onTap,
    this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/ui/default_image.png',
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),

            Expanded(
              flex: 1,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFC3E090),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 6.0,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'NotoSansThai',
                        ),
                        softWrap: true,
                      ),
                    ),
                    const SizedBox(width: 4),

                    GestureDetector(
                      onTap: onFavoriteToggle,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16.0, right: 4.0),
                        child: Image.asset(
                          isFavorited
                              ? 'assets/images/icon/heart_sl.png'
                              : 'assets/images/icon/heart.png',
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
