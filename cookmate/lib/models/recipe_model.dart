class RecipeModel {
  final String recipeId;
  final String recipeName;
  final String instruction;
  final String recipeImage;

  RecipeModel({
    required this.recipeId,
    required this.recipeName,
    required this.instruction,
    required this.recipeImage,
  });

  // สร้างจาก Map
  factory RecipeModel.fromMap(Map<String, dynamic> map) {
    return RecipeModel(
      recipeId: map['recipe_id'],
      recipeName: map['recipe_name'],
      instruction: map['instruction'],
      recipeImage: map['recipe_image'],
    );
  }

  // แปลงเป็น Map
  Map<String, dynamic> toMap() {
    return {
      'recipe_id': recipeId,
      'recipe_name': recipeName,
      'instruction': instruction,
      'recipe_image': recipeImage,
    };
  }
}
