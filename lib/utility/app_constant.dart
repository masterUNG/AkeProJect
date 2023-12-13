import 'package:flutter/material.dart';

class AppConstant {
  //field
  static String appName = 'GoCheck NEXT';
  static Color primaryColor = Color.fromARGB(255, 31, 128, 60);
  static Color mainColor = Color.fromARGB(255, 57, 194, 248);

  //method

  BoxDecoration basicBox() {
    return BoxDecoration(color: mainColor.withOpacity(0.5));
  }

  BoxDecoration linearBox() {
    return BoxDecoration(
      gradient: LinearGradient(
          colors: [Colors.white, mainColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight),
    );
  }

  BoxDecoration radioBox() {
    return BoxDecoration(
      gradient: RadialGradient(
          colors: [Colors.white, mainColor],
          radius: 1.0,
          center: const Alignment(0, -0.8)),
    );
  }

  TextStyle h1style() {
    return const TextStyle(fontSize: 36, fontWeight: FontWeight.bold);
  }

  TextStyle h2style() {
    return const TextStyle(fontSize: 22, fontWeight: FontWeight.w700);
  }

  TextStyle h3style() {
    return const TextStyle(fontSize: 14, fontWeight: FontWeight.normal);
  }
}
