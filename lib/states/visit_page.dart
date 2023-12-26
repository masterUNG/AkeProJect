import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocheckproj/utility/app_constant.dart';
import 'package:gocheckproj/utility/app_controllor.dart';
import 'package:gocheckproj/utility/app_service.dart';
import 'package:gocheckproj/widgets/widget_icon_button.dart';
import 'package:gocheckproj/widgets/widget_text.dart';
import 'package:gocheckproj/widgets/widget_text_rich.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class VisitPage extends StatefulWidget {
  const VisitPage({super.key});

  @override
  State<VisitPage> createState() => _VisitPageState();
}

class _VisitPageState extends State<VisitPage> {
  AppController appController = Get.put(AppController());

  @override
  void initState() {
    super.initState();
    AppService()
        .processFindMapUser()
        .then((value) => AppService().readMedicalTreatResult());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: WidgetIconButton(
          iconData: Icons.arrow_back,
          preesFunc: () => Get.offAllNamed('/mainHome'),
        ),
        title: const WidgetText(
            data: 'การมารักษา', textStyle: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
      ),
      body: Obx(() {
        return appController.medicalTreatModel.isEmpty
            ? const SizedBox()
            : ListView.builder(
                reverse: false,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: appController.medicalTreatModel.length,
                itemBuilder: (context, index) => Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: index % 2 == 1
                        ? Colors.white
                        : AppConstant.blueColor.withOpacity(0.05),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 1,
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          WidgetText(
                            data: 'วันไปตรวจ',
                            textStyle: AppConstant().h2style(size: 16),
                          ),
                          WidgetText(
                              data:
                                  'โรงพยาบาล : ${_getHospitalName(appController.medicalTreatModel[index].hospitalCode)}')
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        WidgetText(
                          data: AppService().changeDateTimeToString(
                              dateTimeString: appController
                                  .medicalTreatModel[index].vstdate)),
                                  WidgetText_Rich(
                          head: 'HN :',
                          tail: appController
                              .medicalTreatModel[index].hn),
                      ],),
                      
                      WidgetText_Rich(
                          head: 'คลินิก',
                          tail: appController
                              .medicalTreatModel[index].spcltyname),
                      WidgetText(
                        data: 'การรักษา',
                        textStyle: AppConstant().h2style(size: 16),
                      ),
                      WidgetText_Rich(
                          head: 'สิทธิ์การรักษา',
                          tail: appController
                              .medicalTreatModel[index].pttypename),
                      WidgetText_Rich(
                          head: 'แพทย์ผู้ตรวจ',
                          tail: appController
                              .medicalTreatModel[index].doctorname),
                      ExpansionTile(
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        title: const WidgetText(data: 'ข้อมูลทั่วไป'),
                        children: [
                          WidgetText_Rich(
                              head: 'แพทย์ผู้ตรวจ',
                              tail: appController
                                  .medicalTreatModel[index].doctorname),
                          ExpansionTile(
                            expandedCrossAxisAlignment:
                                CrossAxisAlignment.start,
                            title:
                                const WidgetText(data: 'ผลตรวจร่างกายทั่วไป'),
                            children: [
                              WidgetText_Rich(
                                  head: 'BMI',
                                  tail: appController
                                      .medicalTreatModel[index].doctorname
                                      .toString()),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
      }),
    );
  }

  String _getHospitalName(String hospitalCode) {
    switch (hospitalCode) {
      case 'ABHAKORN':
        return 'อาภากร';
      case 'PINKLAO':
        return 'สมเด็จพระปิ่นเกล้า';
      case 'SIRIKIT':
        return 'สมเด็จพระนางเจ้าสิริกิติ์';
      default:
        return 'ไม่พบข้อมูลโรงพยาบาล';
    }
  }
}
