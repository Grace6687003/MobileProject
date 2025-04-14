import 'package:flutter/material.dart';
import 'package:cookmate/DatabaseHelperTest.dart';
import '../widgets/bottom_navbar.dart';

class DetailPage extends StatefulWidget {
  final String recipeId;

  const DetailPage({super.key, required this.recipeId});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Future<Map<String, dynamic>> _recipeDetailFuture;
  List<String> _userIngredients = [];

  @override
  void initState() {
    super.initState();
    _recipeDetailFuture = _loadRecipeWithUserIngredients(widget.recipeId);
  }

  Future<Map<String, dynamic>> _loadRecipeWithUserIngredients(String recipeId) async {
    final recipe = await DatabaseHelperTest.getRecipeDetail(recipeId);
    final userIngredients = await DatabaseHelperTest.fetchUserIngredientsOnly();

    _userIngredients = userIngredients.map((e) => e['ingredient_name'].toString()).toList();
    return recipe;
  }

  static bool _isRequired(dynamic value) {
    return value == true || value == '1' || value == 1;
  }

  void _toggleFavorite(String recipeId, bool currentFavStatus) async {
    await DatabaseHelperTest.updateFavoriteStatus(
      recipeId: recipeId,
      isFavorite: !currentFavStatus,
    );
    setState(() {
      _recipeDetailFuture = _loadRecipeWithUserIngredients(recipeId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      bottomNavigationBar: const BottomNavBar(currentIndex: -1),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _recipeDetailFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('ไม่พบข้อมูลเมนูนี้'));
          }

          final data = snapshot.data!;
          final imagePath = data['recipe_image'];
          final recipeName = data['recipe_name'];
          final instruction = data['instruction'];
          final recipeId = data['recipe_id'];
          final favId = data['fav_id'];
          final isFavorite = favId == '1' || favId == 1;

          final ingredients = data['ingredients'] as List<Map<String, dynamic>>;
          final required = ingredients.where((i) => _isRequired(i['is_required'])).toList();
          final optional = ingredients.where((i) => !_isRequired(i['is_required'])).toList();

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                      child: Image.asset(
                        imagePath,
                        width: double.infinity,
                        height: 380,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 40,
                      left: 20,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.black87),
                        iconSize: 36,
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          recipeName,
                          style: const TextStyle(
                            fontFamily: 'NotoSansThai',
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: Image.asset(
                          isFavorite
                              ? 'assets/images/icon/heart_sl.png'
                              : 'assets/images/icon/heart.png',
                          width: 30,
                          height: 30,
                          fit: BoxFit.contain,
                        ),
                        onPressed: () => _toggleFavorite(recipeId, isFavorite),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                _buildSectionHeader('วัตถุดิบ', 0xFFC3E090),
                const SizedBox(height: 12),
                _buildIngredientsSection(required, optional),
                const SizedBox(height: 18),
                _buildSectionHeader('วิธีทำ', 0xFFFFDB71),
                const SizedBox(height: 12),
                _buildInstructionSection(instruction),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title, int colorHex) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 22),
        decoration: BoxDecoration(
          color: Color(colorHex),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontFamily: 'NotoSansThai',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildIngredientsSection(List<Map<String, dynamic>> required, List<Map<String, dynamic>> optional) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...required.map((i) {
            final haveIngredient = _userIngredients.contains(i['ingredient_name']);
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Container(
                decoration: haveIngredient
                    ? BoxDecoration(
                        color: const Color(0xFFD6EDC7),
                        borderRadius: BorderRadius.circular(8),
                      )
                    : null,
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                child: Row(
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        value: haveIngredient,
                        onChanged: null,
                        visualDensity: VisualDensity.compact,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        i['ingredient_name'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: 'NotoSansThai',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 8),
          ...optional.map((i) => Padding(
                padding: const EdgeInsets.only(left: 40.0, top: 2, bottom: 2),
                child: Text(
                  i['ingredient_name'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'NotoSansThai',
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildInstructionSection(String instruction) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 20, bottom: 30),
      child: Text(
        instruction,
        style: const TextStyle(
          fontSize: 18,
          fontFamily: 'NotoSansThai',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
