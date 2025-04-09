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
import 'package:cookmate/DatabaseHelperTest.dart';

class MyIngredientsPage extends StatefulWidget {
  @override
  _MyIngredientsPageState createState() => _MyIngredientsPageState();
}

class _MyIngredientsPageState extends State<MyIngredientsPage> {
  List<String> myIngredients = []; // เปลี่ยนเป็น List ที่สามารถปรับได้

  @override
  void initState() {
    super.initState();
    loadMyIngredients(); // ดึงข้อมูลเมื่อเริ่มต้น
  }

  // ฟังก์ชันสำหรับดึงข้อมูลจากฐานข้อมูล
  void loadMyIngredients() async {
    final ingredients = await DatabaseHelperTest.fetchAllIngredients(); // สมมุติว่าเป็นฟังก์ชันในการดึงข้อมูล
    setState(() {
      myIngredients = ingredients.map((item) => item['ingredient_name'] ?? '').toList();
    });
  }
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
      'assets/images/categories/meat.png',
      'assets/images/categories/vegetable.png',
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
      'assets/images/categories/vegetable.png',
      'assets/images/categories/vegetable.png',
      'assets/images/categories/meat.png',
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



// import 'package:flutter/material.dart';
// import '/widgets/ingredient_appbar.dart';
// import '/widgets/bottom_navbar.dart';
// import '/pages/ingredients/add_ingredient_page.dart'; // แก้ไขให้เป็น path ที่ถูกต้อง
// import '/pages/ingredients/categories_page.dart';
// import 'package:cookmate/DatabaseHelperTest.dart'; // นำเข้า DatabaseHelperTest

// class MyIngredientsPage extends StatefulWidget {
//   @override
//   _MyIngredientsPageState createState() => _MyIngredientsPageState();
// }

// class _MyIngredientsPageState extends State<MyIngredientsPage> {
//   List<Map<String, String>> myIngredients = []; // รายการวัตถุดิบ
//   List<Map<String, String>> expiringIngredients = []; // รายการวัตถุดิบที่ใกล้หมดอายุ

//   @override
//   void initState() {
//     super.initState();
//     loadMyIngredients(); // ดึงข้อมูลเมื่อเริ่มต้น
//     loadExpiringIngredients(); // ดึงข้อมูลวัตถุดิบที่ใกล้หมดอายุ
//   }


//   // ฟังก์ชันสำหรับดึงข้อมูลวัตถุดิบทั้งหมดจากฐานข้อมูล
//   void loadMyIngredients() async {
//     final ingredients = await DatabaseHelperTest.fetchAllIngredients(); // ฟังก์ชันดึงข้อมูลทั้งหมดจากฐานข้อมูล
//     setState(() {
//       myIngredients = ingredients; // อัปเดตข้อมูลที่ได้มา
//     });
//   }

//   // ฟังก์ชันสำหรับดึงข้อมูลวัตถุดิบที่ใกล้หมดอายุ
//   void loadExpiringIngredients() async {
//     final expiring = await DatabaseHelperTest.fetchExpiringIngredients(); // ฟังก์ชันดึงข้อมูลวัตถุดิบที่ใกล้หมดอายุ
//     setState(() {
//       expiringIngredients = expiring; // อัปเดตข้อมูลที่ใกล้หมดอายุ
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(title: 'Ingredients'),
//       bottomNavigationBar: Theme(
//         data: Theme.of(context).copyWith(canvasColor: Color(0xFF2A2C41)),
//         child: BottomNavBar(),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildExpiringSection(), // ส่วนแจ้งเตือนวันหมดอายุ
//             SizedBox(height: 20),
//             _buildMyIngredientsSection(context), // ส่วนของวัตถุดิบของฉัน
//           ],
//         ),
//       ),
//     );
//   }

//   // ส่วนแสดงวัตถุดิบที่ใกล้หมดอายุ
//   Widget _buildExpiringSection() {
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
//           // ตรวจสอบว่ามีวัตถุดิบใกล้หมดอายุหรือไม่ ถ้าไม่มีจะแสดงข้อความว่า "ไม่มี"
//           expiringIngredients.isEmpty
//               ? Center(child: Text("ไม่มีวัตถุดิบใกล้หมดอายุ"))
//               : Wrap(
//                   spacing: 12,
//                   runSpacing: 12,
//                   children: expiringIngredients.map((ingredient) {
//                     return _buildIngredientItem(ingredient);
//                   }).toList(),
//                 ),
//         ],
//       ),
//     );
//   }

//   // ส่วนแสดงวัตถุดิบของฉัน
// Widget _buildMyIngredientsSection(BuildContext context) {
//   return Container(
//     padding: const EdgeInsets.all(16),
//     decoration: BoxDecoration(
//       color: Color(0xFFE8F1F8),
//       borderRadius: BorderRadius.circular(20),
//     ),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               'วัตถุดิบของฉัน',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             IconButton(
//               icon: Icon(Icons.add_circle_outline, size: 28),
//               onPressed: () {
//                   // เมื่อกด "+" ไปหน้า Add Ingredient
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder:
//                           (context) => AddIngredientPage(
//                             ingredientName: "Your Ingredient",
//                             imagePath: "assets/images/your_image.png",
//                           ),
//                     ),

//                 ).then((_) {
//                   loadMyIngredients(); // โหลดข้อมูลใหม่เมื่อกลับมา
//                   loadExpiringIngredients(); // โหลดข้อมูลที่ใกล้หมดอายุเมื่อกลับมา
//                 });
//               },
//             ),
//           ],
//         ),
//         SizedBox(height: 12),
//         // ตรวจสอบว่า myIngredients ว่างหรือไม่ ถ้าว่างจะแสดงข้อความ "ไม่มีวัตถุดิบ"
//         myIngredients.isEmpty
//             ? Center(child: Text("ไม่มีวัตถุดิบ"))
//             : Wrap(
//                 spacing: 12,
//                 runSpacing: 12,
//                 children: myIngredients.map((ingredient) {
//                   return _buildIngredientItem(ingredient);
//                 }).toList(),
//               ),
//       ],
//     ),
//   );
// }


//   // ฟังก์ชันที่ใช้แสดงไอเทมวัตถุดิบ
//   Widget _buildIngredientItem(Map<String, String> ingredient) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 16.0, bottom: 30),
//       child: Container(
//         width: 56, // ขนาดของวงกลม 56x56
//         height: 56, // ขนาดของวงกลม 56x56
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black12,
//               blurRadius: 4,
//               offset: Offset(0, 2),
//             ),
//           ],
//         ),
//         child: ClipOval(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0), // เพิ่ม padding รอบๆ รูปไอคอน
//             child: Image.asset(ingredient['ingredient_image'] ?? '', fit: BoxFit.cover), // ใช้ภาพจาก local หรือ URL
//           ),
//         ),
//       ),
//     );
//   }
// }
