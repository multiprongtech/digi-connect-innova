import 'package:digi_connect/HomePage/Model/home_page_model.dart';
import 'package:flutter/material.dart';
import 'package:digi_connect/AppThemes/AppTextStyle.dart';
import 'dart:math';

class CategoryCard extends StatelessWidget {
  CategoryCard({super.key, this.category});
  Categories? category;

  Color _getRandomColor() {
    Random random = Random();
    Color tempcol = Color.fromRGBO(
      random.nextInt(255),
      random.nextInt(255),
      random.nextInt(255),
      0.3,
    );
    return tempcol;
  }

  Color _getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return Color(int.parse(hexColor, radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        color: (category == null)
            ? _getRandomColor()
            : _getColorFromHex(category!.colour ?? ''),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            category?.image ?? '',
            width: 40,
            height: 40,
          ),
          AppTextStyles.blankHeight(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              '${category?.title}',
              style: AppTextStyles.boldSubTitle(context, color: Colors.white),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
