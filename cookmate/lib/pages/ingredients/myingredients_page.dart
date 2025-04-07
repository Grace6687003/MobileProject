// // import 'package:flutter/material.dart';
// // import '/widgets/ingredient_appbar.dart';
// // import '/widgets/bottom_navbar.dart';

// // class MyIngredientsPage extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: CustomAppBar(title: 'Ingredients'),
// //       bottomNavigationBar: Theme(
// //         data: Theme.of(context).copyWith(
// //           canvasColor: Color(0xFF2A2C41),
// //         ),
// //         child: BottomNavBar(),
// //       ),
// //       body: SingleChildScrollView(
// //         padding: const EdgeInsets.all(16),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             _buildExpiringSection(),
// //             SizedBox(height: 20),
// //             _buildMyIngredientsSection(context),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildExpiringSection() {
// //     return Container(
// //       padding: const EdgeInsets.all(16),
// //       decoration: BoxDecoration(
// //         color: Color(0xFFFFE4DC), // สีพีช
// //         borderRadius: BorderRadius.circular(20),
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             children: [
// //               Text(
// //                 'แจ้งเตือนวันหมดอายุ',
// //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //               ),
// //               Icon(Icons.access_time, size: 28),
// //             ],
// //           ),
// //           SizedBox(height: 12),
// //           Row(
// //             children: [
// //               _buildAlertItem('assets/images/categories/egg.png'),
// //               _buildAlertItem('assets/images/categories/cut_of_meat.png'),
// //               _buildAlertItem('assets/images/categories/green_salad.png'),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildAlertItem(String imagePath) {
// //     return Padding(
// //       padding: const EdgeInsets.only(left: 16.0, bottom: 30),
// //       child: Container(
// //         width: 56,
// //         height: 56,
// //         decoration: BoxDecoration(
// //           shape: BoxShape.circle,
// //           color: Colors.white, // ✅ พื้นหลังสีขาว
// //           border: Border.all(color: Color(0xFFFFE2D7), width: 2),
// //           boxShadow: [
// //             BoxShadow(
// //               color: Colors.black12,
// //               blurRadius: 4,
// //               offset: Offset(0, 2),
// //             ),
// //           ],
// //         ),
// //         child: ClipOval(
// //           child: Image.asset(imagePath, fit: BoxFit.cover),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildMyIngredientsSection(BuildContext context) {
// //     return Container(
// //       padding: const EdgeInsets.only(left: 16.0, bottom: 200),
// //       decoration: BoxDecoration(
// //         color: Color(0xFFE8F1F8), // สีฟ้าอ่อน
// //         borderRadius: BorderRadius.circular(20),
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             children: [
// //               Text(
// //                 'วัตถุดิบของฉัน',
// //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //               ),
// //               IconButton(
// //                 icon: Icon(Icons.add_circle_outline, size: 28),
// //                 onPressed: () {
// //                   Navigator.pushNamed(context, '/categories');
// //                 },
// //               ),
// //             ],
// //           ),
// //           SizedBox(height: 12),
// //           Wrap(
// //             spacing: 12,
// //             children: [
// //               _buildIngredientItem('assets/images/categories/green_salad.png'),
// //               _buildIngredientItem('assets/images/categories/green_salad.png'),
// //               _buildIngredientItem('assets/images/categories/cut_of_meat.png'),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildIngredientItem(String imagePath) {
// //     return Container(
// //       width: 56,
// //       height: 56,
// //       decoration: BoxDecoration(
// //         shape: BoxShape.circle,
// //         color: Colors.white,
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black12,
// //             blurRadius: 4,
// //             offset: Offset(0, 2),
// //           ),
// //         ],
// //       ),
// //       child: ClipOval(
// //         child: Image.asset(imagePath, fit: BoxFit.cover),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import '/widgets/ingredient_appbar.dart';
// import '/widgets/bottom_navbar.dart';

// class MyIngredientsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(title: 'Ingredients'),
//       bottomNavigationBar: Theme(
//         data: Theme.of(context).copyWith(
//           canvasColor: Color(0xFF2A2C41),
//         ),
//         child: BottomNavBar(),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildExpiringSection(),
//             SizedBox(height: 20),
//             _buildMyIngredientsSection(context),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildExpiringSection() {
//     // ✅ ใช้ List เพื่อรองรับจำนวนไอเทมที่เปลี่ยนได้
//     final List<String> expiringItems = [
//       'assets/images/categories/egg.png',
//       'assets/images/categories/cut_of_meat.png',
//       'assets/images/categories/green_salad.png',
//       // สามารถเพิ่มรายการอื่น ๆ ได้
//     ];

//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Color(0xFFFFE4DC),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'แจ้งเตือนวันหมดอายุ',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               Icon(Icons.access_time, size: 28),
//             ],
//           ),
//           SizedBox(height: 12),
//           Wrap(
//             spacing: 12,
//             runSpacing: 12,
//             children: expiringItems.map((img) => _buildAlertItem(img)).toList(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildAlertItem(String imagePath) {
//     return Container(
//       width: 56,
//       height: 56,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: Colors.white,
//         border: Border.all(color: Color(0xFFFFE2D7), width: 2),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 4,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: ClipOval(
//         child: Image.asset(imagePath, fit: BoxFit.cover),
//       ),
//     );
//   }

//   Widget _buildMyIngredientsSection(BuildContext context) {
//     // ✅ ใช้ List เหมือนกันเพื่อเพิ่ม/ลดได้ในอนาคต
//     final List<String> myIngredients = [
//       'assets/images/categories/green_salad.png',
//       'assets/images/categories/green_salad.png',
//       'assets/images/categories/cut_of_meat.png',
//     ];

//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Color(0xFFE8F1F8),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'วัตถุดิบของฉัน',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               IconButton(
//                 icon: Icon(Icons.add_circle_outline, size: 28),
//                 onPressed: () {
//                   Navigator.pushNamed(context, '/categories');
//                 },
//               ),
//             ],
//           ),
//           SizedBox(height: 12),
//           Wrap(
//             spacing: 12,
//             runSpacing: 12,
//             children: myIngredients.map((img) => _buildIngredientItem(img)).toList(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildIngredientItem(String imagePath) {
//     return Container(
//       width: 56,
//       height: 56,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 4,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: ClipOval(
//         child: Image.asset(imagePath, fit: BoxFit.cover),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '/widgets/ingredient_appbar.dart';
import '/widgets/bottom_navbar.dart';
import '/pages/ingredients/categories_page.dart';

class MyIngredientsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Ingredients'),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: Color(0xFF2A2C41)),
        child: BottomNavBar(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildExpiringSection(),
            SizedBox(height: 20),
            _buildMyIngredientsSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildExpiringSection() {
    final List<String> expiringItems = [
      'assets/images/categories/egg.png',
      'assets/images/categories/cut_of_meat.png',
      'assets/images/categories/green_salad.png',
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFFFE4DC),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'แจ้งเตือนวันหมดอายุ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Icon(Icons.access_time, size: 28),
            ],
          ),
          SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: expiringItems.map((img) => _buildAlertItem(img)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertItem(String imagePath) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 30),
      child: Container(
        width: 56, // ขนาดของวงกลม 56x56
        height: 56, // ขนาดของวงกลม 56x56
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(color: Color(0xFFFFE2D7), width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ClipOval(
          child: Padding(
            padding: const EdgeInsets.all(8.0), // เพิ่ม padding รอบๆ รูปไอคอน
            child: Image.asset(imagePath, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }

  Widget _buildMyIngredientsSection(BuildContext context) {
    final List<String> myIngredients = [
      'assets/images/categories/green_salad.png',
      'assets/images/categories/green_salad.png',
      'assets/images/categories/cut_of_meat.png',
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFE8F1F8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'วัตถุดิบของฉัน',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.add_circle_outline, size: 28),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  CategoriesPage(),
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children:
                myIngredients.map((img) => _buildIngredientItem(img)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildIngredientItem(String imagePath) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 30),
      child: Container(
        width: 56, // ขนาดของวงกลม 56x56
        height: 56, // ขนาดของวงกลม 56x56
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ClipOval(
          child: Padding(
            padding: const EdgeInsets.all(8.0), // เพิ่ม padding รอบๆ รูปไอคอน
            child: Image.asset(imagePath, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
