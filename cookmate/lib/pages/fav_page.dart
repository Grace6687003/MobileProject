import 'package:flutter/material.dart';
import '/widgets/bottom_navbar.dart';
import '/widgets/fav_appbar.dart';
import '/widgets/fav_card.dart';
import 'package:cookmate/DatabaseHelperTest.dart';

class FavPage extends StatefulWidget {
  const FavPage({super.key});

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: CustomfavAppBar(title: 'Favorites'),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: const Color(0xFF2A2C41)),
        child: const BottomNavBar(currentIndex: 3),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Expanded(
              child: StreamBuilder<List<Map<String, String>>>(
                stream: DatabaseHelperTest.fetchFavoriteRecipesStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('เกิดข้อผิดพลาด: ${snapshot.error}'));
                  }

                  final favoriteItems = snapshot.data ?? [];
                  if (favoriteItems.isEmpty) {
                    return const Center(child: Text('ยังไม่มีเมนูโปรดเลยน้า~ 💔'));
                  }

                  return GridView.builder(
                    itemCount: favoriteItems.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.72,
                    ),
                    itemBuilder: (context, index) {
                      final item = favoriteItems[index];
                      final isFavorited = item['fav_id'] == '1';

                      return FavCard(
                        recipeId: item['recipe_id'] ?? '',
                        imagePath: item['recipe_image'] ?? 'assets/images/ui/default_image.png',
                        title: item['recipe_name'] ?? 'ไม่มีชื่อเมนู',
                        isFavorited: isFavorited,
                        onTap: () {
                          // TODO: เปิดหน้า DetailPage
                        },
                        onFavoriteToggle: () async {
                          // ✅ อัปเดตสถานะใน DB
                          await DatabaseHelperTest.updateFavoriteStatus(
                            recipeId: item['recipe_id']!,
                            isFavorite: !isFavorited,
                          );

                          // ✅ ถ้าใช้ StreamBuilder แล้ว ไม่ต้อง setState
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
