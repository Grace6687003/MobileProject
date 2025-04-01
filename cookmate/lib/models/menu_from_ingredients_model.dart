class MenuFromIngredientsModel {
  final String name;
  final String imagePath;
  final bool isFavorited;

  MenuFromIngredientsModel({
    required this.name,
    required this.imagePath,
    required this.isFavorited,
  });

  static List<MenuFromIngredientsModel> getMenus() {
    return [
      MenuFromIngredientsModel(
        name: 'ลาบหมู',
        imagePath: 'assets/images/menu/REC001.jpg',
        isFavorited: false,
      ),
      MenuFromIngredientsModel(
        name: 'ข้าวกะเพราหมูสับ ไข่ดาว',
        imagePath: 'assets/images/menu/REC006.jpg',
        isFavorited: true,
      ),
      MenuFromIngredientsModel(
        name: 'ข้าวกะเพราหมูสับ ไข่ดาว',
        imagePath: 'assets/images/menu/REC006.jpg',
        isFavorited: true,
      ),
      MenuFromIngredientsModel(
        name: 'ข้าวกะเพราหมูสับ ไข่ดาว',
        imagePath: 'assets/images/menu/REC006.jpg',
        isFavorited: true,
      ),
    ];
  }
}
