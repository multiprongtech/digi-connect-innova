import 'package:digi_connect/HomePage/Model/home_page_model.dart';
import 'package:flutter/material.dart';
import 'package:digi_connect/AppConstant/app_constant.dart';

class BrandCard extends StatelessWidget {
  BrandCard({super.key, this.logo});

  Logos? logo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            logo?.image ??
                'https://cdn.logojoy.com/wp-content/uploads/2018/05/01104846/1952-768x591.png',
            fit: BoxFit.fitWidth,
          ),
        ],
      ),
    );
  }
}
