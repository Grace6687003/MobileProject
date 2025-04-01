class RecipesIngredientsModel {
  final String recipeId;
  final String ingredientId;
  final bool isRequired;

  RecipesIngredientsModel({
    required this.recipeId,
    required this.ingredientId,
    required this.isRequired,
  });

  // สร้างจาก Map
  factory RecipesIngredientsModel.fromMap(Map<String, dynamic> map) {
    return RecipesIngredientsModel(
      recipeId: map['recipe_id'],
      ingredientId: map['ingredient_id'],
      isRequired: map['is_required'] == 1,
    );
  }

  // แปลงเป็น Map
  Map<String, dynamic> toMap() {
    return {
      'recipe_id': recipeId,
      'ingredient_id': ingredientId,
      'is_required': isRequired ? 1 : 0,
    };
  }
}
