// import 'package:flutter/material.dart';
// import '/widgets/bottom_navbar.dart';
// import '/widgets/fav_appbar.dart';

// class FavPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomfavAppBar(title: 'Favorites'),
//       bottomNavigationBar: Theme(
//         data: Theme.of(context).copyWith(canvasColor: Color(0xFF2A2C41)),
//         child: BottomNavBar(),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Title
//             Padding(
//               padding: const EdgeInsets.only(top: 16.0),
//               child: Text(
//                 'Favorites',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//             SizedBox(height: 16),
//             // GridView of favorite menu items using GridView.builder
//             Expanded(
//               child: GridView.builder(
//                 itemCount: 4, // Number of items
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2, // 2 items per row
//                   crossAxisSpacing: 16,
//                   mainAxisSpacing: 16,
//                   childAspectRatio:
//                       0.75, // Adjust the aspect ratio of each item to avoid overflow
//                 ),
//                 // itemBuilder: (BuildContext context, int index) {
//                 //   return _buildFavoriteItem(
//                 //     'assets/images/menu/REC0${index + 1}.jpg',
//                 //     ['ซุปแกงจืดเต้าหู้หมูสับ', 'มาม่าผัด', 'เกี๊ยบน้ำหมูสับ', 'ไข่เจียวหมูสับ'][index],
//                 //   );
//                 // },
//                 itemBuilder: (BuildContext context, int index) {
//                   // ใช้การตรวจสอบเพื่อดูว่าไฟล์ภาพนั้นมีอยู่จริงหรือไม่
//                   String imagePath = 'assets/images/menu/REC0${index + 1}.jpg';

//                   // ตรวจสอบว่าไฟล์ภาพมีอยู่ใน assets หรือไม่ (แสดงข้อความผิดพลาดเมื่อไม่พบไฟล์)
//                   try {
//                     return _buildFavoriteItem(
//                       imagePath,
//                       [
//                         'ซุปแกงจืดเต้าหู้หมูสับ',
//                         'มาม่าผัด',
//                         'เกี๊ยบน้ำหมูสับ',
//                         'ไข่เจียวหมูสับ',
//                       ][index],
//                     );
//                   } catch (e) {
//                     // หากไม่พบไฟล์ภาพ จะแสดงภาพ default หรือข้อความผิดพลาด
//                     return _buildFavoriteItem(
//                       'assets/images/ui/default_image.png', // ใช้ภาพ default เมื่อไม่พบไฟล์
//                       [
//                         'ซุปแกงจืดเต้าหู้หมูสับ',
//                         'มาม่าผัด',
//                         'เกี๊ยบน้ำหมูสับ',
//                         'ไข่เจียวหมูสับ',
//                       ][index],
//                     );
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildFavoriteItem(String imagePath, String title) {
//     return GestureDetector(
//       onTap: () {
//         // Navigate to details or handle favorite action
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.greenAccent[100], // Background color of the item
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black12,
//               blurRadius: 4,
//               offset: Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Image
//             ClipRRect(
//               borderRadius: BorderRadius.circular(16),
//               child: Image.asset(
//                 imagePath,
//                 width: double.infinity,
//                 height: 120,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             SizedBox(height: 8),
//             // Title
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8.0),
//               child: Text(
//                 title,
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//             ),
//             // Favorite Icon
//             Align(
//               alignment: Alignment.centerRight,
//               child: IconButton(
//                 icon: Icon(Icons.favorite_border, color: Colors.red),
//                 onPressed: () {
//                   // Handle favorite action
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '/widgets/bottom_navbar.dart';
import '/widgets/fav_appbar.dart';

class FavPage extends StatelessWidget {
  final List<Map<String, String>> favoriteItems = [
    {
      'image': 'assets/images/menu/REC001.jpg',
      'title': 'ซุปแกงจืดเต้าหู้หมูสับ',
    },
    {
      'image': 'assets/images/menu/REC002.jpg',
      'title': 'มาม่าผัด',
    },
    {
      'image': 'assets/images/menu/REC003.jpg',
      'title': 'เกี๊ยบน้ำหมูสับ',
    },
    {
      'image': 'assets/images/menu/REC004.jpg',
      'title': 'ไข่ออมเล็ต',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomfavAppBar(title: 'Favorites'),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: const Color(0xFF2A2C41)),
        child: BottomNavBar(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                itemCount: favoriteItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.72,
                ),
                itemBuilder: (context, index) {
                  final item = favoriteItems[index];
                  return _buildFavoriteItem(item['image']!, item['title']!);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoriteItem(String imagePath, String title) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to detail page
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // พื้นหลังหลัก
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // รูปภาพ (สูง 3/4 ของ container)
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/ui/default_image.png',
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
            // พื้นที่ด้านล่างที่เป็นกล่องเขียว
            Expanded(
              flex: 1,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFC3E090), // เขียวอ่อน
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ชื่ออาหาร
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        softWrap: true,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

