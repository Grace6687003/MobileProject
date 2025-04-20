import 'package:flutter/material.dart';
import '../widgets/search_menu_card.dart';
import '../widgets/bottom_navbar.dart';
import 'package:cookmate/DatabaseHelperTest.dart';

enum FilterMode { all, byIngredients }

class SearchPage extends StatefulWidget {
  final List<Map<String, String>>? recommendedMenus;
  final FilterMode? initialFilter; // ✅ เพิ่มรับ filter เริ่มต้น

  const SearchPage({super.key, this.recommendedMenus, this.initialFilter});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Map<String, String>> _allMenus = [];
  List<Map<String, String>> _ingredientMenus = [];
  List<Map<String, String>> _recommendedMenus = [];
  List<Map<String, String>> _filteredMenus = [];

  FilterMode? _filterMode;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _recommendedMenus = widget.recommendedMenus ?? [];
    _filterMode = widget.initialFilter; // ✅ ตั้งค่า filter เริ่มต้น
    _loadAllMenus();
  }

  Future<void> _loadAllMenus() async {
    final all = await DatabaseHelperTest.fetchAllMenus();
    final byIngredients = await DatabaseHelperTest.fetchFullyMatchedRecipes();

    setState(() {
      _allMenus = all;
      _ingredientMenus = byIngredients;
    });

    _applySearch(_searchQuery);
  }

  void _onFilterSelected(FilterMode selectedMode) {
    setState(() {
      _filterMode = _filterMode == selectedMode ? null : selectedMode;
      _applySearch(_searchQuery);
    });
  }

  void _applySearch(String query) {
    List<Map<String, String>> baseList;

    // เลือกรายการเมนูตามการกรองที่เลือก
    if (_filterMode == FilterMode.all) {
      baseList = _allMenus; // เมนูทั้งหมด
    } else if (_filterMode == FilterMode.byIngredients) {
      baseList = _ingredientMenus; // เมนูที่กรองตามวัตถุดิบ
    } else {
      baseList = [
        ..._recommendedMenus,
        ..._ingredientMenus,
        ..._allMenus,
      ]; // ถ้าไม่ได้เลือกกรอง ใช้ทั้งหมด
    }

    // สร้างชุดข้อมูลที่ใช้สำหรับตรวจสอบว่าเมนูเคยถูกค้นหาหรือไม่
    final seen = <String>{};
    final results =
        baseList.where((menu) {
          final id = menu['recipe_id'] ?? '';
          final name = menu['recipe_name'] ?? '';
          if (seen.contains(id)) return false;
          seen.add(id);

          // ตรวจสอบการค้นหาผ่านชื่อเมนูหรือวัตถุดิบ
          return name.toLowerCase().contains(query.toLowerCase()) ||
              (menu['ingredients'] ?? '').toLowerCase().contains(
                query.toLowerCase(),
              );
        }).toList();

    setState(() {
      _filteredMenus = results;
    });
  }

  void _searchMenu(String query) async {
    _searchQuery = query;

    // ดึงผลลัพธ์จากฐานข้อมูลโดยใช้การค้นหา
    final results = await DatabaseHelperTest.searchRecipesByNameOrIngredient(
      query,
    );

    setState(() {
      _filteredMenus = results;
    });

    // เรียกใช้การกรองเพิ่มเติมหลังการค้นหาผ่าน DB
    _applySearch(query);
  }

  void _toggleFavorite(String recipeId, bool isCurrentlyFavorited) async {
    final newStatus = !isCurrentlyFavorited;
    await DatabaseHelperTest.updateFavoriteStatus(
      recipeId: recipeId,
      isFavorite: newStatus,
    );

    void updateList(List<Map<String, String>> list) {
      for (var menu in list) {
        if (menu['recipe_id'] == recipeId) {
          menu['fav_id'] = newStatus ? '1' : '0';
        }
      }
    }

    setState(() {
      updateList(_recommendedMenus);
      updateList(_ingredientMenus);
      updateList(_allMenus);
      updateList(_filteredMenus);
    });
  }

  Widget _buildMenuSection(String title, List<Map<String, String>> menus) {
    if (menus.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'NotoSansThai',
          ),
        ),
        const SizedBox(height: 8),
        ...menus.map((menu) {
          final isFavorited = menu['fav_id'] == '1';
          return SearchMenuCard(
            recipeId: menu['recipe_id'] ?? '',
            menuName: menu['recipe_name'] ?? '',
            imagePath: menu['recipe_image'] ?? '',
            isFavorited: isFavorited,
            onFavoriteToggle:
                () => _toggleFavorite(menu['recipe_id']!, isFavorited),
          );
        }),
        const SizedBox(height: 16),
      ],
    );
  }

  Color _buttonBg(FilterMode mode) {
    if (_filterMode == null) return Colors.white;
    return _filterMode == mode
        ? (mode == FilterMode.all
            ? const Color(0xffe9ffca)
            : const Color(0xffbafcf9))
        : Colors.white;
  }

  Color _buttonText(FilterMode mode) {
    if (_filterMode == null) return const Color(0xFF444444);
    return _filterMode == mode ? Colors.black : const Color(0xFF444444);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      bottomNavigationBar: BottomNavBar(
        recommendedMenus: _recommendedMenus,
        currentIndex: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),

            Row(
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(Icons.arrow_back, color: Colors.black87),
                  iconSize: 30,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(width: 4),
                const Text(
                  '',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'NotoSansThai',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            // 🔍 Search Box
            Container(
              decoration: BoxDecoration(
                color: const Color(0xfff7b03a),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    offset: const Offset(0, 4),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: TextField(
                onChanged: _searchMenu,
                decoration: InputDecoration(
                  hintText: 'ค้นหาจากชื่อเมนูหรือวัตถุดิบ',
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 12, right: 8),
                    child: Image.asset(
                      'assets/images/icon/searchpage.png',
                      width: 24,
                      height: 24,
                    ),
                  ),
                  filled: true,
                  fillColor: const Color(0xfff7b03a),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                SizedBox(
                  width: 124,
                  height: 38,
                  child: ElevatedButton(
                    onPressed: () => _onFilterSelected(FilterMode.all),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _buttonBg(FilterMode.all),
                      foregroundColor: _buttonText(FilterMode.all),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(color: Colors.black),
                      ),
                    ),
                    child: const Text(
                      'ทั้งหมด',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'NotoSansThai',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 124,
                  height: 38,
                  child: ElevatedButton(
                    onPressed:
                        () => _onFilterSelected(FilterMode.byIngredients),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _buttonBg(FilterMode.byIngredients),
                      foregroundColor: _buttonText(FilterMode.byIngredients),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(color: Colors.black),
                      ),
                    ),
                    child: const Text(
                      'จากวัตถุดิบ',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'NotoSansThai',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),

            Expanded(
              child: ListView(
                children: [
                  if (_searchQuery.isNotEmpty)
                    _buildMenuSection('ผลการค้นหา', _filteredMenus),
                  if (_searchQuery.isEmpty &&
                      _filterMode == null &&
                      _recommendedMenus.isNotEmpty)
                    _buildMenuSection('เมนูแนะนำ', _recommendedMenus),
                  if (_searchQuery.isEmpty && _filterMode == null)
                    _buildMenuSection('เมนูจากวัตถุดิบ', _ingredientMenus),
                  if (_searchQuery.isEmpty && _filterMode == null)
                    _buildMenuSection('เมนูทั้งหมด', _allMenus),
                  if (_searchQuery.isEmpty && _filterMode != null)
                    _buildMenuSection(
                      _filterMode == FilterMode.all
                          ? 'เมนูทั้งหมด'
                          : 'เมนูจากวัตถุดิบ',
                      _filteredMenus,
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
