import 'package:digi_connect/OnboardPage/onboard_page.dart';
import 'package:digi_connect/option_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'dart:io';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadFont();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(MyApp()));
  runApp(const MyApp());
}

Future<void> loadFont() async {
  await rootBundle.load('Assets/Font/Poppins-Bold.ttf');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: (Platform.isAndroid) ? OnboardPage() : OptionPage(),
    );
  }
}
