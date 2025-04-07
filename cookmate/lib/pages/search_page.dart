import 'package:flutter/material.dart';
import '../widgets/search_menu_card.dart';
import '../widgets/bottom_navbar.dart'; // ✅ เพิ่มตรงนี้

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> menuNames = [
    'ปอเปี๊ยะทอด',
    'ไข่ตุ๋น',
    'สลัดไก่ย่าง',
    'ผัดผัก',
    'ผัดผักบุ้ง',
  ];

  List<String> menuImages = [
    'assets/images/menu/REC014.jpg',
    'assets/images/menu/REC014.jpg',
    'assets/images/menu/REC014.jpg',
    'assets/images/menu/REC014.jpg',
    'assets/images/menu/REC014.jpg',
  ];

  List<String> filteredMenus = [];

  @override
  void initState() {
    super.initState();
    filteredMenus = menuNames;
  }

  void _searchMenu(String query) {
    final filtered = menuNames.where((menu) {
      return menu.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredMenus = filtered;
    });
  }

  void _filterByIngredients() {
    setState(() {
      filteredMenus = menuNames;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('ค้นหาเมนู'),
      // ),
      backgroundColor: const Color(0xFFF9F9F9),
      bottomNavigationBar: BottomNavBar(), // ✅ เพิ่มตรงนี้
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔍 ช่องค้นหาพร้อมเงา
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

            const SizedBox(height: 22),

            // 🔘 ปุ่มกรอง
            Row(
              children: [
                SizedBox(
                  width: 124,
                  height: 38,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        filteredMenus = menuNames;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
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
                    onPressed: _filterByIngredients,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
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

            const SizedBox(height: 16),

            // 📋 รายการเมนู
            Expanded(
              child: ListView.builder(
                itemCount: filteredMenus.length,
                itemBuilder: (context, index) {
                  final originalIndex = menuNames.indexOf(filteredMenus[index]);
                  return SearchMenuCard(
                    menuName: filteredMenus[index],
                    imagePath: menuImages[originalIndex],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
