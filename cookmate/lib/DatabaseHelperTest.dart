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
  static Future<List<Map<String, String>>> fetchRecipes() async {
    final conn = await _connectToDatabase();
    var results = await conn.execute('SELECT * FROM Recipes');

    List<Map<String, String>> Recipes =
        results.rows.map((row) {
          return row.assoc().map(
            (key, value) => MapEntry(key, value ?? ''),
          ); // แปลง null เป็น string ว่าง
        }).toList();
    print(Recipes);
    await conn.close();
    return Recipes;
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

    // ดึงเฉพาะวัตถุดิบที่ผู้ใช้เคยเพิ่มข้อมูล (expDate หรือ description ต้องไม่ว่าง)
    var results = await conn.execute('''
    SELECT * FROM Ingredient 
    WHERE exp_Date IS NOT NULL OR description IS NOT NULL
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
}
