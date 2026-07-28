import 'package:digi_connect/HomePage/Model/home_page_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:digi_connect/AppThemes/AppTextStyle.dart';
import 'package:get/get.dart';

//: home row
class ImagePageHeader extends StatelessWidget {
  ImagePageHeader({super.key, required this.category});
  Categories category;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back,
              size: 30,
            ),
          ),
          Text(
            '${category.title}',
            style: AppTextStyles.title(context),
            textAlign: TextAlign.center,
          ),
          Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
              color: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
