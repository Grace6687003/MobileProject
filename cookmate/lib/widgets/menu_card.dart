import 'package:flutter/material.dart';
import 'package:cookmate/DatabaseHelperTest.dart';  // Import DatabaseHelperTest ที่ใช้ในการเชื่อมต่อฐานข้อมูล

class MenuCard extends StatefulWidget {
  final String recipeId;
  final String name;
  final String imagePath;
  final bool isFavorited;
  final VoidCallback? onToggleFavorite;
  final VoidCallback? onTap;

  const MenuCard({
    super.key,
    required this.recipeId,
    required this.name,
    required this.imagePath,
    this.isFavorited = false,
    this.onToggleFavorite,
    this.onTap,
  });

  @override
  State<MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  late bool isFav;
  bool isUpdating = false;

  @override
  void initState() {
    super.initState();
    isFav = widget.isFavorited;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: widget.onTap,
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
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Image.asset(
                  widget.imagePath,
                  height: 152.7,
                  width: 160,
                  fit: BoxFit.cover,
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
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
                      child: GestureDetector(
                        onTap: () {
                          if (isUpdating) return; // ป้องกันการกดซ้ำขณะอัปเดต
                          final newFav = !isFav;
                          
                          // รีเฟรช UI ทันที
                          setState(() {
                            isFav = newFav;
                            isUpdating = true; // ตั้งสถานะกำลังอัปเดต
                          });

                          // อัปเดตฐานข้อมูลในพื้นหลัง
                          DatabaseHelperTest.updateFavoriteStatus(
                            recipeId: widget.recipeId,
                            isFavorite: newFav,
                          ).then((_) {
                            if (mounted) {
                              setState(() {
                                isUpdating = false; // รีเซ็ตสถานะหลังจากการอัปเดตเสร็จ
                              });
                            }
                          });

                          widget.onToggleFavorite?.call();
                        },
                        child: Image.asset(
                          isFav
                              ? 'assets/images/icon/heart_sl.png'
                              : 'assets/images/icon/heart.png',
                          width: 22,
                          height: 22,
                        ),
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
