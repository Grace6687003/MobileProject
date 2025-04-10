import 'package:flutter/material.dart';
import '/widgets/bottom_navbar.dart'; 

class AddIngredientPage extends StatefulWidget {
  final String ingredientName;
  final String imagePath;

  const AddIngredientPage({
    super.key,
    required this.ingredientName,
    required this.imagePath,
  });

  @override
  _AddIngredientPageState createState() => _AddIngredientPageState();
}

class _AddIngredientPageState extends State<AddIngredientPage> {
  TextEditingController _dateController = TextEditingController();
  DateTime currentDate = DateTime.now(); // วันที่ปัจจุบัน
  String? selectedDate;
  String? selectedIngredient; // สำหรับเก็บชื่อวัตถุดิบที่เลือก
  FocusNode _focusNode = FocusNode(); // เพิ่ม FocusNode เพื่อให้สามารถคลิกที่ TextField ได้

  final List<String> ingredientList = [
    'เนื้อสัตว์',
    'ผลิตภัณฑ์นม',
    'ไข่',
    'แป้ง',
    'ผัก',
  ];

  @override
  void dispose() {
    _dateController.dispose();
    _focusNode.dispose(); // อย่าลืม dispose FocusNode
    super.dispose();
  }

  // ฟังก์ชันสำหรับคำนวณวันหมดอายุ
  void _calculateDate(int daysToAdd) {
    setState(() {
      DateTime newDate = currentDate.add(Duration(days: daysToAdd));
      selectedDate = "${newDate.toLocal()}".split(' ')[0]; // แสดงวันที่ใหม่
      _dateController.text = selectedDate ?? '';
    });
  }

  // ฟังก์ชันแสดงปฏิทินสำหรับเลือกวัน
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // วันที่เริ่มต้นเป็นวันที่ปัจจุบัน
      firstDate: DateTime(2000), // วันที่เริ่มต้นของปฏิทิน
      lastDate: DateTime(2101), // วันที่สิ้นสุดของปฏิทิน
    );

    if (picked != null) {
      setState(() {
        selectedDate =
            "${picked.toLocal()}".split(' ')[0]; // แสดงวันที่ที่เลือก
        _dateController.text = selectedDate ?? ''; // อัพเดทใน TextField
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
          'แก้ไขวัตถุดิบ',
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
              // รูปวัตถุดิบ
              Container(
                padding: EdgeInsets.all(8), // เพิ่ม padding รอบๆ รูปภาพ
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.black, // สีขอบ
                    width: 1, // ความหนาของขอบ
                  ),
                ),
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white, // สีพื้นหลัง
                  backgroundImage: AssetImage(widget.imagePath),
                ),
              ),
              SizedBox(height: 24),

              // ชื่อวัตถุดิบ (Dropdown)
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'ชื่อวัตถุดิบ *',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              SizedBox(height: 8),
              Container(
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

              // รายละเอียด
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'รายละเอียด',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              SizedBox(height: 8),
              TextField(
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: 'เช่น ปริมาณ 1 ถุง, ยี่ห้อ xxx',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),

              // วันหมดอายุ
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'วันที่หมดอายุ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: List.generate(7, (i) {
                  return GestureDetector(
                    onTap: () {
                      _calculateDate(i + 1); // กดเลือก 1 วัน, 2 วัน, 3 วัน ฯลฯ
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFFEDB71),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Text('${i + 1} วัน'),
                    ),
                  );
                }),
              ),
              SizedBox(height: 16),

              // ป้อนวันที่จาก DatePicker
              TextField(
                controller: _dateController,
                enabled: true, // ไม่ให้แก้ไข
                focusNode: _focusNode, // กำหนด FocusNode
                decoration: InputDecoration(
                  labelText: 'เลือกวันที่',
                  hintText: 'กรุณาเลือกวันที่',
                  hintStyle: TextStyle(color: Colors.black),
                  prefixIcon: Icon(Icons.calendar_month, color: Colors.red), // แสดงไอคอน
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black), // ขอบดำ
                    borderRadius: BorderRadius.circular(16),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue), // ขอบเมื่อเลือก
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onTap: () {
                  _selectDate(context); // กดเลือกวันที่จาก DatePicker
                },
              ),
              SizedBox(height: 24),

              // ปุ่มแก้ไขและลบ
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Add delete action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFFA4A4),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                    ),
                    child: Text(
                      'ลบ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Add update action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFEDB71),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                    ),
                    child: Text(
                      'แก้ไข',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
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
