import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocheckproj/utility/app_constant.dart';
import 'package:gocheckproj/widgets/widget_image_asset.dart';
import 'package:gocheckproj/widgets/widget_text.dart';

class BodyMain extends StatefulWidget {
  const BodyMain({super.key});

  @override
  State<BodyMain> createState() => _BodyMainState();
}

class _BodyMainState extends State<BodyMain> {
  var keyPages = <String>[
    '/checkup',
    '/visit',
    '',
    '',
    '',
    '',
    '',
    '',
  ];

  var titles = <String>[
    'ประวัติการตรวจสุขภาพ',
    'ประวัติการมารักษา',
    'ประวัติการตรวจ Lab',
    'ประวัติได้รับยา',
    'ประวัติการ X-Ray',
    'ประวัติแพ้ยา',
    'ประวัติรับวัคซีน',
    'สมรรถภาพทางกาย ทร.',
  ];

  var pathImages = <String>[
    'images/image1.png',
    'images/image2.png',
    'images/image3.png',
    'images/image4.png',
    'images/image5.png',
    'images/image6.png',
    'images/image7.png',
    'images/image8.png',
  ];

  var items = <Widget>[];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < titles.length; i++) {
      items.add(InkWell(
        onTap: () {
          print('คุณแตะที่ >>>>>> $i');
          if (keyPages[i].isNotEmpty) {
            Get.toNamed(keyPages[i]);
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                  colors: [Colors.white, AppConstant.mainColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)
              //color: AppConstant.primaryColor.withOpacity(0.2),
              ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              WidgetImageAsset(
                path: pathImages[i],
                width: 80,
              ),
              WidgetText(data: titles[i]),
            ],
          ),
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 20,
          crossAxisSpacing: 8,
          childAspectRatio: 4 / 5),
      itemBuilder: (context, index) => items[index],
    );
  }
}
