import 'package:flutter/material.dart';

class CategoryPanel extends StatelessWidget {
  final String category;
  final double height;
  final double width;
  final Color backgroundColor;
  final String title;
  final Color titleColor;
  final FontWeight titleFontWeight;
  final Widget image;

  const CategoryPanel({
    Key? key,
    required this.category, 
    required this.height,
    required this.width,
    required this.backgroundColor,
    required this.title,
    this.titleColor = Colors.black,
    this.titleFontWeight = FontWeight.bold,
    required this.image, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, 'category', arguments: category),
      child: Container( 
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: backgroundColor,
        ),
        child: Stack( 
          children: [
            Positioned(
              top: 10,
              left: 12,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15.0,
                  color: titleColor,
                  fontWeight: titleFontWeight,
                ),
              ),
            ),
            image,
          ],
        ),
      ),
    );
  }
}
