// import 'package:flutter/material.dart';
// import 'package:cookmate/pages/home_page.dart';


// class CustomfavAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;
//   final bool goHomeInsteadOfPop; // ✅ เพิ่มตรงนี้

// const CustomfavAppBar({
//     super.key,
//     required this.title,
//     this.goHomeInsteadOfPop = false, // ✅ ให้ค่า default เป็น false
//   });

//   @override
//   Size get preferredSize => Size.fromHeight(150); // ความสูงของ AppBar

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: Color(0XFFFEDB71), // สีพื้นหลัง
//       elevation: 0,
//       automaticallyImplyLeading: false, // ไม่ใช้ปุ่ม back อัตโนมัติ
//       flexibleSpace: SafeArea(
//         child: Stack(
//           children: [
//             // 🔽 รูปถุงกระดาษด้านล่าง
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: _buildPaperBagImage(),
//             ),
//             // 🔼 Row ด้านบน ← Categories 🔔
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 16.0,
//                 vertical: 12.0,
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   // ← + Categories
//                   Row(
//                     children: [
//                       IconButton(
//                           icon: Icon(Icons.arrow_back),
//                           onPressed: () {
//                             if (goHomeInsteadOfPop) {
//                               Navigator.pushNamedAndRemoveUntil(
//                                 context,
//                                 '/home',
//                                 (route) => false,
//                               );
//                             } else {
//                               Navigator.pop(context);
//                             }
//                           },
//                         ),
//                       SizedBox(width: 8),
//                       Text(
//                         title,
//                         style: TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(30),
//           bottomRight: Radius.circular(30),
//         ),
//       ),
//     );
//   }

//   // ภาพถุงกระดาษ
//   Widget _buildPaperBagImage() {
//     return Padding(
//       padding: const EdgeInsets.only(left: 150.0, bottom: 0.5555),
//       child: Center(
//         child: Image.asset(
//           'assets/images/ui/favorite_page.png',
//           width: 200,
//           height: 120,
//           fit: BoxFit.contain,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cookmate/pages/home_page.dart'; // ✅ อย่าลืม import หน้า Home ด้วย

class CustomfavAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool goHomeInsteadOfPop;

  const CustomfavAppBar({
    super.key,
    required this.title,
    this.goHomeInsteadOfPop = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(150);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFFEDB71),
      elevation: 0,
      automaticallyImplyLeading: false,
      flexibleSpace: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: _buildPaperBagImage(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      // IconButton(
                      //   icon: const Icon(Icons.arrow_back),
                      //   onPressed: () {
                      //     if (goHomeInsteadOfPop) {
                      //       Navigator.pushReplacement(
                      //         context,
                      //         MaterialPageRoute(builder: (context) => const HomePage()),
                      //       );
                      //     } else {
                      //       Navigator.pop(context);
                      //     }
                      //   },
                      // ),
                      const SizedBox(width: 8),
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
    );
  }

  Widget _buildPaperBagImage() {
    return Padding(
      padding: const EdgeInsets.only(left: 150.0, bottom: 0.5555),
      child: Center(
        child: Image.asset(
          'assets/images/ui/favorite_page.png',
          width: 200,
          height: 120,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
