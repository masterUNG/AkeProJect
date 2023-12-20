import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocheckproj/utility/app_constant.dart';
import 'package:gocheckproj/utility/app_controllor.dart';
import 'package:gocheckproj/utility/app_service.dart';
import 'package:gocheckproj/widgets/widget_icon_button.dart';
import 'package:gocheckproj/widgets/widget_text.dart';
import 'package:gocheckproj/widgets/widget_text_rich.dart';

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
                      color: index % 2 == 1
                          ? Colors.white
                          : AppConstant.mainColor.withOpacity(0.10),
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10)),
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
                          WidgetText_Rich(
                              head: 'BMI',
                              colorHead:
                                  AppService().calculateColorBmi(bmi: appController.checkUpModel[index].bmi),
                              tail: appController.checkUpModel[index].bmi
                                  .toString())
                        ],
                      ),
                      ExpansionTile(
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        title: const WidgetText(data: 'รายละเอียด'),
                        children: [
                          WidgetText_Rich(
                              head: 'จุดประสงค์ที่มา',
                              tail:
                                  appController.checkUpModel[index].objective),
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
                            title: WidgetText(data: 'ผลตรวจ'),
                            children: [
                              WidgetText_Rich(
                                  head: 'BMI',
                                  tail: appController.checkUpModel[index].bmi
                                      .toString()),
                              WidgetText_Rich(
                                  head: 'BMI',
                                  tail: appController.checkUpModel[index].bmi
                                      .toString()),
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
