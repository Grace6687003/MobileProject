class IngredientModel {
  final int id;
  final int ingredientId;
  final String name;
  final String imagePath;
  final DateTime? expDate;
  final String? description;

  IngredientModel({
    required this.id,
    required this.ingredientId,
    required this.name,
    required this.imagePath,
    this.expDate,
    this.description,
  });

  String get status {
    if (expDate == null) return '';
    final now = DateTime.now().toLocal();
    final currentDate = DateTime(now.year, now.month, now.day);
    final diff = expDate!.difference(currentDate).inDays;

    if (diff < 0) return 'หมดอายุแล้ว!';
    if (diff == 0) return 'จะหมดอายุวันนี้';
    if (diff == 1) return 'เหลืออีก 1 วัน';
    if (diff == 2) return 'เหลืออีก 2 วัน';
    return '';
  }

  bool get isExpired {
    if (expDate == null) return false;
    final today = DateTime.now().copyWith(hour: 0, minute: 0, second: 0, millisecond: 0);
    return expDate!.isBefore(today);
  }

  factory IngredientModel.fromMap(Map<String, dynamic> map) {
    return IngredientModel(
      id: map['my_ingredient_id'],
      ingredientId: map['ingredient_id'],
      name: map['ingredient_name'] ?? map['name'], // รองรับทั้งชื่อแบบใหม่และเดิม
      imagePath: map['Categories_image'] ?? map['imagePath'] ?? 'assets/images/default.png',
      expDate: map['exp_date'] != null && map['exp_date'].toString().isNotEmpty
          ? DateTime.tryParse(map['exp_date'])
          : null,
      description: map['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'my_ingredient_id': id,
      'ingredient_id': ingredientId,
      'ingredient_name': name,
      'Categories_image': imagePath,
      'exp_date': expDate?.toIso8601String(),
      'description': description,
    };
  }
}
