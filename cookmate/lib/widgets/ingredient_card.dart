import 'package:flutter/material.dart';
import '../models/ingredient_model.dart';
import 'package:cookmate/DatabaseHelperTest.dart';
import 'package:cookmate/pages/ingredients/edit_ingredient_page.dart';

class IngredientCard extends StatelessWidget {
  final IngredientModel ingredient;
  final VoidCallback onDelete;
  final VoidCallback onUpdate; 

  const IngredientCard({
    super.key,
    required this.ingredient,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditIngredientPage(
              ingredientName: ingredient.name,
              description: ingredient.description,
              expDate: ingredient.expDate?.toIso8601String(),
              imagePath: ingredient.imagePath.isNotEmpty
                  ? ingredient.imagePath
                  : 'assets/images/default.png',
            ),
          ),
        ).then((_) {
          onUpdate(); 
        });
      },
      child: Container(
        width: 254,
        height: 128,
        margin: const EdgeInsets.only(right: 0, left: 10, bottom: 8),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: const Color(0xffc3e090),
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              spreadRadius: 0,
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // รูปวัตถุดิบ
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    ingredient.imagePath.isNotEmpty
                        ? ingredient.imagePath
                        : 'assets/images/default.png',
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
     
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 0),
                    child: Text(
                      ingredient.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: 'NotoSansThai',
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Text(
                    ingredient.status,
                    style: const TextStyle(
                      color: Color(0xFFE23D3D),
                      fontSize: 14,
                      fontFamily: 'NotoSansThai',
                      fontWeight: FontWeight.w500,
                    ),
                    softWrap: false,
                    overflow: TextOverflow.visible,
                  ),
                ],
              ),
            ),
  
            Align(
              alignment: Alignment.bottomCenter,
              child: IconButton(
                onPressed: () async {
                  await DatabaseHelperTest.clearIngredientDetails(
                    ingredientName: ingredient.name,
                  );
                  onDelete(); 
                },
                icon: const Icon(Icons.delete, color: Colors.red),
                iconSize: 34,
                padding: const EdgeInsets.only(right: 20),
                constraints: const BoxConstraints(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
