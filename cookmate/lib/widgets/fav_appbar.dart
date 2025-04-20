import 'package:flutter/material.dart';
import 'package:cookmate/pages/home_page.dart'; 

class CustomfavAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool goHomeInsteadOfPop;

  const CustomfavAppBar({
    super.key,
    required this.title,
    this.goHomeInsteadOfPop = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(150);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFFEDB71),
      elevation: 0,
      automaticallyImplyLeading: false,
      flexibleSpace: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: _buildPaperBagImage(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 8),
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
    );
  }

  Widget _buildPaperBagImage() {
    return Padding(
      padding: const EdgeInsets.only(left: 150.0, bottom: 0.5555),
      child: Center(
        child: Image.asset(
          'assets/images/ui/favorite_page.png',
          width: 200,
          height: 120,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
