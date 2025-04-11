import 'package:flutter/material.dart';
import '/widgets/bottom_navbar.dart';
import 'package:cookmate/DatabaseHelperTest.dart';

class EditIngredientPage extends StatefulWidget {
  final String ingredientName;
  final String imagePath;
  final String? description;
  final String? expDate;

  const EditIngredientPage({
    Key? key,
    required this.ingredientName,
    required this.imagePath,
    this.description,
    this.expDate,
  }) : super(key: key);

  @override
  _EditIngredientPageState createState() => _EditIngredientPageState();
}

class _EditIngredientPageState extends State<EditIngredientPage> {
  TextEditingController _dateController = TextEditingController();
  TextEditingController _detailController = TextEditingController();

  DateTime currentDate = DateTime.now();
  String? selectedDate;
  String? selectedIngredient;
  FocusNode _focusNode = FocusNode();
  List<String> ingredientList = [];
  bool isLoading = false;

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
    // กำหนดค่าที่รับมาจากหน้าก่อนหน้า
    _detailController.text = widget.description ?? '';
    _dateController.text = widget.expDate ?? '';
    selectedDate = widget.expDate;
    loadIngredientByName(widget.ingredientName);
  }

  void loadIngredientByName(String name) async {
    setState(() => isLoading = true);

    final ingredients = await DatabaseHelperTest.fetchIngredientByName(name);

    if (ingredients.isNotEmpty) {
      final ingredient = ingredients[0];

      setState(() {
        ingredientList = [ingredient['ingredient_name'] ?? ''];
        selectedIngredient = ingredient['ingredient_name'];

        // ✅ เพิ่มการเซตค่าที่เหลือ
        _detailController.text = ingredient['description'] ?? '';
        _dateController.text = ingredient['exp_date'] ?? '';
        selectedDate = ingredient['exp_date'];

        isLoading = false;
      });
    } else {
      setState(() => isLoading = false);
    }
  }

  void _calculateDate(int daysToAdd) {
    setState(() {
      DateTime newDate = currentDate.add(Duration(days: daysToAdd));
      selectedDate = "${newDate.toLocal()}".split(' ')[0];
      _dateController.text = selectedDate ?? '';
    });
  }

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

  void _showConfirmEditSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('คุณต้องการแก้ไขใช่มั้ย'),
        action: SnackBarAction(
          label: 'ยืนยัน',
          textColor: Colors.green,
          onPressed: () async {
            if (selectedIngredient == null || selectedDate == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('กรุณากรอกข้อมูลให้ครบถ้วน')),
              );
              return;
            }

            await DatabaseHelperTest.updateIngredientDetail(
              ingredientName: selectedIngredient!,
              description:
                  _detailController.text.trim().isEmpty
                      ? null
                      : _detailController.text,
              expDate: selectedDate!,
            );

            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('แก้ไขข้อมูลเรียบร้อย')));

            Navigator.pop(context);
          },
        ),
      ),
    );
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
          'Edit Ingredient',
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
                  backgroundImage: AssetImage(widget.imagePath),
                ),
              ),
              SizedBox(height: 24),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'ชื่อวัตถุดิบ *',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              SizedBox(height: 8),
              isLoading
                  ? CircularProgressIndicator()
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
                      items:
                          ingredientList.map((String value) {
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
                child: Text(
                  'รายละเอียด',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
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
                    onTap: () => _calculateDate(i + 1),
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
                      padding: EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                    ),
                    child: Text(
                      'ยกเลิก',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _showConfirmEditSnackBar,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFC3E090),
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
                      'ยืนยัน',
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
