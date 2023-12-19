// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocheckproj/states/main_hone.dart';
import 'package:gocheckproj/utility/app_service.dart';
import 'package:gocheckproj/utility/app_snackbar.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import 'package:gocheckproj/utility/app_controllor.dart';
import 'package:gocheckproj/widgets/widget_image_asset.dart';
import 'package:gocheckproj/widgets/widget_text.dart';

class PinCode extends StatefulWidget {
  const PinCode({
    Key? key,
  }) : super(key: key);

  @override
  State<PinCode> createState() => _PinCodeState();
}

class _PinCodeState extends State<PinCode> {
  AppController appController = Get.put(AppController());

  OtpFieldController otpFieldControllor = OtpFieldController();

  String? otpString;

  @override
  void initState() {
    super.initState();
    appController.timePincode.value = 1;
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
                  onCompleted: (value) {},
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
