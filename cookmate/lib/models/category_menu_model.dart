class CategoryModel {
  final String categoryId;
  final String categoryName;
  final String categoryImage;

  CategoryModel({
    required this.categoryId,
    required this.categoryName,
    required this.categoryImage,
  });

  // สร้างจาก Map
  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      categoryId: map['category_id'],
      categoryName: map['category_name'],
      categoryImage: map['category_image'],
    );
  }

  // แปลงเป็น Map
  Map<String, dynamic> toMap() {
    return {
      'category_id': categoryId,
      'category_name': categoryName,
      'category_image': categoryImage,
    };
  }
}
