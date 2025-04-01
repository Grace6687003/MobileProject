class FavoriteRecipeModel {
  final String favId;
  final String recipeId;
  final String favImage;

  FavoriteRecipeModel({
    required this.favId,
    required this.recipeId,
    required this.favImage,
  });

  // สร้างจาก Map
  factory FavoriteRecipeModel.fromMap(Map<String, dynamic> map) {
    return FavoriteRecipeModel(
      favId: map['fav_id'],
      recipeId: map['recipe_id'],
      favImage: map['fav_image'],
    );
  }

  // แปลงเป็น Map
  Map<String, dynamic> toMap() {
    return {
      'fav_id': favId,
      'recipe_id': recipeId,
      'fav_image': favImage,
    };
  }
}
