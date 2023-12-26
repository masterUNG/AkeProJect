import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gocheckproj/states/authen.dart';
import 'package:gocheckproj/states/checkup_page.dart';
import 'package:gocheckproj/states/introduct_page.dart';
import 'package:gocheckproj/states/main_home.dart';
import 'package:gocheckproj/states/pincode.dart';
import 'package:gocheckproj/states/visit_page.dart';
import 'package:intl/date_symbol_data_local.dart';

var getPages = <GetPage<dynamic>>[
  GetPage(
    name: '/authen',
    page: () => const Authen(),
  ),
  GetPage(
    name: '/pincode',
    page: () => const PinCode(),
  ),
  GetPage(
    name: '/mainHome',
    page: () => const MainHome(),
  ),
  GetPage(
    name: '/intro',
    page: () => const IntroductPage(),
  ),
  GetPage(
    name: '/checkup',
    page: () => const CheckUpPage(),
  ),
  GetPage(
    name: '/visit',
    page: () => const VisitPage(),
  ),
];

String? firsPage;

Future<void> main() async {
  HttpOverrides.global = MyHttpOverride();

  await GetStorage.init().then((value) {
    bool displayIntro = GetStorage().read('intro') ?? true;

    if (displayIntro) {
      firsPage = '/intro';
      runApp(const MyApp());
    } else {
      var user = GetStorage().read('user');

      if (user == null) {
        firsPage = '/authen';
        runApp(const MyApp());
      } else {
        firsPage = '/pincode';
        runApp(const MyApp());
      }
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('th');
    return GetMaterialApp(
      getPages: getPages,
      initialRoute: firsPage,
    );
  }
}

class MyHttpOverride extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}
