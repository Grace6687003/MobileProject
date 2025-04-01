

// // import 'package:flutter/material.dart';

// // class BottomNavBar extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return BottomNavigationBar(
// //       items: [
// //         BottomNavigationBarItem(
// //           icon: Image.asset('assets/images/ui/solar_chef-hat-bold.png'),
// //           label: '', // ซ่อนข้อความ
// //         ),
// //         BottomNavigationBarItem(
// //           icon: Image.asset('assets/images/ui/search.png'),
// //           label: '',
// //         ),
// //         BottomNavigationBarItem(
// //           icon: Image.asset('assets/images/ui/task.png'),
// //           label: '',
// //         ),
// //         BottomNavigationBarItem(
// //           icon: Image.asset('assets/images/ui/fav.png'),
// //           label: '',
// //         ),
// //       ],
// //       currentIndex: 0,
// //       onTap: (index) {
// //         // Handle tab change here
// //       },
// //       backgroundColor: Color(0xFF2A2C41), // สีพื้นหลัง
// //       unselectedItemColor: Color(0xFF9195B7), // สีไอคอนที่ไม่ได้เลือก
// //       selectedItemColor: Colors.white, // สีไอคอนที่เลือก
// //       type: BottomNavigationBarType.fixed,
// //       showSelectedLabels: false,
// //       showUnselectedLabels: false,
// //     );
// //   }
// // }


// import 'package:flutter/material.dart';
// import 'package:list_page/pages/fav_page.dart'; // นำเข้า FavPage
// import 'package:list_page/pages/ingredients/myingredients_page.dart';

// class BottomNavBar extends StatefulWidget {
//   @override
//   _BottomNavBarState createState() => _BottomNavBarState();
// }

// class _BottomNavBarState extends State<BottomNavBar> {
//   int _currentIndex = 0; // ตัวแปรสำหรับเก็บการเลือกหน้า

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
//       currentIndex: _currentIndex,
//       onTap: (index) {
//         setState(() {
//           _currentIndex = index; // อัพเดต currentIndex
//         });

//         // ตรวจสอบว่าเป็นปุ่มที่เลือก 'Fav' หรือไม่
//         if (index == 3) {
//           // ไปที่หน้า 'Favorites' และแทนที่หน้าปัจจุบัน
//           Navigator.pushReplacementNamed(context, '/favorites');
//         }
//         // เพิ่มการนำทางสำหรับ index อื่นๆ ตามต้องการ
//         else if (index == 0) {
//           Navigator.pushReplacementNamed(context, '/my-ingredients');
//         } else if (index == 1) {
//           Navigator.pushReplacementNamed(context, '/categories');
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


import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    if (index == 2) {
      Navigator.pushReplacementNamed(context, '/my-ingredients');
    } else if (index == 3) {
      Navigator.pushReplacementNamed(context, '/favorites');
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
        items: [
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 24,
              child: Image.asset('assets/images/ui/solar_chef-hat-bold.png'),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 24,
              child: Image.asset('assets/images/ui/search.png'),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 24,
              child: Image.asset('assets/images/ui/task.png'),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 24,
              child: Image.asset('assets/images/ui/fav.png'),
            ),
            label: '',
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color(0xFF9195B7),
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
