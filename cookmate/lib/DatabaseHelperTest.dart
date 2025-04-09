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

   // ฟังก์ชันทดสอบการเชื่อมต่อ
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

  // ดึงข้อมูลหมวดหมู่พร้อมวัตถุดิบ
  static Future<List<Map<String, dynamic>>> fetchCategoriesWithIngredients() async {
    final conn = await _connectToDatabase();

    // SQL query สำหรับดึงหมวดหมู่และวัตถุดิบ
    var results = await conn.execute('''
      SELECT ingredient_id, ingredient_name, Categories_name, Categories_image 
      FROM ingredients
      WHERE Categories_name IS NOT NULL
    ''');

    List<Map<String, dynamic>> categoriesWithIngredients = results.rows.map((row) {
      return row.assoc().map(
        (key, value) => MapEntry(key, value ?? ''),
      ); // แปลง null เป็นค่าว่าง
    }).toList();

    await conn.close();
    return categoriesWithIngredients;
  }

// ดึงข้อมูลวัตถุดิบตามหมวดหมู่ (เช่น "เนื้อสัตว์")
static Future<List<Map<String, String>>> fetchIngredientsByCategory(String categoryName) async {
  final conn = await _connectToDatabase();

  // ปรับให้ใช้ชื่อตารางจริงที่คุณใช้ เช่น 'ingredients' หรือ 'ingredient'
  var results = await conn.execute(
    '''
    SELECT * FROM Ingredient 
    WHERE Categories_name = :categoryName
    ''',
    {
      "categoryName": categoryName,
    },
  );

  List<Map<String, String>> ingredients = results.rows.map((row) {
    return row.assoc().map((key, value) => MapEntry(key, value ?? ''));
  }).toList();

  await conn.close();
  return ingredients;
}

// ฟังก์ชันดึงข้อมูลวัตถุดิบทั้งหมด
  static Future<List<Map<String, String>>> fetchAllIngredients() async {
    final conn = await _connectToDatabase();

    // ดึงข้อมูลทั้งหมดจากตาราง Ingredient
    var results = await conn.execute('SELECT * FROM Ingredient');

    // แปลงผลลัพธ์เป็น List<Map<String, String>>
    List<Map<String, String>> ingredients = results.rows.map((row) {
      return row.assoc().map((key, value) => MapEntry(key, value ?? ''));
    }).toList();

    await conn.close();
    return ingredients;
  }
static Future<List<Map<String, String>>> fetchExpiringIngredients() async {
  final conn = await _connectToDatabase();

  // SQL query ที่เลือกวัตถุดิบที่หมดอายุในช่วง 7 วัน
  var results = await conn.execute(
    '''
    SELECT * FROM Ingredient
    WHERE DATEDIFF(exp_date, CURDATE()) <= 7 AND DATEDIFF(exp_date, CURDATE()) >= 0
    ''',
  );

  List<Map<String, String>> expiringIngredients = results.rows.map((row) {
    return row.assoc().map((key, value) => MapEntry(key, value ?? ''));
  }).toList();

  await conn.close();
  return expiringIngredients;
}


// บันทึกวัตถุดิบที่ผู้ใช้เลือก พร้อมรายละเอียดและวันหมดอายุ
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
}
// static Future<void> insertIngredientInstance({
//   required String ingredientName,
//   String? description,
//   required String expDate, // แก้ชื่อให้ตรง exp_date
// }) async {
//   final conn = await _connectToDatabase();

//   await conn.execute(
//     '''
//     INSERT INTO Ingredient (ingredient_name, description, exp_date)
//     VALUES (:ingredientName, :description, :expDate)
//     ''',
//     {
//       "ingredientName": ingredientName,
//       "description": description ?? '',
//       "expDate": expDate,
//     },
//   );

//   await conn.close();
// }



// }


// ดึงข้อมูลวัตถุดิบตามหมวดหมู่ (เช่น "เนื้อสัตว์")

  //  static Future<List<String>> fetchIngredientsByCategory(String category) async {
  //   final conn = await _connectToDatabase();  // เชื่อมต่อฐานข้อมูล
  //   var results = await conn.execute('''
  //     SELECT ingredient_name
  //     FROM ingredients
  //     WHERE Categories_name = ?
  //   ''',);  // ส่ง category เป็นค่าภายใน List

  //   // ใช้ map เพื่อแปลงแถวผลลัพธ์เป็นรายการของชื่อวัตถุดิบ
  //   List<String> ingredients = results.rows.map((row) {
  //     return row.assoc()['ingredient_name'] as String;  // ดึงชื่อวัตถุดิบจาก Map
  //   }).toList();

  //   await conn.close();  // ปิดการเชื่อมต่อกับฐานข้อมูล
  //   return ingredients;  // ส่งกลับรายการวัตถุดิบที่ดึงมา
  // }
  // ฟังก์ชันดึงข้อมูลวัตถุดิบจากฐานข้อมูลตามหมวดหมู่
  // static Future<List<Map<String, String>>> fetchIngredientsByCategory(String category) async {
  //   final conn = await _connectToDatabase();  // เชื่อมต่อฐานข้อมูล

  //   // ตรวจสอบว่า category ไม่เป็น null หรือค่าว่าง
  //   if (category == null || category.isEmpty) {
  //     throw Exception("Category cannot be null or empty");
  //   }

  //   // ใช้คำสั่ง SQL โดยไม่ใช้ placeholder
  //   var results = await conn.execute('''
  //     SELECT ingredient_id, ingredient_name, Categories_name, Categories_image
  //     FROM ingredients
  //     WHERE Categories_name = '$category'  // แทนที่ category ลงใน query
  //   ''');

  //   // ใช้ map เพื่อแปลงแถวผลลัพธ์เป็นรายการของ Map<String, String>
  //   List<Map<String, String>> ingredients = results.map((row) {
  //     return row.assoc().map(
  //       (key, value) => MapEntry(key, value ?? ''),  // แปลง null เป็น string ว่าง
  //     );
  //   }).toList();

  //   await conn.close();  // ปิดการเชื่อมต่อกับฐานข้อมูล
  //   return ingredients;  // ส่งกลับรายการวัตถุดิบที่ดึงมา
  // }

//    static Future<List<Map<String, String>>> fetchIngredientsByCategory(String category) async {
//     final conn = await _connectToDatabase();
//     var results = await conn.execute('''
//       SELECT ingredient_id, ingredient_name, Categories_name, Categories_image
//       FROM ingredients
//       WHERE Categories_name = '$category'  // แทนที่ category ลงใน query
//     ''');

//     List<Map<String, String>> ingredients =
//         results.rows.map((row) {
//           return row.assoc().map(
//             (key, value) => MapEntry(key, value ?? ''),
//           ); // แปลง null เป็น string ว่าง
//         }).toList();
//     print(ingredients);
//     await conn.close();
//     return ingredients;
// }

  

