// import 'package:flutter/material.dart';
// import '../pages/home_page.dart';
// import '../pages/search_page.dart';
// import '../pages/ingredients/myingredients_page.dart';
// import '../pages/fav_page.dart';

// class BottomNavBar extends StatefulWidget {
//   const BottomNavBar({super.key});

//   @override
//   _BottomNavBarState createState() => _BottomNavBarState();
// }

// class _BottomNavBarState extends State<BottomNavBar> {
//   int _currentIndex = 0;

//   // หน้าแต่ละหน้า
//   final List<Widget> _pages = [
//      HomePage(),
//     SearchPage(),
//     MyIngredientsPage(),
//     FavPage(),
//   ];

//   // ฟังก์ชันเปลี่ยนหน้า
//   void _onItemTapped(int index) {
//     setState(() {
//       _currentIndex = index;  // เปลี่ยนค่าของ _currentIndex เมื่อเลือกหน้า
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Bottom Navigation Bar with Navigator'),
//       ),
//       // แสดงหน้าที่เลือกจาก _pages[_currentIndex]
//       body: _pages[_currentIndex], 
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: _onItemTapped,
//         items: [
//           BottomNavigationBarItem(
//             icon: SizedBox(
//               height: 24,
//               child: Image(
//                 image: AssetImage(_currentIndex == 0
//                     ? 'assets/images/icon/home_sl.png'  // เปลี่ยนไอคอนเมื่อเลือก
//                     : 'assets/images/icon/home.png'),  // ใช้ไอคอนปกติเมื่อไม่ได้เลือก
//               ),
//             ),
//             label: 'home',
//           ),
//           BottomNavigationBarItem(
//             icon: SizedBox(
//               height: 24,
//               child: Image(
//                 image: AssetImage(_currentIndex == 1
//                     ? 'assets/images/icon/search_sl.png'
//                     : 'assets/images/icon/search.png'),
//               ),
//             ),
//             label: 'search',
//           ),
//           BottomNavigationBarItem(
//             icon: SizedBox(
//               height: 24,
//               child: Image(
//                 image: AssetImage(_currentIndex == 2
//                     ? 'assets/images/icon/my_ingredient_sl.png'
//                     : 'assets/images/icon/my_ingredient.png'),
//               ),
//             ),
//             label: 'my ingredient',
//           ),
//           BottomNavigationBarItem(
//             icon: SizedBox(
//               height: 24,
//               child: Image(
//                 image: AssetImage(_currentIndex == 3
//                     ? 'assets/images/icon/favorite_sl.png'
//                     : 'assets/images/icon/favorite.png'),
//               ),
//             ),
//             label: 'my favorite',
//           ),
//         ],
//         selectedItemColor: Colors.white,
//         unselectedItemColor: Color(0xFF9195B7),
//         backgroundColor: Colors.transparent,
//         type: BottomNavigationBarType.fixed,
//         showSelectedLabels: false,
//         showUnselectedLabels: false,
//         elevation: 0,
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import '../pages/search_page.dart';
import '../pages/ingredients/myingredients_page.dart';
import '../pages/fav_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    // ✅ ไม่ต้องใช้ setState เพราะจะเปลี่ยนหน้าอยู่แล้ว
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SearchPage()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyIngredientsPage()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => FavPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF2A2C41),
        border: Border(
          top: BorderSide(
            color: Colors.black26,
            width: 1,
          ),
        ),
      ),
      child: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 24,
              child: Image(
                image: AssetImage('assets/images/icon/home.png'),
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 24,
              child: Image(
                image: AssetImage('assets/images/icon/search.png'),
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 24,
              child: Image(
                image: AssetImage('assets/images/icon/my_ingredient.png'),
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 24,
              child: Image(
                image: AssetImage('assets/images/icon/favorite.png'),
              ),
            ),
            label: '',
          ),
        ],
        currentIndex: _currentIndex, // ยังให้ไฮไลต์ปุ่มถูกต้องในอนาคต
        selectedItemColor: Colors.white,
        unselectedItemColor: Color(0xFF9195B7),
        backgroundColor: Colors.transparent,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        onTap: _onItemTapped,
      ),
    );
  }
}