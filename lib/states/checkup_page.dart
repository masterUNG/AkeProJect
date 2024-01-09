import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocheckproj/models/checkup_model.dart';
import 'package:gocheckproj/models/lab_model.dart';
import 'package:gocheckproj/utility/app_constant.dart';
import 'package:gocheckproj/utility/app_controllor.dart';
import 'package:gocheckproj/utility/app_service.dart';
import 'package:gocheckproj/widgets/widget_icon_button.dart';
import 'package:gocheckproj/widgets/widget_text.dart';
import 'package:gocheckproj/widgets/widget_text_rich.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class CheckUpPage extends StatefulWidget {
  const CheckUpPage({super.key});

  @override
  State<CheckUpPage> createState() => _CheckUpPageState();
}

class _CheckUpPageState extends State<CheckUpPage> {
  AppController appController = Get.put(AppController());

  @override
  void initState() {
    super.initState();
    // เรียก `processFindMapUser` และคอยจนกระทั่งดำเนินการเสร็จสิ้น
    AppService().processFindMapUser().then((value) {
      // เมื่อดำเนินการเสร็จสิ้น, เรียก `readMedicalTreatResult` และคอยจนกระทั่งดำเนินการเสร็จสิ้น
      AppService().readCheckUpResult().then((value) {
        // เมื่อ `readMedicalTreatResult` เสร็จสิ้น, เรียก `readDrugResult`

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
            data: 'ตรวจสุขภาพประจำปี',
            textStyle: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
      ),
      body: Obx(() {
        if (appController.checkUpModel.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            reverse: false,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: appController.checkUpModel.length,
            itemBuilder: (context, index) {
              //************match ข้อมูล Lab และ medicalTreat *******

              List<LabModel> matchingLabModels = appController.labModel
                  .where((labModel) =>
                      labModel.vn == appController.checkUpModel[index].vn)
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
                      color: Color.fromARGB(255, 224, 224, 224),
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
                        WidgetText_Rich(
                            head: 'โรงพยาบาล',
                            tail:
                                ' : ${_getHospitalName(appController.checkUpModel[index].hospitalCode)}')
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        WidgetText(
                            data: AppService().changeDateTimeToString(
                                dateTimeString: appController
                                    .checkUpModel[index].visittime)),
                        WidgetText_Rich(
                            head: 'นัดฟังผล',
                            tail:
                                ' ${AppService().changeDateTimeToString(dateTimeString: appController.checkUpModel[index].appointmentdate)}')
                      ],
                    ),
                    WidgetText_Rich(
                        head: 'คลินิก',
                        tail: appController.checkUpModel[index].objective),
                    WidgetText(
                      data: 'การรักษา',
                      textStyle: AppConstant().h2style(size: 16),
                    ),
                    WidgetText_Rich(
                        head: 'สิทธิ์การรักษา',
                        tail: appController.checkUpModel[index].remark),
                    WidgetText_Rich(
                        head: 'แพทย์ผู้ตรวจ',
                        tail: appController.checkUpModel[index].doctorname),
                    //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                    ExpansionTile(
                      backgroundColor: Colors.black12,
                      collapsedBackgroundColor:
                          const Color.fromARGB(255, 129, 159, 173),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      collapsedShape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      title: const Center(
                        child: WidgetText(
                          data: 'ตรวจทั่วไป',
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      children: [
                        WidgetText_Rich(
                            head: 'น้ำหนัก',
                            tail: appController.checkUpModel[index].weight
                                .toString()),
                        const SizedBox(
                          height: 10,
                        ),
                        WidgetText_Rich(
                            head: 'ส่วนสูง',
                            tail: appController.checkUpModel[index].height
                                    .toString() ??
                                'N/A'),
                        const SizedBox(
                          height: 10,
                        ),
                        WidgetText_Rich(
                            head: 'รอบเอว',
                            tail: appController.checkUpModel[index].waistline
                                    .toString() ??
                                'N/A'),
                        const SizedBox(
                          height: 10,
                        ),
                        WidgetText_Rich(
                            head: 'BMI',
                            tail: appController.checkUpModel[index].bmi
                                .toString()),
                        Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                          ),
                          child: SfLinearGauge(
                            minimum: 0,
                            maximum: 50,
                            ranges: const <LinearGaugeRange>[
                              LinearGaugeRange(
                                startValue: 0,
                                endValue: 18.5,
                                color: Colors.red, // กำหนดสีสำหรับ range นี้
                              ),
                              LinearGaugeRange(
                                startValue: 18.5,
                                endValue: 25,
                                color: Colors.green, // กำหนดสีสำหรับ range นี้
                              ),
                              LinearGaugeRange(
                                startValue: 25,
                                endValue: 50,
                                color: Colors.red, // กำหนดสีสำหรับ range นี้
                              )
                            ],
                            markerPointers: [
                              LinearShapePointer(
                                  value: appController.checkUpModel[index].bmi,
                                  color: Colors.black)
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        WidgetText_Rich(
                            head: 'ความดันตัวบน',
                            tail: appController.checkUpModel[index].systolic
                                .toString()),
                        SfLinearGauge(
                          minimum: 80,
                          maximum: 200,
                          ranges: const <LinearGaugeRange>[
                            LinearGaugeRange(
                              startValue: 0,
                              endValue: 120,
                              color: Colors.green, // กำหนดสีสำหรับ range นี้
                            ),
                            LinearGaugeRange(
                              startValue: 120,
                              endValue: 130,
                              color: Colors.orange, // กำหนดสีสำหรับ range นี้
                            ),
                            LinearGaugeRange(
                              startValue: 130,
                              endValue: 200,
                              color: Colors.red, // กำหนดสีสำหรับ range นี้
                            )
                          ],
                          markerPointers: [
                            LinearShapePointer(
                              value: double.parse(
                                  appController.checkUpModel[index].systolic!),
                              color: Colors.black,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        WidgetText_Rich(
                            head: 'ความดันตัวล่าง',
                            tail: appController.checkUpModel[index].diastolic
                                .toString()),
                        Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                          ),
                          child: SfLinearGauge(
                            minimum: 40,
                            maximum: 120,
                            ranges: const <LinearGaugeRange>[
                              LinearGaugeRange(
                                startValue: 0,
                                endValue: 120,
                                color: Colors.green, // กำหนดสีสำหรับ range นี้
                              ),
                              LinearGaugeRange(
                                startValue: 90,
                                endValue: 110,
                                color: Colors.orange, // กำหนดสีสำหรับ range นี้
                              ),
                              LinearGaugeRange(
                                startValue: 110,
                                endValue: 120,
                                color: Colors.red, // กำหนดสีสำหรับ range นี้
                              )
                            ],
                            markerPointers: [
                              LinearShapePointer(
                                value: double.parse(appController
                                    .checkUpModel[index].diastolic!),
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 2,
                    ),

                    if (matchingLabModels.isNotEmpty)

                      // Existing ExpansionTile code for general check-up

                      // New ExpansionTile for Blood Complete Count
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
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        title: const Center(
                          child: WidgetText(
                            data: 'ตรวจความสมบูรณ์ของเม็ดเลือด',
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
                              columnSpacing: 10.0, // ปรับระยะห่างระหว่างคอลัมน์
                              dataRowHeight: 50.0, // ปรับความสูงของแต่ละแถว
                              sortAscending: true,
                              sortColumnIndex: 1,
                              showBottomBorder: false,
                              columns: const [
                                DataColumn(
                                  label: Text('ลำดับ',
                                      style: AppConstant.contentStyleHeader),
                                  numeric: true,
                                ),
                                DataColumn(
                                  label: Text('รายการ',
                                      style: AppConstant.contentStyleHeader),
                                ),
                                DataColumn(
                                  label: Text('ผลตรวจ',
                                      style: AppConstant.contentStyleHeader),
                                  numeric: true,
                                ),
                                DataColumn(
                                  label: Text('ค่าปกติ',
                                      style: AppConstant.contentStyleHeader),
                                  numeric: true,
                                ),
                              ],
                              rows: matchingLabModels
                                  .where((labModel) =>
                                      labModel.sub_group_list ==
                                      'CBC, Platelet Count')
                                  .toList()
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
                                      SizedBox(width: 120,
                                        child: Text('${entry.value.lab_items_name}',
                                            style: AppConstant.contentStyle,
                                            textAlign: TextAlign.start,overflow: TextOverflow.ellipsis,),
                                      ),
                                    ),
                                    DataCell(
                                      Text('${entry.value.lab_order_result}',
                                          style: AppConstant.contentStyle
                                              .copyWith(color: Colors.blue),
                                          textAlign: TextAlign.start),
                                    ),
                                    DataCell(
                                      Text(
                                          '${entry.value.lab_items_normal_value}',
                                          style: AppConstant.contentStyle,
                                          textAlign: TextAlign.start),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(
                      height: 2,
                    ),
                    // New ExpansionTile for Urine Test
                    ExpansionTile(
                      backgroundColor: Colors.black12,
                      collapsedBackgroundColor:
                          const Color.fromARGB(255, 129, 159, 173),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      collapsedShape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      title: const Center(
                        child: WidgetText(
                          data: 'ตรวจปัสสาวะ',
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
                            columnSpacing: 10.0, // ปรับระยะห่างระหว่างคอลัมน์
                            dataRowHeight: 50.0, // ปรับความสูงของแต่ละแถว
                            sortAscending: true,
                            sortColumnIndex: 1,
                            showBottomBorder: false,
                            columns: const [
                              DataColumn(
                                label: Text('ลำดับ',
                                    style: AppConstant.contentStyleHeader),
                                numeric: true,
                              ),
                              DataColumn(
                                label: Text('รายการ',
                                    style: AppConstant.contentStyleHeader),
                              ),
                              DataColumn(
                                label: Text('ผลตรวจ',
                                    style: AppConstant.contentStyleHeader),
                                numeric: true,
                              ),
                              DataColumn(
                                label: Text('ค่าปกติ',
                                    style: AppConstant.contentStyleHeader),
                                numeric: true,
                              ),
                            ],
                            rows: matchingLabModels
                                .where((labModel) =>
                                    labModel.sub_group_list == 'Urinalysis')
                                .toList()
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
                                    SizedBox(
                                      width: 40,
                                      child: Text(
                                        '${entry.key + 1}',
                                        style: AppConstant.contentStyle,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    SizedBox(
                                      width:
                                          100, // ปรับความยาวที่คุณต้องการให้ Text แสดง
                                      child: Text(
                                        '${entry.value.lab_items_name}',
                                        style: AppConstant.contentStyle,
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow
                                            .fade, // ใช้ Overflow property เพื่อจำกัดความยาวของข้อความ
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    SizedBox(
                                      width: 70,
                                      child: Text(
                                        '${entry.value.lab_order_result}',
                                        style: AppConstant.contentStyle
                                            .copyWith(color: Colors.blue),
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        '${entry.value.lab_items_normal_value}',
                                        style: AppConstant.contentStyle,
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    // New ExpansionTile for Blood Chemistry Test
                    ExpansionTile(
                      backgroundColor: Colors.black12,
                      collapsedBackgroundColor:
                          const Color.fromARGB(255, 129, 159, 173),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      collapsedShape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      title: const Center(
                        child: WidgetText(
                          data: 'ตรวจสารเคมีในเลือด',
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SingleChildScrollView(
                            child: DataTable(
                              columnSpacing: 10.0, // ปรับระยะห่างระหว่างคอลัมน์
                              sortAscending: true,
                              sortColumnIndex: 1,
                              showBottomBorder: false,
                              columns: const [
                                DataColumn(
                                  label: Text('ลำดับ',
                                      style: AppConstant.contentStyleHeader),
                                  numeric: true,
                                ),
                                DataColumn(
                                  label: Text(
                                    'รายการ',
                                    style: AppConstant.contentStyleHeader,
                                  ),
                                ),
                                DataColumn(
                                  label: Text('ผลตรวจ',
                                      style: AppConstant.contentStyleHeader),
                                  numeric: true,
                                ),
                                DataColumn(
                                  label: Text('ค่าปกติ',
                                      style: AppConstant.contentStyleHeader),
                                  numeric: true,
                                ),
                              ],
                              rows: matchingLabModels
                                  .where((labModel) {
                                    final requiredItems = [
                                      'BUN',
                                      'Creatinine',
                                      'Glucose',
                                      'Uric acid',
                                      'Alk.phosphatase',
                                      'SGOT',
                                      'SGPT',
                                      'Total cholesterol',
                                      'Triglyceride',
                                      'HDL cholesterol (ฟรี)',
                                      'LDL (Calculate)',
                                    ];
                                    for (var item in requiredItems) {
                                      if (labModel.sub_group_list == item) {
                                        return true;
                                      }
                                    }
                                    return false;
                                  })
                                  .toList()
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
                                          SizedBox(
                                            width: 30,
                                            child: Text(
                                              '${entry.key + 1}',
                                              style: AppConstant.contentStyle,
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          SizedBox(
                                            width: 120,
                                            child: Text(
                                              '${entry.value.lab_items_name}',
                                              style: AppConstant.contentStyle,
                                              textAlign: TextAlign.start,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            '${entry.value.lab_order_result}',
                                            style: AppConstant.contentStyle
                                                .copyWith(color: Colors.blue),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            '${entry.value.lab_items_normal_value}',
                                            style: AppConstant.contentStyle,
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ],
                                    );
                                  })
                                  .toList(),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Rest of the existing code

// ...
                  ],
                ),
              );
            },
          );
        }
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
        return 'ไม่พบข้อมูล';
    }
  }
}
