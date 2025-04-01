import 'package:flutter/material.dart';
import 'pages/home_page.dart';
// import 'pages/detail_page.dart';
// import 'pages/search_page.dart';

void main() {
  runApp(const CookMateApp());
}

class CookMateApp extends StatelessWidget {
  const CookMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home: const HomePage(),
      // home: const DetailPage(),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// // import 'package:flutter/material.dart';
// // import 'pages/ingredients/myingredients_page.dart';
// // import 'pages/ingredients/categories_page.dart';

// // void main() {
// //   runApp(const MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       initialRoute: '/my-ingredients', // ✅ เริ่มต้นที่หน้า MyIngredientsPage
// //       routes: {
// //         '/my-ingredients': (context) => MyIngredientsPage(),
// //         '/categories': (context) => CategoriesPage(),
// //       },
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'pages/ingredients/myingredients_page.dart';
// import 'pages/ingredients/categories_page.dart';
// import 'pages/fav_page.dart'; // นำเข้า FavPage

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       initialRoute: '/my-ingredients', // ✅ เริ่มต้นที่หน้า MyIngredientsPage
//       routes: {
//         '/my-ingredients': (context) => MyIngredientsPage(),
//         '/categories': (context) => CategoriesPage(),
//         '/favorites': (context) => FavPage(), // ลงทะเบียน FavPage ใน routes
//       },
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'pages/ingredients/myingredients_page.dart'; // เปลี่ยนเป็น path ที่ถูกต้อง 
// // import 'fav_page.dart'; // เปลี่ยนเป็น path ที่ถูกต้อง

// class BottomNavBar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       items: [
//         BottomNavigationBarItem(
//           icon: Image.asset('assets/images/ui/solar_chef-hat-bold.png'),
//           label: '', // ซ่อนข้อความ
//         ),
//         BottomNavigationBarItem(
//           icon: Image.asset('assets/images/ui/search.png'),
//           label: '',
//         ),
//         BottomNavigationBarItem(
//           icon: Image.asset('assets/images/ui/task.png'),
//           label: '',
//         ),
//         BottomNavigationBarItem(
//           icon: Image.asset('assets/images/ui/fav.png'),
//           label: '',
//         ),
//       ],
//       currentIndex: 0,
//       onTap: (index) {
//         // Handle tab change here
//         switch (index) {
//           case 2: // ถ้าเลือก icon "task"
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => MyIngredientsPage()),
//             );
//             // break;
//           // case 3: // ถ้าเลือก icon "fav"
//           //   Navigator.push(
//           //     context,
//           //     MaterialPageRoute(builder: (context) => FavPage()),
//           //   );
//           //   break;
//           // default:
//           //   break;
//         }
//       },
//       backgroundColor: Color(0xFF2A2C41), // สีพื้นหลัง
//       unselectedItemColor: Color(0xFF9195B7), // สีไอคอนที่ไม่ได้เลือก
//       selectedItemColor: Colors.white, // สีไอคอนที่เลือก
//       type: BottomNavigationBarType.fixed,
//       showSelectedLabels: false,
//       showUnselectedLabels: false,
//     );
//   }
// }
//
