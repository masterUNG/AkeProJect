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
    }
    );
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
                      borderRadius: BorderRadius.circular(15),
                      color: index % 2 == 1
                          ? Colors.white
                          : Colors.blueGrey.withOpacity(0.01),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 238, 238, 238),
                          spreadRadius: 2,
                          blurRadius: 0,
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
                        //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                        if (matchingDrugModels.isNotEmpty)
                          ExpansionTile(
                            backgroundColor: Colors.black12,
                            collapsedBackgroundColor:
                                const Color.fromARGB(255, 129, 159, 173),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            collapsedShape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            expandedCrossAxisAlignment:
                                CrossAxisAlignment.start,
                            title: const Center(
                              child: WidgetText(
                                data: 'ยาที่ได้รับ',
                                textStyle: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: DataTable(
                                  sortAscending: true,
                                  sortColumnIndex: 1,
                                  showBottomBorder: false,
                                  columns: const [
                                    DataColumn(
                                      label: Text('ลำดับ',
                                          style:
                                              AppConstant.contentStyleHeader),
                                      numeric: true,
                                    ),
                                    DataColumn(
                                      label: Text('รายการ',
                                          style:
                                              AppConstant.contentStyleHeader),
                                    ),
                                    DataColumn(
                                      label: Text('จำนวน',
                                          style:
                                              AppConstant.contentStyleHeader),
                                      numeric: true,
                                    ),
                                    DataColumn(
                                      label: Text('หน่วย',
                                          style:
                                              AppConstant.contentStyleHeader),
                                      numeric: true,
                                    ),
                                  ],
                                  rows: matchingDrugModels
                                      .asMap()
                                      .entries
                                      .map<DataRow>((entry) {
                                    final bool isEven = entry.key.isEven;
                                    return DataRow(
                                      color: isEven
                                          ? MaterialStateProperty.all<Color>(
                                              Colors.white.withOpacity(0.3))
                                          : null,
                                      cells: [
                                        DataCell(
                                          Text('${entry.key + 1}',
                                              style: AppConstant.contentStyle,
                                              textAlign: TextAlign.center),
                                        ),
                                        DataCell(
                                          Text('${entry.value.name}',
                                              style: AppConstant.contentStyle,
                                              textAlign: TextAlign.start),
                                        ),
                                        DataCell(
                                          Text('${entry.value.qty}',
                                              style: AppConstant.contentStyle,
                                              textAlign: TextAlign.start),
                                        ),
                                        DataCell(
                                          Text('${entry.value.units}',
                                              style: AppConstant.contentStyle,
                                              textAlign: TextAlign.start),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ),
                              // ตำแหน่งที่เป็น children ของ ExpansionTile สำหรับ DataTable
                            ],
                          ),
                        const SizedBox(
                          height: 2,
                        ),
                        //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

                        if (matchingLabModels.isNotEmpty)
                          ExpansionTile(
                            backgroundColor: Colors.black12,
                            collapsedBackgroundColor:
                                const Color.fromARGB(255, 129, 159, 173),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            collapsedShape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            expandedCrossAxisAlignment:
                                CrossAxisAlignment.start,
                            title: const Center(
                              child: WidgetText(
                                data: 'ตรวจ Lab',
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: DataTable(
                                  sortAscending: true,
                                  sortColumnIndex: 1,
                                  showBottomBorder: false,
                                  columns: const [
                                    DataColumn(
                                      label: Text('ลำดับ',
                                          style:
                                              AppConstant.contentStyleHeader),
                                      numeric: true,
                                    ),
                                    DataColumn(
                                      label: Text('รายการ',
                                          style:
                                              AppConstant.contentStyleHeader),
                                    ),
                                    DataColumn(
                                      label: Text('ผลตรวจ',
                                          style:
                                              AppConstant.contentStyleHeader),
                                      numeric: true,
                                    ),
                                  ],
                                  rows: matchingLabModels
                                      .asMap()
                                      .entries
                                      .map<DataRow>((entry) {
                                    final bool isEven = entry.key.isEven;
                                    return DataRow(
                                      color: isEven
                                          ? MaterialStateProperty.all<Color>(
                                              Colors.white.withOpacity(0.3))
                                          : null,
                                      cells: [
                                        DataCell(
                                          Text('${entry.key + 1}',
                                              style: AppConstant.contentStyle,
                                              textAlign: TextAlign.center),
                                        ),
                                        DataCell(
                                          Text('${entry.value.lab_items_name}',
                                              style: AppConstant.contentStyle,
                                              textAlign: TextAlign.start),
                                        ),
                                        DataCell(
                                          Text(
                                              '${entry.value.lab_order_result}',
                                              style: AppConstant.contentStyle,
                                              textAlign: TextAlign.start),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ),
                              // ตำแหน่งที่เป็น children ของ ExpansionTile สำหรับ DataTable
                            ],
                          ),
// ...
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
