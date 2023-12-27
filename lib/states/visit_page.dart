import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocheckproj/models/drug_model.dart';
import 'package:gocheckproj/models/lab_model.dart';
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
    // เรียก `processFindMapUser` และคอยจนกระทั่งดำเนินการเสร็จสิ้น
    AppService().processFindMapUser().then((value) {
      // เมื่อดำเนินการเสร็จสิ้น, เรียก `readMedicalTreatResult` และคอยจนกระทั่งดำเนินการเสร็จสิ้น
      AppService().readMedicalTreatResult().then((value) {
        // เมื่อ `readMedicalTreatResult` เสร็จสิ้น, เรียก `readDrugResult`
        AppService().readDrugResult();
        AppService().readLabResult();
      });
    });
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
                itemBuilder: (context, index) {
                  //************match ข้อมูล Drug และ medicalTreat *******
                  List<DrugModel> matchingDrugModels = appController.drugModel
                      .where((drugModel) =>
                          drugModel.vstdate ==
                          appController.medicalTreatModel[index].vstdate)
                      .toList();
                  //************match ข้อมูล Lab และ medicalTreat *******
                  List<LabModel> matchingLabModels = appController.labModel
                      .where((labModel) =>
                          labModel.report_date ==
                          appController.medicalTreatModel[index].vstdate)
                      .toList();

                  // print('#######Matching Lab Models: $matchingLabModels');

                  return Container(
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
                              data: 'ตรวจเมื่อวันที่',
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
                                tail:
                                    appController.medicalTreatModel[index].hn),
                          ],
                        ),
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
                        if (matchingDrugModels.isNotEmpty)
                          ExpansionTile(
                            expandedCrossAxisAlignment:
                                CrossAxisAlignment.start,
                            title: const Center(
                              child: WidgetText(
                                data: 'ยาที่ได้รับ',
                                textStyle: TextStyle(
                                  color: Colors.indigo,
                                ),
                              ),
                            ),
                            children:
                                matchingDrugModels.asMap().entries.map((entry) {
                              return Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                    top: BorderSide(color: Colors.blueGrey),
                                  ),
                                ),
                                margin: const EdgeInsets.only(
                                    bottom: 10), // ระยะห่างล่างเส้น
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    WidgetText_Rich(
                                      head: ' ${entry.key + 1} >>',
                                      tail: '${entry.value.name} ',
                                      colorHead: Colors.blueAccent,
                                    ),
                                    WidgetText_Rich(
                                      head: 'จำนวน:',
                                      tail:
                                          'จำนวน = ${entry.value.qty}  ${entry.value.units}',
                                      colorHead: Colors
                                          .lightGreen, // Customize color as needed
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        if (matchingLabModels.isNotEmpty)
                          ExpansionTile(
                            expandedCrossAxisAlignment:
                                CrossAxisAlignment.start,
                                
                            title: const Center(
                              child: WidgetText(
                                data: 'Lab ที่ตรวจ',
                                textStyle: TextStyle(
                                  color: Colors.indigo,
                                ),
                              ),
                            ),
                            children:
                                matchingLabModels.asMap().entries.map((entry) {
                              return Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.blueGrey,
                                      width:
                                          2.0, // Increase the width as needed
                                    ),
                                  ),
                                ),
                                margin: const EdgeInsets.only(
                                    top: 10, bottom: 10), // ระยะห่างล่างเส้น
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    WidgetText_Rich(
                                      head: ' ${entry.key + 1} >>',
                                      tail: '${entry.value.lab_items_name}    ',
                                      colorHead: Colors.blueAccent,
                                    ),
                                    // Additional line using WidgetText_Rich
                                    WidgetText_Rich(
                                      head: 'ค่าปกติ:',
                                      tail:
                                          'ค่าปกติ =  ${entry.value.lab_items_normal_value ?? "--"}',
                                      colorHead: Colors
                                          .lightGreen, // Customize color as needed
                                    ),
                                    WidgetText_Rich(
                                      head: 'ผลตรวจ:',
                                      tail:
                                          'ผลตรวจ =  ${entry.value.lab_order_result ?? "--"}',
                                      colorHead: Colors
                                          .black, // Customize color as needed
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                      ],
                    ),
                  );
                },
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


