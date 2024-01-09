import 'package:flutter/material.dart';

class AppConstant {
  //field

  static String urlLoginApi = 'https://go.nmd.go.th/gohiApiNEXT/Account/login';

  static String contentText =
      'Lorem Ipsum คือ เนื้อหาจำลองแบบเรียบๆ ที่ใช้กันในธุรกิจงานพิมพ์หรืองานเรียงพิมพ์ มันได้กลายมาเป็นเนื้อหาจำลองมาตรฐานของธุรกิจดังกล่าวมาตั้งแต่ศตวรรษที่ 16 เมื่อเครื่องพิมพ์โนเนมเครื่องหนึ่งนำรางตัวพิมพ์มาสลับสับตำแหน่งตัวอักษรเพื่อทำหนังสือตัวอย่าง Lorem Ipsum อยู่ยงคงกระพันมาไม่ใช่แค่เพียงห้าศตวรรษ แต่อยู่มาจนถึงยุคที่พลิกโฉมเข้าสู่งานเรียงพิมพ์ด้วยวิธีทางอิเล็กทรอนิกส์ และยังคงสภาพเดิมไว้อย่างไม่มีการเปลี่ยนแปลง มันได้รับความนิยมมากขึ้นในยุค ค.ศ. 1960';
  static String appName = 'GoCheck NEXT';
  static Color primaryColor = const Color.fromARGB(255, 63, 167, 94);
  static Color mainColor = Colors.indigo;
  static Color blueColor = const Color.fromARGB(255, 17, 32, 252);

 

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

  TextStyle h2style({double? size}) {
    return TextStyle(fontSize: size ?? 22, fontWeight: FontWeight.w700);
  }

  TextStyle h3style({Color? color, FontWeight? fontWeight}) {
    return TextStyle(
        fontSize: 14,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color ?? Colors.black);
  }

  static const contentStyleHeader =
      TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w700);

  static const contentStyle = TextStyle(
      color: Colors.black45, fontSize: 14, fontWeight: FontWeight.normal);
}
