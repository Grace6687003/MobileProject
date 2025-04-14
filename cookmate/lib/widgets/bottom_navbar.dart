import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import '../pages/search_page.dart';
import '../pages/ingredients/myingredients_page.dart';
import '../pages/fav_page.dart';
import 'package:cookmate/DatabaseHelperTest.dart';

class BottomNavBar extends StatelessWidget {
  final List<Map<String, String>>? recommendedMenus;
  final int currentIndex;

  const BottomNavBar({
    super.key,
    this.recommendedMenus,
    this.currentIndex = 0,
  });

  void _onItemTapped(BuildContext context, int index) async {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
        break;

      case 1:
        final randomMenus = await DatabaseHelperTest.fetchRandomMenus();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => SearchPage(
              recommendedMenus: randomMenus,
              initialFilter: null,
            ),
          ),
        );
        break;

      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => MyIngredientsPage()),
        );
        break;

      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => FavPage()),
        );
        break;
    }
  }

  Widget _buildIcon(String selectedPath, String unselectedPath, bool isSelected) {
    return SizedBox(
      width: 30,
      height: 30,
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Image.asset(
          isSelected ? selectedPath : unselectedPath,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  @override
Widget build(BuildContext context) {
  final safeIndex = (currentIndex >= 0 && currentIndex <= 3) ? currentIndex : -1;

  return Container(
    decoration: const BoxDecoration(
      color: Color(0xFF2A2C41),
      border: Border(
        top: BorderSide(color: Colors.black26, width: 1),
      ),
    ),
    child: BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: _buildIcon(
            'assets/images/icon/home_sl.png',
            'assets/images/icon/home.png',
            safeIndex == 0,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: _buildIcon(
            'assets/images/icon/search_sl.png',
            'assets/images/icon/search.png',
            safeIndex == 1,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: _buildIcon(
            'assets/images/icon/my_ingredient_sl.png',
            'assets/images/icon/my_ingredient.png',
            safeIndex == 2,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: _buildIcon(
            'assets/images/icon/favorite_sl.png',
            'assets/images/icon/favorite.png',
            safeIndex == 3,
          ),
          label: '',
        ),
      ],
      currentIndex: safeIndex >= 0 ? safeIndex : 0, // ❗️ต้องส่งค่าที่ valid
      selectedItemColor: Colors.white,
      unselectedItemColor: const Color(0xFF9195B7),
      backgroundColor: Colors.transparent,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      elevation: 0,
      onTap: (index) => _onItemTapped(context, index),
    ),
  );
}

}
