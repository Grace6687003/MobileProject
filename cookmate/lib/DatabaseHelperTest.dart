import 'package:mysql_client/mysql_client.dart';

class DatabaseHelperTest {
  static Future<MySQLConnection> _connectToDatabase() async {
    final conn = await MySQLConnection.createConnection(
      host: '172.20.10.6', // เปลี่ยนเป็น IP Address ของ MySQL
      port: 3306, // Port 3306 สำหรับ MySQL
      userName: "root", // ชื่อผู้ใช้ของ MySQL
      password: '6687003', // รหัสผ่านของ MySQL
      databaseName: 'cookmate1_db', // ชื่อฐานข้อมูลที่ต้องการเชื่อมต่อ
    );
    await conn.connect();
    return conn;
  }

  // ฟังก์ชันทดสอบการเชื่อมต่อ
  static Future<void> testConnection() async {
    final conn = await _connectToDatabase();
    print('Connection Successful');
    await conn.close();
  }

  // ใช้ ฟังก์ชันทดสอบการเชื่อมต่อ home_page
  static Future<List<Map<String, String>>> fetchFullyMatchedRecipes() async {
    final conn = await _connectToDatabase();
    var results = await conn.execute('''
  SELECT r.recipe_id, r.recipe_name, r.recipe_image, r.fav_id
  FROM Recipes r
  WHERE r.recipe_id IN (
    SELECT ri.recipe_id
    FROM Recipes_Ingredients ri
    WHERE ri.is_required = TRUE
    GROUP BY ri.recipe_id
    HAVING COUNT(*) = (
      SELECT COUNT(DISTINCT i.ingredient_id)
      FROM Recipes_Ingredients ri2
      JOIN Ingredient i ON ri2.ingredient_id = i.ingredient_id
      WHERE (i.exp_date IS NOT NULL OR i.description IS NOT NULL)
        AND ri2.is_required = TRUE
        AND ri2.recipe_id = ri.recipe_id
    )
  )
''');

    List<Map<String, String>> recipes =
        results.rows
            .map((row) => row.assoc().map((k, v) => MapEntry(k, v ?? '')))
            .toList();

    await conn.close();
    return recipes;
  }

  // ใช้ ดึงข้อมูลวัตถุดิบตามหมวดหมู่ (เช่น "เนื้อสัตว์")   add_ingredient_page
  static Future<List<Map<String, String>>> fetchIngredientsByCategory(
    String categoryName,
  ) async {
    final conn = await _connectToDatabase();

    // ปรับให้ใช้ชื่อตารางจริงที่คุณใช้ เช่น 'ingredients' หรือ 'ingredient'
    var results = await conn.execute(
      '''
    SELECT * FROM Ingredient 
    WHERE Categories_name = :categoryName
    ''',
      {"categoryName": categoryName},
    );

    List<Map<String, String>> ingredients =
        results.rows.map((row) {
          return row.assoc().map((key, value) => MapEntry(key, value ?? ''));
        }).toList();

    await conn.close();
    return ingredients;
  }

  // ใช้
  static Future<List<Map<String, dynamic>>> fetchUserIngredientsOnly() async {
    final conn = await _connectToDatabase();

    // เพิ่ม ORDER BY ให้เรียงตาม exp_Date จากใกล้หมดอายุมากสุดไปไกล และ NULL อยู่ล่างสุด
    var results = await conn.execute('''
    SELECT * FROM Ingredient 
    WHERE exp_date IS NOT NULL OR description IS NOT NULL
    ORDER BY 
      CASE WHEN exp_date IS NULL THEN 1 ELSE 0 END,
      exp_date ASC
  ''');

    List<Map<String, dynamic>> ingredients =
        results.rows.map((row) => row.assoc()).toList();

    await conn.close();
    return ingredients;
  }

  // ใช้ บันทึกวัตถุดิบที่ผู้ใช้เลือก พร้อมรายละเอียดและวันหมดอายุ
  static Future<void> updateIngredientDetail({
    required String ingredientName,
    String? description,
    required String expDate,
  }) async {
    final conn = await _connectToDatabase();

    await conn.execute(
      '''
    UPDATE Ingredient
    SET description = :description, exp_date = :expDate
    WHERE ingredient_name = :ingredientName
    ''',
      {
        "ingredientName": ingredientName,
        "description": description ?? '',
        "expDate": expDate,
      },
    );

    await conn.close();
  }

  // ใช้ ลบรายการ ingredient ใน list ออก
  static Future<void> clearIngredientDetails({
    required String ingredientName,
  }) async {
    final conn = await _connectToDatabase(); // เปลี่ยนให้ตรงกับฟังก์ชันที่คุณมี

    await conn.execute(
      '''
    UPDATE Ingredient
    SET description = NULL, exp_date = NULL
    WHERE ingredient_name = :ingredientName
    ''',
      {"ingredientName": ingredientName},
    );

    await conn.close();
  }

  // ใช้
  static Future<List<Map<String, String>>> fetchIngredientByName(
    String ingredientName,
  ) async {
    final conn = await _connectToDatabase();

    var results = await conn.execute(
      '''
    SELECT * FROM Ingredient 
    WHERE ingredient_name = :ingredientName
    ''',
      {"ingredientName": ingredientName},
    );

    List<Map<String, String>> ingredients =
        results.rows.map((row) {
          return row.assoc().map((key, value) => MapEntry(key, value ?? ''));
        }).toList();

    await conn.close();
    return ingredients;
  }

  static Future<void> updateFavoriteStatus({
    required String recipeId,
    required bool isFavorite,
  }) async {
    final conn = await _connectToDatabase(); // เรียกใช้ฐานข้อมูล
    await conn.execute(
      '''
    UPDATE Recipes
    SET fav_id = :favId
    WHERE recipe_id = :recipeId
    ''',
      {"favId": isFavorite ? 1 : 0, "recipeId": recipeId},
    );

    await conn.close();
  }

  // ฟังก์ชัน _fetchFavoriteMenus()
  static Stream<List<Map<String, String>>> fetchFavoriteRecipesStream() async* {
    final conn = await _connectToDatabase();

    while (true) {
      var results = await conn.execute('''
      SELECT recipe_id, recipe_name, recipe_image, fav_id
      FROM Recipes
      WHERE fav_id = 1
      ''');

      List<Map<String, String>> favoriteRecipes =
          results.rows
              .map((row) => row.assoc().map((k, v) => MapEntry(k, v ?? '')))
              .toList();

      yield favoriteRecipes; // ส่งข้อมูลให้ Stream
      await Future.delayed(
        Duration(seconds: 5),
      ); // หน่วงเวลา 5 วินาที แล้วดึงข้อมูลใหม่
    }
  }

  static Future<List<Map<String, String>>> fetchRandomMenus() async {
    final conn = await _connectToDatabase();
    var results = await conn.execute('''
    SELECT recipe_id, recipe_name, recipe_image, fav_id
FROM Recipes
WHERE recipe_id IS NOT NULL
ORDER BY RAND()
LIMIT 4;

  ''');

    List<Map<String, String>> randomMenus =
        results.rows
            .map((row) => row.assoc().map((k, v) => MapEntry(k, v ?? '')))
            .toList();

    await conn.close();

    // ตรวจสอบผลลัพธ์ที่ดึงมา
    print("เมนูแนะนำที่ดึงมา: $randomMenus");

    return randomMenus;
  }

  static Future<List<Map<String, String>>> fetchAllMenus() async {
    final conn = await _connectToDatabase();
    final results = await conn.execute('''
    SELECT recipe_id, recipe_name, recipe_image, fav_id
    FROM Recipes
  ''');

    List<Map<String, String>> menus =
        results.rows
            .map((row) => row.assoc().map((k, v) => MapEntry(k, v ?? '')))
            .toList();

    await conn.close();
    return menus;
  }

  static Future<List<Map<String, String>>> searchRecipesByNameOrIngredient(
    String query,
  ) async {
    final conn = await _connectToDatabase();

    var results = await conn.execute(
      '''
    SELECT DISTINCT r.recipe_id, r.recipe_name, r.recipe_image, r.fav_id
    FROM Recipes r
    LEFT JOIN Recipes_Ingredients ri ON r.recipe_id = ri.recipe_id
    LEFT JOIN Ingredient i ON ri.ingredient_id = i.ingredient_id
    WHERE r.recipe_name LIKE :query OR i.ingredient_name LIKE :query
  ''',
      {"query": "%$query%"},
    );

    return results.rows
        .map((row) => row.assoc().map((k, v) => MapEntry(k, v ?? '')))
        .toList();
  }

  static Future<Map<String, dynamic>> getRecipeDetail(String recipeId) async {
  final conn = await _connectToDatabase();

  // ✅ ดึงข้อมูลเมนูพร้อม fav_id
  final recipeResult = await conn.execute('''
    SELECT recipe_id, recipe_name, instruction, recipe_image, fav_id
    FROM Recipes
    WHERE recipe_id = :id
  ''', {"id": recipeId});

  if (recipeResult.rows.isEmpty) return {};

  final recipe = recipeResult.rows.first.assoc();

  // ✅ ดึงวัตถุดิบพร้อม is_required
  final ingredientsResult = await conn.execute('''
    SELECT i.ingredient_name, ri.is_required
    FROM Recipes_Ingredients ri
    JOIN Ingredient i ON ri.ingredient_id = i.ingredient_id
    WHERE ri.recipe_id = :id
  ''', {"id": recipeId});

  final ingredients = ingredientsResult.rows
      .map((row) => row.assoc().map((k, v) => MapEntry(k, v ?? '')))
      .toList();

  return {
    "recipe_id": recipe["recipe_id"],
    "recipe_name": recipe["recipe_name"],
    "instruction": recipe["instruction"],
    "recipe_image": recipe["recipe_image"],
    "fav_id": recipe["fav_id"], // ✅ ได้ค่าจริงแล้วจากฐานข้อมูล
    "ingredients": ingredients,
  };
}

}
