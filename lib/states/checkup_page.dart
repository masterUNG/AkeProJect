import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    AppService()
        .processFindMapUser()
        .then((value) => AppService().readCheckUpResult());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: WidgetIconButton(
          iconData: Icons.arrow_back,
          preesFunc: () => Get.offAllNamed('/mainHome'),
        ),
        title: const WidgetText(data: 'ตรวจสุขภาพ'),
      ),
      body: Obx(() {
        return appController.checkUpModel.isEmpty
            ? const SizedBox()
            : ListView.builder(
                reverse: true,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: appController.checkUpModel.length,
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
                          WidgetText_Rich(
                              head: 'โรงพยาบาล',
                              tail: appController
                                  .checkUpModel[index].hospitalCode)
                        ],
                      ),
                      WidgetText(
                          data: AppService().changeDateTimeToString(
                              dateTimeString:
                                  appController.checkUpModel[index].visittime)),
                      WidgetText_Rich(
                          head: 'คลินิก',
                          tail: appController.checkUpModel[index].objective),
                      WidgetText(
                        data: 'นัดฟังผลตรวจ',
                        textStyle: AppConstant().h2style(size: 16),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          WidgetText(
                              data: AppService().changeDateTimeToString(
                                  dateTimeString: appController
                                      .checkUpModel[index].appointmentdate)),

                          // WidgetText_Rich(
                          //     head: 'BMI',
                          //     colorHead: AppService().calculateColorBmi(
                          //         bmi: appController.checkUpModel[index].bmi),
                          //     tail: appController.checkUpModel[index].bmi
                          //         .toString())
                        ],
                      ),
                      ExpansionTile(
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        title: const WidgetText(data: 'รายละเอียด'),
                        children: [
                          WidgetText_Rich(
                              head: 'แพทย์ผู้ตรวจ',
                              tail:
                                  appController.checkUpModel[index].doctorname),
                          WidgetText_Rich(
                              head: 'หมายเหตุ',
                              tail: appController.checkUpModel[index].remark),
                          ExpansionTile(
                            expandedCrossAxisAlignment:
                                CrossAxisAlignment.start,
                            title:
                                const WidgetText(data: 'ผลตรวจร่างกายทั่วไป'),
                            children: [
                              WidgetText_Rich(
                                  head: 'BMI',
                                  tail: appController.checkUpModel[index].bmi
                                      .toString()),
                              SfLinearGauge(
                                minimum: 0,
                                maximum: 50,
                                ranges: const <LinearGaugeRange>[
                                  LinearGaugeRange(
                                    startValue: 0,
                                    endValue: 18.5,
                                    color:
                                        Colors.red, // กำหนดสีสำหรับ range นี้
                                  ),
                                  LinearGaugeRange(
                                    startValue: 18.5,
                                    endValue: 25,
                                    color:
                                        Colors.green, // กำหนดสีสำหรับ range นี้
                                  ),
                                  LinearGaugeRange(
                                    startValue: 25,
                                    endValue: 50,
                                    color:
                                        Colors.red, // กำหนดสีสำหรับ range นี้
                                  )
                                ],
                                markerPointers: [
                                  LinearShapePointer(
                                      value:
                                          appController.checkUpModel[index].bmi,
                                      color: Colors.black)
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              WidgetText_Rich(
                                  head: 'ความดันตัวบน',
                                  tail: appController
                                      .checkUpModel[index].systolic
                                      .toString()),
                              SfLinearGauge(
                                minimum: 80,
                                maximum: 200,
                                ranges: const <LinearGaugeRange>[
                                  LinearGaugeRange(
                                    startValue: 0,
                                    endValue: 120,
                                    color:
                                        Colors.green, // กำหนดสีสำหรับ range นี้
                                  ),
                                  LinearGaugeRange(
                                    startValue: 120,
                                    endValue: 130,
                                    color: Colors
                                        .orange, // กำหนดสีสำหรับ range นี้
                                  ),
                                  LinearGaugeRange(
                                    startValue: 130,
                                    endValue: 200,
                                    color:
                                        Colors.red, // กำหนดสีสำหรับ range นี้
                                  )
                                ],
                                markerPointers: [
                                  LinearShapePointer(
                                    value: double.parse(appController
                                        .checkUpModel[index].systolic!),
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              WidgetText_Rich(
                                  head: 'ความดันตัวล่าง',
                                  tail: appController
                                      .checkUpModel[index].diastolic
                                      .toString()),
                              SfLinearGauge(
                                minimum: 40,
                                maximum: 120,
                                ranges: const <LinearGaugeRange>[
                                  LinearGaugeRange(
                                    startValue: 0,
                                    endValue: 120,
                                    color:
                                        Colors.green, // กำหนดสีสำหรับ range นี้
                                  ),
                                  LinearGaugeRange(
                                    startValue: 90,
                                    endValue: 110,
                                    color: Colors
                                        .orange, // กำหนดสีสำหรับ range นี้
                                  ),
                                  LinearGaugeRange(
                                    startValue: 110,
                                    endValue: 120,
                                    color:
                                        Colors.red, // กำหนดสีสำหรับ range นี้
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
}



