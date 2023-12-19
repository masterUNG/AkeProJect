import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gocheckproj/states/authen.dart';
import 'package:gocheckproj/states/pincode.dart';

var getPages = <GetPage<dynamic>>[
  GetPage(
    name: '/authen',
    page: () => const Authen(),
  ),
  GetPage(
    name: '/pincode',
    page: () => const PinCode(),
  ),
];

String? firsPage;

Future<void> main() async {
  HttpOverrides.global = MyHttpOverride();

  await GetStorage.init().then((value) {
    var user = GetStorage().read('user');
    print('##19dec user from GetStorage >>> $user');

    if (user == null) {
      firsPage = '/authen';
      runApp(const MyApp());
    } else {
      firsPage = '/pincode';
      runApp(const MyApp());
    }
  });

  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
