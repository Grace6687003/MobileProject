// import 'package:mysql1/mysql1.dart';

// class DatabaseHelper {
//   // การเชื่อมต่อกับฐานข้อมูล
//   static Future<MySqlConnection> _connectToDatabase() async {
//     try {
//       final conn = await MySqlConnection.connect(
//         ConnectionSettings(
//           host: '172.20.10.6', // IP Address ของ MySQL
//           port: 3306, // Port 3306 สำหรับ MySQL
//           user: 'root', // ชื่อผู้ใช้
//           password: '6687003', // รหัสผ่าน
//           db: 'cookmate1_db', // ชื่อฐานข้อมูล
//         ),
//       );
//       print('Connected to MySQL server.');
//       return conn;
//     } catch (e) {
//       print('Error connecting to database: $e');
//       rethrow; // ข้อผิดพลาดจะถูกโยนไปยังผู้เรียกใช้
//     }
//   }

//   // ทดสอบการเชื่อมต่อ
//   static Future<void> testConnection() async {
//     try {
//       final conn = await _connectToDatabase();
//       print('Connection Successful');
//       await conn.close();  // ปิดการเชื่อมต่อ
//     } catch (e) {
//       print('Failed to connect to database: $e');
//     }
//   }

//   // การแทรกข้อมูล
//   static Future<void> insertRecipe(String recipeId, String recipeName, String instructions) async {
//     try {
//       final conn = await _connectToDatabase();
//       await conn.query(
//         'INSERT INTO recipes (recipe_id, recipe_name, instruction) VALUES (?, ?, ?)', 
//         [recipeId, recipeName, instructions],
//       );
//       print('Recipe Inserted');
//       await conn.close();
//     } catch (e) {
//       print('Failed to insert recipe: $e');
//     }
//   }

//   // การอัพเดตข้อมูล
//   static Future<void> updateRecipe(String recipeId, String recipeName, String instructions) async {
//     try {
//       final conn = await _connectToDatabase();
//       await conn.query(
//         'UPDATE recipes SET recipe_name = ?, instruction = ? WHERE recipe_id = ?', 
//         [recipeName, instructions, recipeId],
//       );
//       print('Recipe Updated');
//       await conn.close();
//     } catch (e) {
//       print('Failed to update recipe: $e');
//     }
//   }

//   // การลบข้อมูล
//   static Future<void> deleteRecipe(String recipeId) async {
//     try {
//       final conn = await _connectToDatabase();
//       await conn.query('DELETE FROM recipes WHERE recipe_id = ?', [recipeId]);
//       print('Recipe Deleted');
//       await conn.close();
//     } catch (e) {
//       print('Failed to delete recipe: $e');
//     }
//   }

//   // การดึงข้อมูล
//   static Future<List<Map<String, dynamic>>> fetchRecipes() async {
//     try {
//       final conn = await _connectToDatabase();
//       var results = await conn.query('SELECT recipe_id, recipe_name, instruction FROM recipes');
//       List<Map<String, dynamic>> recipes = [];
//       for (var row in results) {
//         recipes.add({
//           'recipe_id': row[0],
//           'recipe_name': row[1],
//           'instruction': row[2],
//         });
//       }
//       await conn.close();
//       return recipes;
//     } catch (e) {
//       print('Failed to fetch recipes: $e');
//       return [];
//     }
//   }
// }


import 'package:mysql1/mysql1.dart';

class DatabaseHelper {
  static Future<MySqlConnection> _connectToDatabase() async {
    try {
      final conn = await MySqlConnection.connect(
        ConnectionSettings(
          host: '172.20.10.6', // เปลี่ยนเป็น IP Address ของ MySQL
          port: 3306, // Port 3306 สำหรับ MySQL
          user: 'root', // ชื่อผู้ใช้ของ MySQL
          password: '6687003', // รหัสผ่านของ MySQL
          db: 'cookmate1_db', // ชื่อฐานข้อมูลที่ต้องการเชื่อมต่อ
        ),
      );
      print('Connected to MySQL server.');
      return conn;
    } catch (e) {
      print('Error connecting to database: $e');
      rethrow; // ข้อผิดพลาดจะถูกโยนไปยังผู้เรียกใช้
    }
  }

  // ฟังก์ชันทดสอบการเชื่อมต่อ
  static Future<void> testConnection() async {
    final conn = await _connectToDatabase();
    print('Connection Successful');
    await conn.close();
  }


  // ฟังก์ชันดึงข้อมูลเมนูจากฐานข้อมูล
  static Future<List<Map<String, dynamic>>> fetchRecipes() async {
    final conn = await _connectToDatabase();
    var results = await conn.query('SELECT recipe_id, recipe_name, instruction FROM Recipes');
  
    List<Map<String, dynamic>> recipes = [];
    
    for (var row in results) {
      
      recipes.add({
        
        'recipe_id': row[0],
        'recipe_name': row[1],
        'instruction': row[2],
      });
    }
    
    await conn.close();
    return recipes;
  }


  // ฟังก์ชันดึงข้อมูลวัตถุดิบจากฐานข้อมูล
  static Future<List<Map<String, dynamic>>> fetchIngredients() async {
    final conn = await _connectToDatabase();
    var results = await conn.query('SELECT ingredient_id, ingredient_name, categories_name, categories_image, exp_date, description FROM Ingredient');
    
    List<Map<String, dynamic>> ingredients = [];
    for (var row in results) {
      ingredients.add({
        'ingredient_id': row[0],
        'ingredient_name': row[1],
        'categories_name': row[2],
        'categories_image': row[3],
        'exp_date': row[4],
        'description': row[5],
      });
    }
    await conn.close();
    return ingredients;
  }

  // ฟังก์ชันเพิ่มเมนู
  static Future<void> insertRecipe(String recipeId, String recipeName, String instructions) async {
    final conn = await _connectToDatabase();
    await conn.query(
      'INSERT INTO Recipes (recipe_id, recipe_name, instruction) VALUES (?, ?, ?)', 
      [recipeId, recipeName, instructions],
    );
    await conn.close();
  }

  // ฟังก์ชันอัปเดตเมนู
  static Future<void> updateRecipe(String recipeId, String recipeName, String instructions) async {
    final conn = await _connectToDatabase();
    await conn.query(
      'UPDATE Recipes SET recipe_name = ?, instruction = ? WHERE recipe_id = ?', 
      [recipeName, instructions, recipeId],
    );
    await conn.close();
  }

  // ฟังก์ชันลบเมนู
  static Future<void> deleteRecipe(String recipeId) async {
    final conn = await _connectToDatabase();
    await conn.query('DELETE FROM Recipes WHERE recipe_id = ?', [recipeId]);
    await conn.close();
  }
}
