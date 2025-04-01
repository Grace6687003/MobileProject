


// import 'package:flutter/material.dart';

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;

//   CustomAppBar({required this.title});

//   @override
//   Size get preferredSize => Size.fromHeight(120); // Adjust the AppBar height

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: Colors.yellow, // Match the yellow background color
//       elevation: 0, // No shadow
//       automaticallyImplyLeading: false, // Disable automatic back button if using a custom one
//       title: Container(
//         height: 100, // Set a specific height for the container
//         child: Stack(
//           children: [
//             // Positioned Title (Ingredients) on the bottom-left
//             Positioned(
//               left: 16.0,
//               bottom: 16.0,
//               child: Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: 24, // Adjust font size for the title
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             // Positioned Bell Icon on the bottom-right
//             Positioned(
//               right: 10.0,
//               bottom: 16.0,
//               child: IconButton(
//                 icon: Icon(Icons.notifications),
//                 onPressed: () {
//                   // Handle the bell icon action here
//                 },
//               ),
//             ),
//             // Positioned Paper Bag Image centered at the bottom
//             Positioned(
//               bottom: 20,
//               left: MediaQuery.of(context).size.width / 2 - 60, // Centering the image horizontally
//               child: Image.asset(
//                 'assets/images/ui/paper_bag_full_of_groceries.png',
//                 width: 60, // Adjust the width as needed
//                 height: 60, // Adjust the height as needed
//                 fit: BoxFit.contain, // Prevent the image from being cut off
//               ),
//             ),
//           ],
//         ),
//       ),
//       leading: IconButton(
//         icon: Icon(Icons.arrow_back),
//         onPressed: () {
//           Navigator.pop(context); // Handle back button press
//         },
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;

//   CustomAppBar({required this.title});

//   @override
//   Size get preferredSize => Size.fromHeight(150); // เพิ่มความสูงของ AppBar

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: Colors.yellow, // Match the yellow background color
//       elevation: 0, // No shadow
//       automaticallyImplyLeading: false, // Disable automatic back button if using a custom one
//       title: Container(
//         height: 120, // เพิ่มขนาดเพื่อให้มีพื้นที่สำหรับเนื้อหา
//         padding: EdgeInsets.only(bottom: 20), // เพิ่ม padding ด้านล่างเพื่อให้เนื้อหาดูห่างจากขอบ
//         child: Stack(
//           children: [
//             // Positioned Title (Ingredients) on the bottom-left
//             Positioned(
//               left: 16.0,
//               bottom: 1.0, // Move it closer to the bottom of the AppBar
//               child: Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: 24, // Adjust font size for the title
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             // Positioned Bell Icon on the bottom-right
//             Positioned(
//               right: 10.0,
//               bottom: 10.0, // Move it closer to the bottom
//               child: IconButton(
//                 icon: Icon(Icons.notifications),
//                 onPressed: () {
//                   // Handle the bell icon action here
//                 },
//               ),
//             ),
//             // Positioned Paper Bag Image centered at the bottom
//             Positioned(
//               bottom: 5, // Move it closer to the bottom of the AppBar
//               left: MediaQuery.of(context).size.width / 2 - 30, // Centering the image horizontally
//               child: Image.asset(
//                 'assets/images/ui/paper_bag_full_of_groceries.png',
//                 width: 60, // Adjust the width as needed
//                 height: 60, // Adjust the height as needed
//                 fit: BoxFit.contain, // Prevent the image from being cut off
//               ),
//             ),
//           ],
//         ),
//       ),
//       leading: IconButton(
//         icon: Icon(Icons.arrow_back),
//         onPressed: () {
//           Navigator.pop(context); // Handle back button press
//         },
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;

//   CustomAppBar({required this.title});

//   @override
//   Size get preferredSize => Size.fromHeight(150); // ความสูงของ AppBar

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: Colors.yellow, // สีพื้นหลังที่ตรงกับภาพ
//       elevation: 0, // ไม่มีเงา
//       automaticallyImplyLeading: false, // ไม่ให้มีปุ่ม back อัตโนมัติ
//       leading: IconButton(
//         icon: Icon(Icons.arrow_back),
//         onPressed: () {
//           Navigator.pop(context); // การกระทำเมื่อกดปุ่ม back
//         },
//       ),
//       flexibleSpace: Column(
//         mainAxisAlignment: MainAxisAlignment.end, // จัดตำแหน่งให้ชิดด้านล่าง
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 5.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween, // จัดตำแหน่งไอคอนให้ห่างกัน
//               children: [
//                 // Positioned Title (Ingredients)
//                 Text(
//                   title,
//                   style: TextStyle(
//                     fontSize: 24, // ขนาดตัวอักษร
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 // Bell Icon
//                 IconButton(
//                   icon: Icon(Icons.notifications),
//                   onPressed: () {
//                     // การกระทำเมื่อกดปุ่ม Bell Icon
//                   },
//                 ),
//               ],
//             ),
//           ),
//           // Paper Bag Image
//           Padding(
//             padding: const EdgeInsets.only(right: 1.0, bottom: 0.1),
//             child: Center(
//               child: Image.asset(
//                 'assets/images/ui/paper_bag_full_of_groceries.png',
//                 width: 120, // ปรับขนาดภาพ
//                 height: 120, // ปรับขนาดภาพ
//                 fit: BoxFit.contain, // ให้ภาพไม่ถูกตัด
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;

//   CustomAppBar({required this.title});

//   @override
//   Size get preferredSize => Size.fromHeight(150); // ความสูงของ AppBar

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: Color(0XFFFEDB71), // สีพื้นหลังที่ตรงกับภาพ
//       elevation: 0, // ไม่มีเงา
//       automaticallyImplyLeading: false, // ไม่ให้มีปุ่ม back อัตโนมัติ
//       leading: IconButton(
//         icon: Icon(Icons.arrow_back),
//         onPressed: () {
//           Navigator.pop(context); // การกระทำเมื่อกดปุ่ม back
//         },
//       ),
//       flexibleSpace: Column(
//         mainAxisAlignment: MainAxisAlignment.end, // จัดตำแหน่งให้ชิดด้านล่าง
//         children: [
//           _buildTitleAndBell(),
//           _buildPaperBagImage(),
//         ],
//       ),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(30), // มุมด้านล่างซ้าย
//           bottomRight: Radius.circular(30), // มุมด้านล่างขวา
//         ),
//       ),
//     );
//   }

//   Widget _buildTitleAndBell() {
//   return Padding(
//     padding: const EdgeInsets.only(left: 50.0, right: 16.0),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.end, // จัดให้ text และ icon อยู่ด้านล่างสุด
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween, // จัดตำแหน่งไอคอน
//           children: [
//             // Positioned Title (Ingredients) ที่ชิดด้านล่าง
//             Align(
//               alignment: Alignment.bottomLeft,
//               child: Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: 24, // ขนาดตัวอักษร
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             // Bell Icon ที่ชิดขอบขวา
//             Align(
//               alignment: Alignment.bottomRight,
//               child: IconButton(
//                 icon: Icon(Icons.notifications),
//                 onPressed: () {
//                   // การกระทำเมื่อกดปุ่ม Bell Icon
//                 },
//               ),
//             ),
//           ],
//         ),
//       ],
//     ),
//   );
// }


//   // Function for Paper Bag Image
//   Widget _buildPaperBagImage() {
//     return Padding(
//       padding: const EdgeInsets.only(left: 150.0, bottom: 0.5555),
//       child: Center(
//         child: Image.asset(
//           'assets/images/ui/paper_bag_full_of_groceries.png',
//           width: 200, // ปรับขนาดภาพ
//           height: 120, // ปรับขนาดภาพ
//           fit: BoxFit.contain, // ให้ภาพไม่ถูกตัด
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CustomAppBar({required this.title});

  @override
  Size get preferredSize => Size.fromHeight(150); // ความสูงของ AppBar

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0XFFFEDB71), // สีพื้นหลัง
      elevation: 0,
      automaticallyImplyLeading: false, // ไม่ใช้ปุ่ม back อัตโนมัติ
      flexibleSpace: SafeArea(
        child: Stack(
          children: [
            // 🔽 รูปถุงกระดาษด้านล่าง
            Align(
              alignment: Alignment.bottomCenter,
              child: _buildPaperBagImage(),
            ),
            // 🔼 Row ด้านบน ← Categories 🔔
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // ← + Categories
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(width: 8),
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  // 🔔
                  IconButton(
                    icon: Icon(Icons.notifications),
                    onPressed: () {
                      // การกระทำเมื่อกด Bell
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
    );
  }

  // ภาพถุงกระดาษ
  Widget _buildPaperBagImage() {
    return Padding(
      padding: const EdgeInsets.only(left: 150.0, bottom: 0.5555),
      child: Center(
        child: Image.asset(
          'assets/images/ui/paper_bag_full_of_groceries.png',
          width: 200,
          height: 120,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

