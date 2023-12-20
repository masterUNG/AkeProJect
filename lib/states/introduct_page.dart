import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gocheckproj/utility/app_constant.dart';
import 'package:gocheckproj/widgets/widget_image_asset.dart';
import 'package:gocheckproj/widgets/widget_text.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroductPage extends StatefulWidget {
  const IntroductPage({super.key});

  @override
  State<IntroductPage> createState() => _IntroductPageState();
}

class _IntroductPageState extends State<IntroductPage> {
  var pathImages = <String>[
    'images/doctor1.png',
    'images/doctor2.png',
    'images/doctor3.png',
  ];

  var titles = <String>[
    'หัวข้ออธิบาย 1',
    'หัวข้ออธิบาย 2',
    'หัวข้ออธิบาย 3',
  ];
  var textBody = <String>[
    'ส่วนขยายความ 1',
    'ส่วนขยายความ 2',
    'ส่วนขยายความ 3',
  ];

  var pages = <PageViewModel>[];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < pathImages.length; i++) {
      pages.add(
        PageViewModel(
          image: WidgetImageAsset(
            path: pathImages[i],
          ),
          title: titles[i],
          body: textBody[i],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: IntroductionScreen(
        pages: pages,
        onDone: () {
          var user = GetStorage().read('user');
          if (user == null) {
            //signout status
            Get.offAllNamed('/authen');
          } else {
            //signIn status
            Get.offAllNamed('/pincode');
          }
        },
        done: WidgetText(
          data: 'Go!',
          textStyle: AppConstant().h2style(),
        ),
        showSkipButton: true,
        skip: const WidgetText(data: 'Skip'),
        showNextButton: true,
        next: const WidgetText(data: 'next'),
      )),
    );
  }
}
