import 'package:flutter/material.dart';
import 'package:cookmate/DatabaseHelperTest.dart';
import '/widgets/myingredient_appbar';
import '/widgets/bottom_navbar.dart';
import '/pages/ingredients/categories_page.dart';
import '/pages/ingredients/edit_ingredient_page.dart';

class MyIngredientsPage extends StatefulWidget {
  const MyIngredientsPage({Key? key}) : super(key: key);

  @override
  _MyIngredientsPageState createState() => _MyIngredientsPageState();
}

class _MyIngredientsPageState extends State<MyIngredientsPage> {
  List<Map<String, dynamic>> userIngredients = [];
  List<Map<String, dynamic>> expiredIngredients = [];
  int? _selectedIngredientIndex; 

  @override
  void initState() {
    super.initState();
    _loadUserIngredients();
    _loadExpiringIngredients();
  }

  Future<void> _loadUserIngredients() async {
    final data = await DatabaseHelperTest.fetchUserIngredientsOnly();
    setState(() {
      userIngredients = data;
    });
  }

  Future<void> _loadExpiringIngredients() async {
    final List<Map<String, dynamic>> data =
        await DatabaseHelperTest.fetchUserIngredientsOnly();
    final filtered =
        data.where((Map<String, dynamic> item) {
          final expDateStr = item['exp_date']?.toString();
          if (expDateStr == null || expDateStr.isEmpty) return false;

          final expDate = DateTime.tryParse(expDateStr);
          if (expDate == null) return false;

          final expDateOnly = DateTime(
            expDate.year,
            expDate.month,
            expDate.day,
          );
          final today = DateTime.now();
          final todayDateOnly = DateTime(today.year, today.month, today.day);
          final diffDays = todayDateOnly.difference(expDateOnly).inDays;

          return (expDateOnly.isBefore(todayDateOnly) ||
                  expDateOnly.isAtSameMomentAs(todayDateOnly)) &&
              diffDays <= 3; // หมดอายุแล้วแต่ไม่เกิน 3 วัน
        }).toList();

    setState(() {
      expiredIngredients = filtered;
    });
  }

  Future<void> _clearIngredientDetails(String ingredientName) async {
    await DatabaseHelperTest.clearIngredientDetails(
      ingredientName: ingredientName,
    );
    _loadUserIngredients();
    _loadExpiringIngredients();
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: CustomAppBar(
      title: "Ingredients",
    ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: Color(0xFF2A2C41)),
        child: BottomNavBar(currentIndex: 2),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildExpiringSection(),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'รายละเอียดวัตถุดิบของฉัน',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(Icons.add_circle_outline, size: 28),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => CategoriesPage(
                                ingredientName: '',
                                imagePath: 'assets/images/default.png',
                              ),
                        ),
                      ).then((_) {
                        _loadUserIngredients();
                        _loadExpiringIngredients();
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 12),
              userIngredients.isEmpty
                  ? Center(child: Text('ยังไม่มีวัตถุดิบที่เพิ่มไว้'))
                  : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: userIngredients.length,
                    itemBuilder: (context, index) {
                      final ingredient = userIngredients[index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        color: Color(0xFFE8F1F8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(color: Colors.black),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(
                              ingredient['Categories_image'] ??
                                  'assets/images/default.png',
                            ),
                            backgroundColor: Colors.white,
                          ),
                          title: Text(
                            ingredient['ingredient_name'] ?? '',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (ingredient['description'] != null)
                                Text(
                                  "รายละเอียด: ${ingredient['description']}",
                                ),
                              if (ingredient['expDate'] != null)
                                Text("หมดอายุ: ${ingredient['expDate']}"),
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete_outline),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'คุณแน่ใจหรือไม่ว่าต้องการลบรายละเอียดของ \"${ingredient['ingredient_name']}\" ?',
                                  ),
                                  action: SnackBarAction(
                                    label: 'ยืนยัน',
                                    textColor: Colors.red,
                                    onPressed: () async {
                                      await _clearIngredientDetails(
                                        ingredient['ingredient_name'],
                                      );
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'ลบรายละเอียดเรียบร้อยแล้ว',
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => EditIngredientPage(
                                      ingredientName:
                                          ingredient['ingredient_name'],
                                      description: ingredient['description'],
                                      expDate: ingredient['expDate'],
                                      imagePath:
                                          ingredient['Categories_image'] ??
                                          'assets/images/default.png',
                                    ),
                              ),
                            ).then((_) {
                              _loadUserIngredients();
                              _loadExpiringIngredients();
                            });
                          },
                        ),
                      );
                    },
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpiringSection() {
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
          expiredIngredients.isEmpty
              ? Text('ยังไม่มีรายการใกล้หมดอายุ')
              : Wrap(
                spacing: 12,
                runSpacing: 12,
                children:
                    expiredIngredients.asMap().entries.map((entry) {
                      final index = entry.key;
                      final item = entry.value;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedIngredientIndex =
                                _selectedIngredientIndex == index
                                    ? null
                                    : index;
                          });
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Stack(
                              alignment: Alignment.topRight,
                              children: [
                                _buildAlertItem(
                                  item['Categories_image'] ??
                                      'assets/images/default.png',
                                ),
                                if (_selectedIngredientIndex == index)
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () {
                                        _showDeleteConfirmationDialog(
                                          item['ingredient_name'],
                                        );
                                      },
                                      child: Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.red,
                                            width: 1.5,
                                          ),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.remove,
                                            size: 16,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Text(
                              '${item['ingredient_name']}',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
              ),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(String ingredientName) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('ยืนยันการลบ'),
          content: Text('คุณต้องการลบ "$ingredientName" ใช่หรือไม่?'),
          actions: [
            TextButton(
              child: Text('ยกเลิก'),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
            TextButton(
              child: Text('ลบ', style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // ปิด dialog ก่อน
                // รอให้ dialog ปิดก่อนแล้วค่อยลบ + แสดง snackbar
                Future.delayed(Duration(milliseconds: 100), () async {
                  await _clearIngredientDetails(ingredientName);
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('ลบ "$ingredientName" เรียบร้อยแล้ว'),
                      ),
                    );
                  }
                });
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildAlertItem(String imagePath) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 8),
      child: Container(
        width: 56,
        height: 56,
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
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(imagePath, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}