import 'package:flutter/material.dart';
import '../models/menu_from_ingredients_model.dart';
import '../models/ingredient_model.dart';
import '../widgets/menu_card.dart';
import '../widgets/ingredient_card.dart';
import '../widgets/menu_item_card.dart';
import '../pages/detail_page.dart';
import '../widgets/bottom_navbar.dart';
import '../widgets/home_appbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final menus = MenuFromIngredientsModel.getMenus();

    final ingredients = [
      IngredientModel(
        id: 1,
        ingredientId: 2,
        name: 'ไข่ไก่',
        imagePath: 'assets/images/categories/egg.png',
        expDate: DateTime(2025, 3, 30),
      ),
      IngredientModel(
        id: 2,
        ingredientId: 3,
        name: 'หมู',
        imagePath: 'assets/images/categories/meat.png',
        expDate: DateTime(2025, 4, 5),
      ),
      IngredientModel(
        id: 3,
        ingredientId: 4,
        name: 'ผักกาด',
        imagePath: 'assets/images/categories/vegetable.png',
        expDate: DateTime(2025, 3, 25),
      ),
    ];

    Widget goCard(VoidCallback onTap) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          width: 64,
          height: 64,
          margin: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFF9F9F9),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Image.asset(
              'assets/images/icon/go.png',
              width: 40,
              height: 40,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: HomeAppBar(title: 'COOKMATE'),
      bottomNavigationBar: BottomNavBar(), 
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'เมนูจากวัตถุดิบของฉัน',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'NotoSansThai',
                ),
              ),
            ),
            const SizedBox(height: 17),

            SizedBox(
              height: 257.7,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: menus.length + 1,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  if (index < menus.length) {
                    return MenuCard(
                      menu: menus[index],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DetailPage(),
                          ),
                        );
                      },
                    );
                  } else {
                    return goCard(() {
                      // ไปยังหน้าเมนูทั้งหมด
                    });
                  }
                },
              ),
            ),

            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'วัตถุดิบของฉัน',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'NotoSansThai',
                ),
              ),
            ),
            const SizedBox(height: 17),

            SizedBox(
              height: 128,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 16),
                itemCount: ingredients.length + 1,
                itemBuilder: (context, index) {
                  if (index < ingredients.length) {
                    return IngredientCard(
                      ingredient: ingredients[index],
                      onDelete: () {
                        // ลบวัตถุดิบ
                      },
                    );
                  } else {
                    return goCard(() {
                      // ไปยังหน้าวัตถุดิบทั้งหมด
                    });
                  }
                },
              ),
            ),

            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'เมนูโปรด',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'NotoSansThai',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 17),

            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 16),
                itemCount: menus.length + 1,
                itemBuilder: (context, index) {
                  if (index < menus.length) {
                    final menu = menus[index];
                    return MenuItemCard(
                      imagePath: menu.imagePath,
                      name: menu.name,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DetailPage(),
                          ),
                        );
                      },
                    );
                  } else {
                    return goCard(() {
                      // ไปยังหน้ารายการเมนูโปรดทั้งหมด
                    });
                  }
                },
              ),
            ),

            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'เมนูแนะนำ',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'NotoSansThai',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 17),

            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 16),
                itemCount: menus.length + 1,
                itemBuilder: (context, index) {
                  if (index < menus.length) {
                    final menu = menus[index];
                    return MenuItemCard(
                      imagePath: menu.imagePath,
                      name: menu.name,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DetailPage(),
                          ),
                        );
                      },
                    );
                  } else {
                    return goCard(() {
                      // ไปยังหน้ารายการเมนูแนะนำทั้งหมด
                    });
                  }
                },
              ),
            ),

            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'ร้านค้าใกล้ฉัน',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'NotoSansThai',
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
