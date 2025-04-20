
import 'package:flutter/material.dart';
import '../models/ingredient_model.dart';
import '../widgets/menu_card.dart'; 
import '../widgets/menu_item_card.dart'; 
import '../widgets/ingredient_card.dart';
import '../pages/detail_page.dart';
import '../pages/search_page.dart';
import '../pages/ingredients/myingredients_page.dart';
import '../pages/fav_page.dart';
import '../widgets/bottom_navbar.dart';
import '../widgets/home_appbar.dart';
import 'package:cookmate/DatabaseHelperTest.dart';
import '../pages/stores_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Stream<List<Map<String, String>>> _favoriteRecipesStream;
  late Future<List<Map<String, String>>> _recipesFuture;
  late Future<List<Map<String, dynamic>>> _ingredientsFuture;
  late List<Map<String, String>> _randomMenus = [];

  @override
  void initState() {
    super.initState();
    _favoriteRecipesStream =
        DatabaseHelperTest.fetchFavoriteRecipesStream(); // ใช้ Stream
    _refreshRecipes();
    _refreshIngredients();
    _loadRandomMenus();
  }

  // ฟังก์ชันรีเฟรชเมนูจากวัตถุดิบ
  void _refreshRecipes() {
    setState(() {
      _recipesFuture = DatabaseHelperTest.fetchFullyMatchedRecipes();
    });
  }

  // ฟังก์ชันรีเฟรชวัตถุดิบของฉัน
  void _refreshIngredients() {
    setState(() {
      _ingredientsFuture = DatabaseHelperTest.fetchUserIngredientsOnly();
    });
  }

  // ฟังก์ชันโหลดเมนูแนะนำครั้งแรก หรือเมื่อมีการเปลี่ยนหน้า
  void _loadRandomMenus() async {
    var randomMenus =
        await DatabaseHelperTest.fetchRandomMenus(); 
    setState(() {
      _randomMenus = randomMenus; 
    });
  }

  // ฟังก์ชันการกด/ไม่กดหัวใจ
  void _toggleFavorite(String recipeId, bool isCurrentlyFavorited) async {
    bool newFavoriteStatus = !isCurrentlyFavorited;

    // อัปเดตสถานะโปรดในฐานข้อมูล
    await DatabaseHelperTest.updateFavoriteStatus(
      recipeId: recipeId,
      isFavorite: newFavoriteStatus,
    );

    setState(() {
   
      for (var menu in _randomMenus) {
        if (menu['recipe_id'] == recipeId) {
          menu['fav_id'] =
              newFavoriteStatus ? '1' : '0'; 
        }
      }
    });
  }

  // ฟังก์ชันสร้าง MenuItemCard สำหรับเมนูโปรดและเมนูแนะนำ
  Widget _buildMenuItemCard(Map<String, String> recipe) {
    bool isFavorited = recipe['fav_id'] == '1';

    return MenuItemCard(
      imagePath: recipe['recipe_image'] ?? '',
      name: recipe['recipe_name'] ?? '',
      isFavorited: isFavorited,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailPage(recipeId: recipe['recipe_id'] ?? ''),
          ),
        );
      },
      onFavoriteToggle: () {
        _toggleFavorite(recipe['recipe_id'] ?? '', isFavorited);
      },
    );
  }

  // ฟังก์ชันสร้าง MenuCard สำหรับเมนูจากวัตถุดิบ
  Widget _buildMenuCard(Map<String, String> recipe) {
    return MenuCard(
      recipeId: recipe['recipe_id'] ?? '',
      name: recipe['recipe_name'] ?? '',
      imagePath: recipe['recipe_image'] ?? '',
      isFavorited: recipe['fav_id'] == '1',
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailPage(recipeId: recipe['recipe_id'] ?? ''),
          ),
        );
      },
    );
  }

  void _confirmDeleteIngredient(String ingredientName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'คุณแน่ใจหรือไม่ว่าต้องการลบรายละเอียดของ "$ingredientName" ?',
        ),
        action: SnackBarAction(
          label: 'ยืนยัน',
          textColor: Colors.red,
          onPressed: () async {
            await DatabaseHelperTest.clearIngredientDetails(
              ingredientName: ingredientName,
            );
            _refreshIngredients();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('ลบรายละเอียดเรียบร้อยแล้ว')),
            );
          },
        ),
      ),
    );
  }

  // ฟังก์ชันสร้างปุ่ม Go สำหรับไปหน้าเมนูทั้งหมด
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: HomeAppBar(title: 'COOKMATE'),
      bottomNavigationBar: BottomNavBar(currentIndex: 0),
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
            FutureBuilder<List<Map<String, String>>>(
              future: _recipesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('ไม่มีเมนูที่ตรงกับวัตถุดิบของคุณ'),
                  );
                }

                var recipes = snapshot.data!;

                return SizedBox(
                  height: 257.7,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount:
                        recipes.length > 4
                            ? 5
                            : recipes.length + 1, // เพิ่ม 1 สำหรับปุ่ม Go
                    itemBuilder: (context, index) {
                      if (index < (recipes.length > 4 ? 4 : recipes.length)) {
                        var recipe = recipes[index];
                        return Container(
                          margin: const EdgeInsets.only(right: 12),
                          child: _buildMenuCard(
                            recipe,
                          ), 
                        );
                      } else {
                        return goCard(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) => const SearchPage(
                                    initialFilter: FilterMode.byIngredients,
                                  ),
                            ),
                          );
                        });
                      }
                    },
                  ),
                );
              },
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
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _ingredientsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: \${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('ยังไม่มีวัตถุดิบที่เพิ่มไว้'),
                  );
                }

                final ingredientData = snapshot.data!;

                return SizedBox(
                  height: 128,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 16),
                    itemCount:
                        ingredientData.length > 4
                            ? 5
                            : ingredientData.length +
                                1, // เพิ่ม 1 สำหรับปุ่ม Go
                    itemBuilder: (context, index) {
                      if (index <
                          (ingredientData.length > 4
                              ? 4
                              : ingredientData.length)) {
                        final item = ingredientData[index];
                        return IngredientCard(
                          ingredient: IngredientModel(
                            id: index,
                            ingredientId: 0,
                            name: item['ingredient_name'],
                            imagePath: item['Categories_image'],
                            expDate:
                                item['exp_date'] != null
                                    ? DateTime.tryParse(item['exp_date']) ??
                                        DateTime.now()
                                    : DateTime.now(),
                          ),
                          onDelete:
                              () => _confirmDeleteIngredient(
                                item['ingredient_name'],
                              ),
                          onUpdate: () {
                            _refreshIngredients();
                            _refreshRecipes(); 
                          },
                        );
                      } else {
                        return goCard(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const MyIngredientsPage(),
                            ),
                          );
                        });
                      }
                    },
                  ),
                );
              },
            ),

            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'เมนูโปรด',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'NotoSansThai',
                ),
              ),
            ),
            const SizedBox(height: 17),
            StreamBuilder<List<Map<String, String>>>(
              stream: _favoriteRecipesStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('ไม่มีเมนูโปรด'));
                }

                var favoriteRecipes = snapshot.data!;

                return SizedBox(
                  height: 130,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 16),
                    itemCount:
                        favoriteRecipes.length > 4
                            ? 5
                            : favoriteRecipes.length + 1,
                    itemBuilder: (context, index) {
                      if (index <
                          (favoriteRecipes.length > 4
                              ? 4
                              : favoriteRecipes.length)) {
                        var recipe = favoriteRecipes[index];
                        return Container(
                          margin: const EdgeInsets.only(right: 12),
                          child: _buildMenuItemCard(
                            recipe,
                          ), // ใช้ MenuItemCard สำหรับเมนูโปรด
                        );
                      } else {
                        return goCard(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => FavPage()),
                          );
                        });
                      }
                    },
                  ),
                );
              },
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
              height: 130,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 16),
                itemCount:
                    _randomMenus.length > 4 ? 5 : _randomMenus.length + 1,
               
                itemBuilder: (context, index) {
                  if (index <
                      (_randomMenus.length > 4 ? 4 : _randomMenus.length)) {
                    var recipe = _randomMenus[index];
                    return Container(
                      margin: const EdgeInsets.only(right: 12),
                      child: _buildMenuItemCard(
                        recipe,
                      ), // ใช้ MenuItemCard สำหรับเมนูแนะนำ
                    );
                  } else {
                    return goCard(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => SearchPage(recommendedMenus: _randomMenus),
                        ),
                      );
                    });
                  }
                },
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const NearbyStoresPage()),
                  );
                },
                child: Column(
                  children: [
                    Text(
                      'ร้านค้าใกล้ฉัน',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'NotoSansThai',
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.orange.shade100,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.orange.withOpacity(0.3),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.storefront,
                        size: 40,
                        color: Colors.orange,
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
