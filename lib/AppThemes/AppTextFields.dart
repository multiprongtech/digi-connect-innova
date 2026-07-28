import 'package:flutter/material.dart';

class AppTextFields {
  static InputDecoration roundedBorder({
    String? labelText,
    String? hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    Color borderColor = Colors.grey,
    Color? labelColor,
    Color hintColor = Colors.grey,
    Color backgroundColor = Colors.transparent,
    bool enabled = true,
  }) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
      counterText: "",
      labelText: labelText,
      fillColor: backgroundColor,
      filled: true,
      enabled: enabled,
      labelStyle: TextStyle(
        color: labelColor,
      ),
      hintText: hintText,
      hintStyle: TextStyle(
        color: hintColor,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.bold,
      ),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(
          color: borderColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(
          color: borderColor,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(
          color: borderColor,
        ),
      ),
    );
  }
}
