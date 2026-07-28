import 'package:flutter/material.dart';
import 'package:digi_connect/AppThemes/AppTextStyle.dart';
import 'package:get/get.dart';

//: home row
class FormPageHeader extends StatelessWidget {
  FormPageHeader({super.key, required this.header});
  String header;

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
            header,
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
