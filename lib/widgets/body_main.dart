import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocheckproj/utility/app_constant.dart';
import 'package:gocheckproj/utility/app_controllor.dart';
import 'package:gocheckproj/utility/app_service.dart';
import 'package:gocheckproj/widgets/widget_image_asset.dart';
import 'package:gocheckproj/widgets/widget_text.dart';

class BodyMain extends StatefulWidget {
  const BodyMain({super.key});

  @override
  State<BodyMain> createState() => _BodyMainState();
}

class _BodyMainState extends State<BodyMain> {
  AppController appController = Get.put(AppController());

  var hieght, width;

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

  var pathImages = <String>[
    'images/image1.png',
    'images/image2.png',
    'images/image3.png',
    'images/image4.png',
    'images/image5.png',
    'images/image6.png',
  ];

  var titles = <String>[
    'ตรวจสุขภาพ',
    'การมารักษา',
    'การตรวจ Lab',
    'การได้รับยา',
    'ประวัติรับวัคซีน',
    'สมรรถภาพทางกาย ทร.',
  ];

  var items = <Widget>[];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < titles.length; i++) {
      items.add(
        InkWell(
          onTap: () {
            if (keyPages[i].isNotEmpty) {
              Get.toNamed(keyPages[i]);
            }
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  spreadRadius: 1,
                  blurRadius: 6,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                WidgetImageAsset(
                  path: pathImages[i],
                  width: 80,
                ),
                WidgetText(
                  data: titles[i],
                  textStyle: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      );
    }
    AppService()
        .processFindMapUser()
        .then((value) => AppService().readCheckUpResult());
  }

  @override
  Widget build(BuildContext context) {
    hieght = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Obx(() {
        var latestCheckUp = appController.checkUpModel.isNotEmpty
            ? appController.checkUpModel.last
            : null;
        return SingleChildScrollView(
          child: Container(
            color: Colors.indigo,
            //height: hieght,
            width: width,
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(),
                  height: hieght * 0.3,
                  width: width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 45, left: 15, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          'images/splash200.png'))),
                            ),
                            Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          'images/avatar_profile_icon.png'))),
                            )
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                            top: 1,
                            left: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const WidgetText(
                                data: 'รายการสุขภาพของท่าน',
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  letterSpacing: 0.5,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  WidgetText(
                                    data: latestCheckUp?.pname.toString() ??
                                        'N/A',
                                    textStyle: const TextStyle(
                                      color: Colors.white54,
                                      fontSize: 16,
                                    ),
                                  ),
                                  WidgetText(
                                    data: latestCheckUp?.fname.toString() ??
                                        'N/A',
                                    textStyle: const TextStyle(
                                      color: Colors.white54,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  WidgetText(
                                    data: latestCheckUp?.lname.toString() ??
                                        'N/A',
                                    textStyle: const TextStyle(
                                      color: Colors.white54,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              //คำนวณอายุก่อนส่งให้ WidgetText
                              WidgetText(
                                data: latestCheckUp != null
                                    ? 'อายุ ${_calculateAge(DateTime.parse(latestCheckUp.birthday!.toString()))} ปี'
                                    : 'N/A',
                                textStyle: const TextStyle(
                                  color: Colors.white54,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  // height: hieght ,
                  width: width,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.1,
                      mainAxisSpacing: 25,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: pathImages.length,
                    itemBuilder: (context, index) => items[index],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  String _calculateAge(DateTime birthday) {
    DateTime today = DateTime.now();
    int age = today.year - birthday.year;
    return age.toString();
  }
}
