import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocheckproj/utility/app_controllor.dart';
import 'package:gocheckproj/widgets/body_main.dart';
import 'package:gocheckproj/widgets/body_profile.dart';
import 'package:gocheckproj/widgets/widget_text.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  var titles = <String>[
    'Main',
    'Profile',
  ];

  var iconWidgets = <Widget>[
    const Icon(Icons.home_outlined),
    const Icon(Icons.person_outline),
  ];

  var bodys = <Widget>[
    const BodyMain(),
    const BodyProfile(),
  ];

  AppController appController = Get.put(AppController());

  var items = <BottomNavigationBarItem>[];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < bodys.length; i++) {
      items.add(
        BottomNavigationBarItem(icon: iconWidgets[i], label: titles[i],backgroundColor: Colors.indigo),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        
        body: bodys[appController.indexBody.value],
        bottomNavigationBar: BottomNavigationBar(
          items: items,
          onTap: (value) {
            appController.indexBody.value = value;
          },
        ),
      );
    });
  }
}
