// import 'package:flutter/material.dart';
// import '/widgets/bottom_navbar.dart';

// class AddIngredientPage extends StatefulWidget {
//   final String ingredientName;
//   final String imagePath;

//   const AddIngredientPage({
//     super.key,
//     required this.ingredientName,
//     required this.imagePath,
//   });

//   @override
//   _AddIngredientPageState createState() => _AddIngredientPageState();
// }

// class _AddIngredientPageState extends State<AddIngredientPage> {
//   TextEditingController _dateController = TextEditingController();
//   DateTime currentDate = DateTime.now(); 
//   String? selectedDate;
//   String? selectedIngredient; 
//   FocusNode _focusNode = FocusNode(); 

//   final List<String> ingredientList = [
//     'เนื้อสัตว์',
//     'ผลิตภัณฑ์นม',
//     'ไข่',
//     'ขนมปัง',
//     'ผัก',
//   ];

//   @override
//   void dispose() {
//     _dateController.dispose();
//     _focusNode.dispose(); 
//     super.dispose();
//   }

//   void _calculateDate(int daysToAdd) {
//     setState(() {
//       DateTime newDate = currentDate.add(Duration(days: daysToAdd));
//       selectedDate = "${newDate.toLocal()}".split(' ')[0]; 
//       _dateController.text = selectedDate ?? '';
//     });
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(), 
//       firstDate: DateTime(2000), 
//       lastDate: DateTime(2101), 
//     );

//     if (picked != null) {
//       setState(() {
//         selectedDate =
//             "${picked.toLocal()}".split(' ')[0]; 
//         _dateController.text = selectedDate ?? ''; 
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           'Add Ingredient',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//             fontSize: 24,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       bottomNavigationBar: Theme(
//         data: Theme.of(context).copyWith(canvasColor: Color(0xFF2A2C41)),
//         child: BottomNavBar(),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(8), 
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(
//                     color: Colors.black, 
//                     width: 1, 
//                   ),
//                 ),
//                 child: CircleAvatar(
//                   radius: 60,
//                   backgroundColor: Colors.white, 
//                   backgroundImage: AssetImage(widget.imagePath),
//                 ),
//               ),
//               SizedBox(height: 24),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'ชื่อวัตถุดิบ *',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                 ),
//               ),
//               SizedBox(height: 8),
//               Container(
//                 height: 48,
//                 padding: EdgeInsets.symmetric(horizontal: 12),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.black),
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: DropdownButton<String>(
//                   value: selectedIngredient,
//                   hint: Text('เลือกวัตถุดิบ'),
//                   isExpanded: true,
//                   items: ingredientList.map((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//                   onChanged: (String? newValue) {
//                     setState(() {
//                       selectedIngredient = newValue;
//                     });
//                   },
//                 ),
//               ),
//               SizedBox(height: 20),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'รายละเอียด',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                 ),
//               ),
//               SizedBox(height: 8),
//               TextField(
//                 maxLines: 2,
//                 decoration: InputDecoration(
//                   hintText: 'เช่น ปริมาณ 1 ถุง, ยี่ห้อ xxx',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'วันที่หมดอายุ',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                 ),
//               ),
//               SizedBox(height: 12),
//               Wrap(
//                 spacing: 12,
//                 runSpacing: 12,
//                 children: List.generate(7, (i) {
//                   return GestureDetector(
//                     onTap: () {
//                       _calculateDate(i + 1); 
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Color(0xFFFEDB71),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 8,
//                       ),
//                       child: Text('${i + 1} วัน'),
//                     ),
//                   );
//                 }),
//               ),
//               SizedBox(height: 16),
//               TextField(
//                 controller: _dateController,
//                 enabled: true, 
//                 focusNode: _focusNode, 
//                 decoration: InputDecoration(
//                   labelText: 'เลือกวันที่',
//                   hintText: 'กรุณาเลือกวันที่',
//                   hintStyle: TextStyle(color: Colors.black),
//                   prefixIcon: Icon(Icons.calendar_month, color: Colors.red), 
//                   border: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.black), 
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.blue), 
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                 ),
//                 onTap: () {
//                   _selectDate(context); 
//                 },
//               ),
//               SizedBox(height: 24),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ElevatedButton(
//                     onPressed: () => Navigator.pop(context),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xFFFEA9A4),
//                       shape: RoundedRectangleBorder(
//                         side: BorderSide(color: Colors.black),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 32,
//                         vertical: 12,
//                       ),
//                     ),
//                     child: Text(
//                       'ยกเลิก',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       // TODO: Save to DB
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xFFC3E090),
//                       shape: RoundedRectangleBorder(
//                         side: BorderSide(color: Colors.black),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 32,
//                         vertical: 12,
//                       ),
//                     ),
//                     child: Text(
//                       'บันทึก',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import '/widgets/bottom_navbar.dart';
// import 'package:cookmate/DatabaseHelperTest.dart'; // อย่าลืมเพิ่ม import สำหรับ DatabaseHelper

// class AddIngredientPage extends StatefulWidget {
//   final String ingredientName;
//   final String imagePath;

//   const AddIngredientPage({
//     super.key,
//     required this.ingredientName,
//     required this.imagePath,
//   });

//   @override
//   _AddIngredientPageState createState() => _AddIngredientPageState();
// }

// class _AddIngredientPageState extends State<AddIngredientPage> {
//   TextEditingController _dateController = TextEditingController();
//   DateTime currentDate = DateTime.now(); 
//   String? selectedDate;
//   String? selectedIngredient; 
//   FocusNode _focusNode = FocusNode(); 

//   List<String> ingredientList = [];  // จะถูกโหลดจากฐานข้อมูล

//   @override
//   void dispose() {
//     _dateController.dispose();
//     _focusNode.dispose(); 
//     super.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();
//     // ดึงข้อมูลวัตถุดิบตามหมวดหมู่ที่ผู้ใช้เลือก (จากฐานข้อมูล)
//     // _fetchIngredientsFromDatabase();
//     loadIngredientsByCategory(widget.ingredientName);
//   }

//   // void _fetchIngredientsFromDatabase() async {
//   //   // ดึงข้อมูลวัตถุดิบจากฐานข้อมูล (เช่น หมวดหมู่เนื้อสัตว์)
//   //   List<String> ingredients = await DatabaseHelperTest.fetchIngredientsByCategory(widget.ingredientName);
//   //   setState(() {
//   //     ingredientList = ingredients;  // อัพเดตค่า ingredientList
//   //   });
//   // }
//   void loadIngredientsByCategory(String category) async {
//     final ingredients = await DatabaseHelperTest.fetchIngredientsByCategory(
//       category,
//     );
//     print("RAW from DB: $ingredients"); 
    
//     setState(() {
//       ingredientList = ingredients.map((item) => item['ingredient_name'] ?? '').toList(); // ✅ แก้ตรงนี้
//       print("ingredientList: $ingredientList"); 
//     });
//   }

//   void _calculateDate(int daysToAdd) {
//     setState(() {
//       DateTime newDate = currentDate.add(Duration(days: daysToAdd));
//       selectedDate = "${newDate.toLocal()}".split(' ')[0]; 
//       _dateController.text = selectedDate ?? '';
//     });
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(), 
//       firstDate: DateTime(2000), 
//       lastDate: DateTime(2101), 
//     );

//     if (picked != null) {
//       setState(() {
//         selectedDate =
//             "${picked.toLocal()}".split(' ')[0]; 
//         _dateController.text = selectedDate ?? ''; 
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           'Add Ingredient',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//             fontSize: 24,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       bottomNavigationBar: Theme(
//         data: Theme.of(context).copyWith(canvasColor: Color(0xFF2A2C41)),
//         child: BottomNavBar(),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(8), 
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(
//                     color: Colors.black, 
//                     width: 1, 
//                   ),
//                 ),
//                 child: CircleAvatar(
//                   radius: 60,
//                   backgroundColor: Colors.white, 
//                   backgroundImage: AssetImage(widget.imagePath),
//                 ),
//               ),
//               SizedBox(height: 24),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'ชื่อวัตถุดิบ *',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                 ),
//               ),
//               SizedBox(height: 8),
//               Container(
//                 height: 48,
//                 padding: EdgeInsets.symmetric(horizontal: 12),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.black),
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: DropdownButton<String>(
//                   value: selectedIngredient,
//                   hint: Text('เลือกวัตถุดิบ'),
//                   isExpanded: true,
//                   items: ingredientList.map((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//                   onChanged: (String? newValue) {
//                     setState(() {
//                       selectedIngredient = newValue;
//                     });
//                   },
//                 ),
//               ),
//               SizedBox(height: 20),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'รายละเอียด',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                 ),
//               ),
//               SizedBox(height: 8),
//               TextField(
//                 maxLines: 2,
//                 decoration: InputDecoration(
//                   hintText: 'เช่น ปริมาณ 1 ถุง, ยี่ห้อ xxx',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'วันที่หมดอายุ',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                 ),
//               ),
//               SizedBox(height: 12),
//               Wrap(
//                 spacing: 12,
//                 runSpacing: 12,
//                 children: List.generate(7, (i) {
//                   return GestureDetector(
//                     onTap: () {
//                       _calculateDate(i + 1); 
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Color(0xFFFEDB71),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 8,
//                       ),
//                       child: Text('${i + 1} วัน'),
//                     ),
//                   );
//                 }),
//               ),
//               SizedBox(height: 16),
//               TextField(
//                 controller: _dateController,
//                 enabled: true, 
//                 focusNode: _focusNode, 
//                 decoration: InputDecoration(
//                   labelText: 'เลือกวันที่',
//                   hintText: 'กรุณาเลือกวันที่',
//                   hintStyle: TextStyle(color: Colors.black),
//                   prefixIcon: Icon(Icons.calendar_month, color: Colors.red), 
//                   border: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.black), 
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.blue), 
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                 ),
//                 onTap: () {
//                   _selectDate(context); 
//                 },
//               ),
//               SizedBox(height: 24),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ElevatedButton(
//                     onPressed: () => Navigator.pop(context),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xFFFEA9A4),
//                       shape: RoundedRectangleBorder(
//                         side: BorderSide(color: Colors.black),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 32,
//                         vertical: 12,
//                       ),
//                     ),
//                     child: Text(
//                       'ยกเลิก',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       // TODO: Save to DB
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xFFC3E090),
//                       shape: RoundedRectangleBorder(
//                         side: BorderSide(color: Colors.black),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 32,
//                         vertical: 12,
//                       ),
//                     ),
//                     child: Text(
//                       'บันทึก',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import '/widgets/bottom_navbar.dart';
// import 'package:cookmate/DatabaseHelperTest.dart';  // นำเข้า DatabaseHelperTest

// class AddIngredientPage extends StatefulWidget {
//   final String ingredientName;
//   final String imagePath;

//   // const AddIngredientPage({
//   //   super.key,
//   //   required this.ingredientName,
//   //   required this.imagePath,
//   // });
//    const AddIngredientPage({
//     Key? key,
//     required this.ingredientName,
//     required this.imagePath,
//   }) : super(key: key);

//   @override
//   _AddIngredientPageState createState() => _AddIngredientPageState();
// }

// class _AddIngredientPageState extends State<AddIngredientPage> {
//   TextEditingController _dateController = TextEditingController();
//   TextEditingController _detailController = TextEditingController();

//   DateTime currentDate = DateTime.now(); 
//   String? selectedDate;
//   String? selectedIngredient; 
//   FocusNode _focusNode = FocusNode(); 
//   List<String> ingredientList = [];

//   @override
//   void dispose() {
//     _dateController.dispose();
//     _detailController.dispose();
//     _focusNode.dispose(); 
//     super.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();
//     loadIngredientsByCategory(widget.ingredientName); // โหลดวัตถุดิบจากหมวดหมู่ที่เลือก
//   }

//   // ฟังก์ชันโหลดวัตถุดิบจากฐานข้อมูล
//   void loadIngredientsByCategory(String category) async {
//     final ingredients = await DatabaseHelperTest.fetchIngredientsByCategory(category);
//     setState(() {
//       ingredientList = ingredients.map((item) => item['ingredient_name'] ?? '').toList();
//       // ตั้งค่า ingredientName ที่เลือก
//       if (ingredientList.isNotEmpty) {
//         selectedIngredient = ingredientList[0]; // เลือกวัตถุดิบแรกเป็นค่าเริ่มต้น
//       }
//     });
//   }

//   // ฟังก์ชันคำนวณวันที่หมดอายุ
//   void _calculateDate(int daysToAdd) {
//     setState(() {
//       DateTime newDate = currentDate.add(Duration(days: daysToAdd));
//       selectedDate = "${newDate.toLocal()}".split(' ')[0]; 
//       _dateController.text = selectedDate ?? '';
//     });
//   }

//   // ฟังก์ชันเลือกวันที่หมดอายุ
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(), 
//       firstDate: DateTime(2000), 
//       lastDate: DateTime(2101), 
//     );

//     if (picked != null) {
//       setState(() {
//         selectedDate = "${picked.toLocal()}".split(' ')[0]; 
//         _dateController.text = selectedDate ?? ''; 
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           'Add Ingredient',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//             fontSize: 24,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       bottomNavigationBar: Theme(
//         data: Theme.of(context).copyWith(canvasColor: Color(0xFF2A2C41)),
//         child: BottomNavBar(),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(8), 
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(color: Colors.black, width: 1),
//                 ),
//                 child: CircleAvatar(
//                   radius: 60,
//                   backgroundColor: Colors.white, 
//                   backgroundImage: AssetImage(widget.imagePath), // ใช้รูปจาก widget
//                 ),
//               ),
//               SizedBox(height: 24),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text('ชื่อวัตถุดิบ *', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//               ),
//               SizedBox(height: 8),
//               Container(
//                 height: 48,
//                 padding: EdgeInsets.symmetric(horizontal: 12),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.black),
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: DropdownButton<String>(
//                   value: selectedIngredient,
//                   hint: Text('เลือกวัตถุดิบ'),
//                   isExpanded: true,
//                   items: ingredientList.map((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//                   onChanged: (String? newValue) {
//                     setState(() {
//                       selectedIngredient = newValue;
//                     });
//                   },
//                 ),
//               ),
//               SizedBox(height: 20),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text('รายละเอียด', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//               ),
//               SizedBox(height: 8),
//               TextField(
//                 controller: _detailController,
//                 maxLines: 2,
//                 decoration: InputDecoration(
//                   hintText: 'เช่น ปริมาณ 1 ถุง, ยี่ห้อ xxx',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text('วันที่หมดอายุ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//               ),
//               SizedBox(height: 12),
//               Wrap(
//                 spacing: 12,
//                 runSpacing: 12,
//                 children: List.generate(7, (i) {
//                   return GestureDetector(
//                     onTap: () => _calculateDate(i + 1),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Color(0xFFFEDB71),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                       child: Text('${i + 1} วัน'),
//                     ),
//                   );
//                 }),
//               ),
//               SizedBox(height: 16),
//               TextField(
//                 controller: _dateController,
//                 enabled: true, 
//                 focusNode: _focusNode,
//                 decoration: InputDecoration(
//                   labelText: 'เลือกวันที่',
//                   hintText: 'กรุณาเลือกวันที่',
//                   hintStyle: TextStyle(color: Colors.black),
//                   prefixIcon: Icon(Icons.calendar_month, color: Colors.red),
//                   border: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.black),
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.blue),
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                 ),
//                 onTap: () => _selectDate(context),
//               ),
//               SizedBox(height: 24),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ElevatedButton(
//                     onPressed: () => Navigator.pop(context),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xFFFEA9A4),
//                       shape: RoundedRectangleBorder(
//                         side: BorderSide(color: Colors.black),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//                     ),
//                     child: Text('ยกเลิก', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
//                   ),
//                   ElevatedButton(
//                     onPressed: () async {
//                       if (selectedIngredient == null || selectedDate == null) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('กรุณากรอกข้อมูลให้ครบถ้วน')),
//                         );
//                         return;
//                       }

//                       await DatabaseHelperTest.updateIngredientDetail(
//                         ingredientName: selectedIngredient!,
//                         description: _detailController.text.trim().isEmpty ? null : _detailController.text,
//                         expDate: selectedDate!,
//                       );

//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('บันทึกข้อมูลเรียบร้อย')),
//                       );

//                       Navigator.pop(context);
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xFFC3E090),
//                       shape: RoundedRectangleBorder(
//                         side: BorderSide(color: Colors.black),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//                     ),
//                     child: Text('บันทึก', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

//  ใช้ปจบที่ยังไม่แก้
// import 'package:flutter/material.dart';
// import '/widgets/bottom_navbar.dart';
// import 'package:cookmate/DatabaseHelperTest.dart';  // นำเข้า DatabaseHelperTest

// class AddIngredientPage extends StatefulWidget {
//   final String ingredientName;
//   final String imagePath;

//   const AddIngredientPage({
//     Key? key,
//     required this.ingredientName,
//     required this.imagePath,
//   }) : super(key: key);

//   @override
//   _AddIngredientPageState createState() => _AddIngredientPageState();
// }

// class _AddIngredientPageState extends State<AddIngredientPage> {
//   TextEditingController _dateController = TextEditingController();
//   TextEditingController _detailController = TextEditingController();

//   DateTime currentDate = DateTime.now(); 
//   String? selectedDate;
//   String? selectedIngredient; 
//   FocusNode _focusNode = FocusNode(); 
//   List<String> ingredientList = [];

//   @override
//   void dispose() {
//     _dateController.dispose();
//     _detailController.dispose();
//     _focusNode.dispose(); 
//     super.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();
//     loadIngredientsByCategory(widget.ingredientName); // โหลดวัตถุดิบจากหมวดหมู่ที่เลือก
//   }

//   // ฟังก์ชันโหลดวัตถุดิบจากฐานข้อมูล
//   void loadIngredientsByCategory(String category) async {
//     final ingredients = await DatabaseHelperTest.fetchIngredientsByCategory(category);
//     setState(() {
//       ingredientList = ingredients.map((item) => item['ingredient_name'] ?? '').toList();
//       // ตั้งค่า ingredientName ที่เลือก
//       if (ingredientList.isNotEmpty) {
//         selectedIngredient = ingredientList[0]; // เลือกวัตถุดิบแรกเป็นค่าเริ่มต้น
//       }
//     });
//   }

//   // ฟังก์ชันคำนวณวันที่หมดอายุ
//   void _calculateDate(int daysToAdd) {
//     setState(() {
//       DateTime newDate = currentDate.add(Duration(days: daysToAdd));
//       selectedDate = "${newDate.toLocal()}".split(' ')[0]; 
//       _dateController.text = selectedDate ?? '';
//     });
//   }

//   // ฟังก์ชันเลือกวันที่หมดอายุ
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(), 
//       firstDate: DateTime(2000), 
//       lastDate: DateTime(2101), 
//     );

//     if (picked != null) {
//       setState(() {
//         selectedDate = "${picked.toLocal()}".split(' ')[0]; 
//         _dateController.text = selectedDate ?? ''; 
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           'Add Ingredient',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//             fontSize: 24,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       bottomNavigationBar: Theme(
//         data: Theme.of(context).copyWith(canvasColor: Color(0xFF2A2C41)),
//         child: BottomNavBar(),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(8), 
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(color: Colors.black, width: 1),
//                 ),
//                 child: CircleAvatar(
//                   radius: 60,
//                   backgroundColor: Colors.white, 
//                   backgroundImage: AssetImage(widget.imagePath), // ใช้รูปจาก widget
//                 ),
//               ),
//               SizedBox(height: 24),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text('ชื่อวัตถุดิบ *', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//               ),
//               SizedBox(height: 8),
//               Container(
//                 height: 48,
//                 padding: EdgeInsets.symmetric(horizontal: 12),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.black),
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: DropdownButton<String>(
//                   value: selectedIngredient,
//                   hint: Text('เลือกวัตถุดิบ'),
//                   isExpanded: true,
//                   items: ingredientList.map((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//                   onChanged: (String? newValue) {
//                     setState(() {
//                       selectedIngredient = newValue;
//                     });
//                   },
//                 ),
//               ),
//               SizedBox(height: 20),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text('รายละเอียด', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//               ),
//               SizedBox(height: 8),
//               TextField(
//                 controller: _detailController,
//                 maxLines: 2,
//                 decoration: InputDecoration(
//                   hintText: 'เช่น ปริมาณ 1 ถุง, ยี่ห้อ xxx',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text('วันที่หมดอายุ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//               ),
//               SizedBox(height: 12),
//               Wrap(
//                 spacing: 12,
//                 runSpacing: 12,
//                 children: List.generate(7, (i) {
//                   return GestureDetector(
//                     onTap: () => _calculateDate(i + 1),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Color(0xFFFEDB71),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                       child: Text('${i + 1} วัน'),
//                     ),
//                   );
//                 }),
//               ),
//               SizedBox(height: 16),
//               TextField(
//                 controller: _dateController,
//                 enabled: true, 
//                 focusNode: _focusNode,
//                 decoration: InputDecoration(
//                   labelText: 'เลือกวันที่',
//                   hintText: 'กรุณาเลือกวันที่',
//                   hintStyle: TextStyle(color: Colors.black),
//                   prefixIcon: Icon(Icons.calendar_month, color: Colors.red),
//                   border: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.black),
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.blue),
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                 ),
//                 onTap: () => _selectDate(context),
//               ),
//               SizedBox(height: 24),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ElevatedButton(
//                     onPressed: () => Navigator.pop(context),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xFFFEA9A4),
//                       shape: RoundedRectangleBorder(
//                         side: BorderSide(color: Colors.black),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//                     ),
//                     child: Text('ยกเลิก', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
//                   ),
//                   ElevatedButton(
//                     onPressed: () async {
//                       if (selectedIngredient == null || selectedDate == null) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('กรุณากรอกข้อมูลให้ครบถ้วน')),
//                         );
//                         return;
//                       }

//                       await DatabaseHelperTest.updateIngredientDetail(
//                         ingredientName: selectedIngredient!,
//                         description: _detailController.text.trim().isEmpty ? null : _detailController.text,
//                         expDate: selectedDate!,
//                       );

//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('บันทึกข้อมูลเรียบร้อย')),
//                       );

//                       Navigator.pop(context);  // กลับไปที่ MyIngredientsPage และรีเฟรชข้อมูล
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xFFC3E090),
//                       shape: RoundedRectangleBorder(
//                         side: BorderSide(color: Colors.black),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//                     ),
//                     child: Text('บันทึก', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import '/widgets/bottom_navbar.dart';
// import 'package:cookmate/DatabaseHelperTest.dart';

// class AddIngredientPage extends StatefulWidget {
//   final String ingredientName;
//   final String imagePath;

//   const AddIngredientPage({
//     Key? key,
//     required this.ingredientName,
//     required this.imagePath,
//   }) : super(key: key);

//   @override
//   _AddIngredientPageState createState() => _AddIngredientPageState();
// }

// class _AddIngredientPageState extends State<AddIngredientPage> {
//   final TextEditingController _dateController = TextEditingController();
//   final TextEditingController _detailController = TextEditingController();
//   final FocusNode _focusNode = FocusNode();

//   DateTime currentDate = DateTime.now();
//   String? selectedDate;
//   String? selectedIngredient;
//   List<String> ingredientList = [];

//   @override
//   void initState() {
//     super.initState();
//     loadIngredientsByCategory(widget.ingredientName);
//   }

//   @override
//   void dispose() {
//     _dateController.dispose();
//     _detailController.dispose();
//     _focusNode.dispose();
//     super.dispose();
//   }

//   void loadIngredientsByCategory(String category) async {
//     final ingredients = await DatabaseHelperTest.fetchIngredientsByCategory(category);
//     final list = ingredients.map((item) => item['ingredient_name'] ?? '').toList();
//     setState(() {
//       ingredientList = list;
//       if (ingredientList.isNotEmpty) {
//         selectedIngredient = ingredientList.contains(widget.ingredientName)
//             ? widget.ingredientName
//             : ingredientList[0];
//       }
//     });
//   }

//   void _calculateDate(int daysToAdd) {
//     DateTime newDate = currentDate.add(Duration(days: daysToAdd));
//     setState(() {
//       selectedDate = "${newDate.toLocal()}".split(' ')[0];
//       _dateController.text = selectedDate ?? '';
//     });
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: currentDate,
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );

//     if (picked != null) {
//       setState(() {
//         selectedDate = "${picked.toLocal()}".split(' ')[0];
//         _dateController.text = selectedDate ?? '';
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           'Add Ingredient',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//             fontSize: 24,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       bottomNavigationBar: Theme(
//         data: Theme.of(context).copyWith(canvasColor: Color(0xFF2A2C41)),
//         child: BottomNavBar(),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(color: Colors.black, width: 1),
//                 ),
//                 child: CircleAvatar(
//                   radius: 60,
//                   backgroundColor: Colors.white,
//                   backgroundImage: AssetImage(
//                     widget.imagePath.isNotEmpty
//                         ? widget.imagePath
//                         : 'assets/images/default.png',
//                   ),
//                 ),
//               ),
//               SizedBox(height: 24),

//               // Dropdown: Ingredient name
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text('ชื่อวัตถุดิบ *', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//               ),
//               SizedBox(height: 8),
//               Container(
//                 height: 48,
//                 padding: EdgeInsets.symmetric(horizontal: 12),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.black),
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: DropdownButton<String>(
//                   value: selectedIngredient,
//                   hint: Text('เลือกวัตถุดิบ'),
//                   isExpanded: true,
//                   items: ingredientList.map((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//                   onChanged: (String? newValue) {
//                     setState(() {
//                       selectedIngredient = newValue;
//                     });
//                   },
//                 ),
//               ),
//               SizedBox(height: 20),

//               // Detail
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text('รายละเอียด', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//               ),
//               SizedBox(height: 8),
//               TextField(
//                 controller: _detailController,
//                 maxLines: 2,
//                 decoration: InputDecoration(
//                   hintText: 'เช่น ปริมาณ 1 ถุง, ยี่ห้อ xxx',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 20),

//               // Expiration Date Section
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text('วันที่หมดอายุ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//               ),
//               SizedBox(height: 12),
//               Wrap(
//                 spacing: 12,
//                 runSpacing: 12,
//                 children: List.generate(7, (i) {
//                   return GestureDetector(
//                     onTap: () => _calculateDate(i + 1),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Color(0xFFFEDB71),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                       child: Text('${i + 1} วัน'),
//                     ),
//                   );
//                 }),
//               ),
//               SizedBox(height: 16),

//               TextField(
//                 controller: _dateController,
//                 enabled: true,
//                 focusNode: _focusNode,
//                 decoration: InputDecoration(
//                   labelText: 'เลือกวันที่',
//                   hintText: 'กรุณาเลือกวันที่',
//                   hintStyle: TextStyle(color: Colors.black),
//                   prefixIcon: Icon(Icons.calendar_month, color: Colors.red),
//                   border: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.black),
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.blue),
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                 ),
//                 onTap: () => _selectDate(context),
//               ),
//               SizedBox(height: 24),

//               // Buttons
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ElevatedButton(
//                     onPressed: () => Navigator.pop(context),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xFFFEA9A4),
//                       shape: RoundedRectangleBorder(
//                         side: BorderSide(color: Colors.black),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//                     ),
//                     child: Text('ยกเลิก', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
//                   ),
//                   ElevatedButton(
//                     onPressed: () async {
//                       if (selectedIngredient == null || selectedDate == null) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('กรุณากรอกข้อมูลให้ครบถ้วน')),
//                         );
//                         return;
//                       }

//                       await DatabaseHelperTest.updateIngredientDetail(
//                         ingredientName: selectedIngredient!,
//                         description: _detailController.text.trim().isEmpty ? null : _detailController.text,
//                         expDate: selectedDate!,
//                       );

//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('บันทึกข้อมูลเรียบร้อย')),
//                       );

//                       Navigator.pop(context);
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xFFC3E090),
//                       shape: RoundedRectangleBorder(
//                         side: BorderSide(color: Colors.black),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//                     ),
//                     child: Text('บันทึก', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import '/widgets/bottom_navbar.dart';
import 'package:cookmate/DatabaseHelperTest.dart';  // นำเข้า DatabaseHelperTest

class AddIngredientPage extends StatefulWidget {
  final String ingredientName;
  final String imagePath;

  // เพิ่ม constructor นี้
  const AddIngredientPage({
    Key? key,
    required this.ingredientName,
    required this.imagePath,
  }) : super(key: key);

  @override
  _AddIngredientPageState createState() => _AddIngredientPageState();
}

class _AddIngredientPageState extends State<AddIngredientPage> {
  TextEditingController _dateController = TextEditingController();
  TextEditingController _detailController = TextEditingController();

  DateTime currentDate = DateTime.now(); 
  String? selectedDate;
  String? selectedIngredient; 
  FocusNode _focusNode = FocusNode(); 
  List<String> ingredientList = [];
  bool isLoading = false; // สำหรับการแสดง loading indicator

  @override
  void dispose() {
    _dateController.dispose();
    _detailController.dispose();
    _focusNode.dispose(); 
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    loadIngredientsByCategory(widget.ingredientName); // โหลดวัตถุดิบจากหมวดหมู่ที่เลือก
  }

  // ฟังก์ชันโหลดวัตถุดิบจากฐานข้อมูล
  void loadIngredientsByCategory(String category) async {
    setState(() {
      isLoading = true; // แสดง loading indicator
    });

    final ingredients = await DatabaseHelperTest.fetchIngredientsByCategory(category);
    setState(() {
      ingredientList = ingredients.map((item) => item['ingredient_name'] ?? '').toList();
      // ตั้งค่า ingredientName ที่เลือก
      if (ingredientList.isNotEmpty) {
        selectedIngredient = ingredientList[0]; // เลือกวัตถุดิบแรกเป็นค่าเริ่มต้น
      }
      isLoading = false; // ซ่อน loading indicator
    });
  }

  // ฟังก์ชันคำนวณวันที่หมดอายุ
  void _calculateDate(int daysToAdd) {
    setState(() {
      DateTime newDate = currentDate.add(Duration(days: daysToAdd));
      selectedDate = "${newDate.toLocal()}".split(' ')[0]; 
      _dateController.text = selectedDate ?? '';
    });
  }

  // ฟังก์ชันเลือกวันที่หมดอายุ
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), 
      firstDate: DateTime(2000), 
      lastDate: DateTime(2101), 
    );

    if (picked != null) {
      setState(() {
        selectedDate = "${picked.toLocal()}".split(' ')[0]; 
        _dateController.text = selectedDate ?? ''; 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Add Ingredient',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: Color(0xFF2A2C41)),
        child: BottomNavBar(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(8), 
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white, 
                  backgroundImage: AssetImage(widget.imagePath), // ใช้รูปจาก widget
                ),
              ),
              SizedBox(height: 24),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('ชื่อวัตถุดิบ *', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ),
              SizedBox(height: 8),
              isLoading
                  ? CircularProgressIndicator() // แสดง loading indicator
                  : Container(
                      height: 48,
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: DropdownButton<String>(
                        value: selectedIngredient,
                        hint: Text('เลือกวัตถุดิบ'),
                        isExpanded: true,
                        items: ingredientList.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedIngredient = newValue;
                          });
                        },
                      ),
                    ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('รายละเอียด', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _detailController,
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: 'เช่น ปริมาณ 1 ถุง, ยี่ห้อ xxx',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('วันที่หมดอายุ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ),
              SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: List.generate(7, (i) {
                  return GestureDetector(
                    onTap: () => _calculateDate(i + 1),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFFEDB71),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text('${i + 1} วัน'),
                    ),
                  );
                }),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _dateController,
                enabled: true, 
                focusNode: _focusNode,
                decoration: InputDecoration(
                  labelText: 'เลือกวันที่',
                  hintText: 'กรุณาเลือกวันที่',
                  hintStyle: TextStyle(color: Colors.black),
                  prefixIcon: Icon(Icons.calendar_month, color: Colors.red),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onTap: () => _selectDate(context),
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFEA9A4),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    ),
                    child: Text('ยกเลิก', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (selectedIngredient == null || selectedDate == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('กรุณากรอกข้อมูลให้ครบถ้วน')),
                        );
                        return;
                      }

                      await DatabaseHelperTest.updateIngredientDetail(
                        ingredientName: selectedIngredient!,
                        description: _detailController.text.trim().isEmpty ? null : _detailController.text,
                        expDate: selectedDate!,
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('บันทึกข้อมูลเรียบร้อย')),
                      );

                      Navigator.pop(context);  // กลับไปที่ MyIngredientsPage และรีเฟรชข้อมูล
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFC3E090),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    ),
                    child: Text('บันทึก', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
