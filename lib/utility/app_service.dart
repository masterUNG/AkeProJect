import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:gocheckproj/states/setup_pincode.dart';
import 'package:gocheckproj/utility/app_constant.dart';
import 'package:gocheckproj/utility/app_controllor.dart';
import 'package:gocheckproj/utility/app_dialog.dart';
import 'package:gocheckproj/utility/app_snackbar.dart';
import 'package:gocheckproj/widgets/widget_button.dart';
import 'package:gocheckproj/widgets/widget_image_asset.dart';
import 'package:gocheckproj/widgets/widget_text.dart';

class AppService {
  AppController appController = Get.put(AppController());

  Future<void> checkLogin({
    required String username,
    required String password,
    required BuildContext context,
  }) async {
    Map<String, String> map = {};
    map['username'] = username;
    map['password'] = password;
    print('map ที่ได้  >>>>> $map');

    try {
      await Dio().post(AppConstant.urlLoginApi, data: map).then((value) {
        print('ได้จาก API >>>>>>> $value');

        AppDialog().normalDialog(
            title: 'กำหนด PIN CODE',
            iconWidget: const WidgetImageAsset(
              path: 'images/pincode.png',
            ),
            contentWidget: WidgetText(data: AppConstant.contentText),
            actionWidget: WidgetButton(
              text: 'ตั้งค่า PIN CODE',
              pressFunc: () {
                Get.back();

                //real
                //Get.offAll(SetupPinCode(map: map));
                Get.to(SetupPinCode(map: map));
              },
            ));
      });
    } on Exception catch (e) {
      print('นี่คือ error จาก API >>>>> $e');
      AppSnackBar(
              title: 'เข้าระบบผิดพลาด',
              message: 'กรุณาตรวจสอบ username หรือ password')
          .errorSnackBar();
    }
  }
}
