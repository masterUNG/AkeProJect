// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocheckproj/utility/app_controllor.dart';
import 'package:gocheckproj/widgets/widget_image_asset.dart';
import 'package:gocheckproj/widgets/widget_text.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class SetupPinCode extends StatefulWidget {
  const SetupPinCode({
    Key? key,
    required this.map,
  }) : super(key: key);

  final Map<String, String> map;

  @override
  State<SetupPinCode> createState() => _SetupPinCodeState();
}

class _SetupPinCodeState extends State<SetupPinCode> {
  AppController appController = Get.put(AppController());

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
                  onCompleted: (value) {
                    appController.timePincode.value++;
                  },
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
