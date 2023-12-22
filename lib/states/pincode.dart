// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import 'package:gocheckproj/states/main_hone.dart';
import 'package:gocheckproj/utility/app_controllor.dart';
import 'package:gocheckproj/utility/app_dialog.dart';
import 'package:gocheckproj/utility/app_service.dart';
import 'package:gocheckproj/utility/app_snackbar.dart';
import 'package:gocheckproj/widgets/widget_button.dart';
import 'package:gocheckproj/widgets/widget_image_asset.dart';
import 'package:gocheckproj/widgets/widget_text.dart';

class PinCode extends StatefulWidget {
  const PinCode({
    Key? key,
    this.activePage,
  }) : super(key: key);

  final String? activePage;

  @override
  State<PinCode> createState() => _PinCodeState();
}

class _PinCodeState extends State<PinCode> {
  AppController appController = Get.put(AppController());

  OtpFieldController otpFieldControllor = OtpFieldController();

  String? pincodeString;
  String? goActivePage;

  @override
  void initState() {
    super.initState();
    appController.timePincode.value = 1;
    AppService().processFindMapUser().then(
        (value) => print('##19dec >>>>>> ${appController.mapUser.value}'));
    goActivePage = widget.activePage ?? '/mainHome';
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: WidgetText(
              data:
                  'กรอก PIN CODE ครั้งที่ ${appController.timePincode.value}'),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                const WidgetImageAsset(
                  path: 'images/pincode.png',
                  width: 200,
                ),
                OTPTextField(
                  length: 6,
                  width: 250,
                  fieldStyle: FieldStyle.box,
                  onCompleted: (value) async {
                    if (value == appController.mapUser['pincode']) {
                      if (widget.activePage == null) {
                        Get.offAllNamed(goActivePage!);
                      } else {
                        //for update token
                        AppService()
                            .processUpdateToken()
                            .then((value) => Get.offAllNamed(goActivePage!));
                      }
                    } else {
                      if (appController.timePincode.value == 3) {
                        // ลบข้อมูลใน GetStorage
                        await GetStorage().erase().then((value) {
                          // แสดง Dialog แจ้งเตือนให้ Login ใหม่
                          AppDialog().normalDialog(
                            title: 'PIN CODE ผิดพลาด',
                            iconWidget: const WidgetImageAsset(
                              path: 'images/pincode.png',
                              width: 200,
                            ),
                            contentWidget: const Center(
                              child: WidgetText(
                                  data:
                                      'ท่านกรอกผิด 3 ครั้ง!!  โปรด Login ใหม่ '),
                            ),
                            actionWidget: Center(
                              child: WidgetButton(
                                text: 'LOGIN',
                                pressFunc: () {
                                  // กลับไปยังหน้า Login
                                  Get.back();
                                  // โหลดหน้า Login
                                  Get.offAllNamed('/authen');
                                },
                              ),
                            ),
                          );
                        });
                      } else {
                        AppSnackBar(
                                title: 'PIN CODE พิดพลาด',
                                message:
                                    'กรุณาใส่ PIN CODE ใหม่ (เหลืออีก ${3 - appController.timePincode.value}) ครั้ง ')
                            .errorSnackBar();
                        otpFieldControllor.clear();
                        appController.timePincode++;
                      }
                    }
                  },
                  controller: otpFieldControllor,
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
