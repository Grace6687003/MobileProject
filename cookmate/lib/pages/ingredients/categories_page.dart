import 'package:flutter/material.dart';
import '/widgets/bottom_navbar.dart';
import '/widgets/categories_appbar.dart';
import 'add_ingredient_page.dart'; 

class CategoriesPage extends StatelessWidget {
  final String ingredientName;
  final String imagePath;

  CategoriesPage({required this.ingredientName, required this.imagePath});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Categories'),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Color(0xFF2A2C41), 
        ),
        child: BottomNavBar(currentIndex: -1),
      ),
      body: Container(
        color: Colors.white, 
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('หมวดหมู่ของวัตถุดิบ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
       
            Container(
              padding: const EdgeInsets.only(left: 16.0, top: 50.0, bottom: 166), 
              decoration: BoxDecoration(
                color: Color(0xFFE8F1F8), 
                borderRadius: BorderRadius.circular(20), 
              ),
              child: GridView.count(
                shrinkWrap: true, 
                crossAxisCount: 3,
                crossAxisSpacing: 20,
                mainAxisSpacing: 10,
                children: [
                  _buildCategoryItem('เนื้อสัตว์', 'assets/images/categories/meat.png', 56, 56, context),
                  _buildCategoryItem('ผลิตภัณฑ์นม', 'assets/images/categories/milk.png', 56, 56, context),
                  _buildCategoryItem('ไข่', 'assets/images/categories/egg.png', 56, 56, context),
                  _buildCategoryItem('แป้ง', 'assets/images/categories/bread.png', 56, 56, context),
                  _buildCategoryItem('ผัก', 'assets/images/categories/vegetable.png', 56, 56, context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildCategoryItem(String title, String imagePath, double width, double height, BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddIngredientPage(
            ingredientName: title,
            imagePath: imagePath,
          ),
        ),
      );
    },
    child: Column(
      children: [
        Container(
          width: width,
          height: height,
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
              padding: const EdgeInsets.all(8.0), 
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(title, style: TextStyle(fontSize: 16)),
      ],
    ),
  );
}
