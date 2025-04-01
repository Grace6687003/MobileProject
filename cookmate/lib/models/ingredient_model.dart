class IngredientModel {
  final int id;
  final int ingredientId;
  final String name;
  final String imagePath;
  final DateTime expDate;

  IngredientModel({
    required this.id,
    required this.ingredientId,
    required this.name,
    required this.imagePath,
    required this.expDate,
  });

  String get status {
  // เอาแค่วันที่ปัจจุบัน โดยไม่สนใจเวลา
  final now = DateTime.now().toLocal(); // รับเวลาปัจจุบัน
  final currentDate = DateTime(now.year, now.month, now.day); // เอาแค่วัน-เดือน-ปี

  final diff = expDate.difference(currentDate).inDays; // คำนวณจำนวนวัน

  if (diff < 0) return 'หมดอายุแล้ว!';
  if (diff == 0) return 'จะหมดอายุวันนี้';
  if (diff == 2) return 'เหลืออีก 2 วัน';
  if (diff == 1) return 'เหลืออีก 1 วัน';
  return '';
}


  bool get isExpired => expDate.isBefore(
    DateTime.now().copyWith(hour: 0, minute: 0, second: 0, millisecond: 0),
  );

  // เพิ่มฟังก์ชันเพื่อแปลงจาก Map (จะใช้เชื่อมกับ SQLite หรือ CSV ต่อไป)
  factory IngredientModel.fromMap(Map<String, dynamic> map) {
    return IngredientModel(
      id: map['my_ingredient_id'],
      ingredientId: map['ingredient_id'],
      name: map['name'],
      imagePath: map['imagePath'],
      expDate: DateTime.parse(map['exp_date']),
    );
  }

  // ฟังก์ชันนี้ใช้เพื่อแปลงข้อมูลจากโมเดลกลับเป็น Map (เพื่อใช้งานในฐานข้อมูลหรือ CSV)
  Map<String, dynamic> toMap() {
    return {
      'my_ingredient_id': id,
      'ingredient_id': ingredientId,
      'name': name,
      'imagePath': imagePath,
      'exp_date': expDate.toIso8601String(),
    };
  }
}
