import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:gocheckproj/models/checkup_model.dart';
import 'package:gocheckproj/models/drug_model.dart';
import 'package:gocheckproj/models/lab_model.dart';
import 'package:gocheckproj/models/medicaltreat_model.dart';
import 'package:gocheckproj/models/user_model.dart';
import 'package:gocheckproj/states/pincode.dart';
import 'package:gocheckproj/states/setup_pincode.dart';
import 'package:gocheckproj/utility/app_constant.dart';
import 'package:gocheckproj/utility/app_controllor.dart';
import 'package:gocheckproj/utility/app_dialog.dart';
import 'package:gocheckproj/utility/app_snackbar.dart';
import 'package:gocheckproj/widgets/widget_button.dart';
import 'package:gocheckproj/widgets/widget_image_asset.dart';
import 'package:gocheckproj/widgets/widget_text.dart';
import 'package:intl/intl.dart';

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
        // print('ได้จาก API >>>>>>> $value');

        UserModel userModel = UserModel.fromMap(value.data);

        Map<String, dynamic> mapUser = userModel.toMap();

        mapUser['password'] = password;

        print('### 19dec usermodel  ....>>> $mapUser');

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

                Get.offAll(SetupPinCode(
                  mapUser: mapUser,
                ));
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

  Future<void> processSaveUser({required Map<String, dynamic> mapUser}) async {
    await GetStorage()
        .write('user', mapUser)
        .then((value) => print('บันทึกสำเร็จ'));
  }

  Future<void> processFindMapUser() async {
    appController.mapUser.value = await GetStorage().read('user');
  }

  // ดึงข้อมูล ตรวจสุขภาพ

  Future<void> readCheckUpResult() async {
    String urlApi = 'https://go.nmd.go.th/gohiApiNEXT/checkup_result';

    Map<String, dynamic> map = {};
    var valueIdentificationNumber = <String>[];
    valueIdentificationNumber.add(appController.mapUser['username']);

    map['identificationNumber'] = valueIdentificationNumber;

    print('##20dec >>>>>>>$map');

    Dio dio = Dio();

    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers['Authorization'] =
        'Bearer ${appController.mapUser["token"]}';

    try {
      await dio.post(urlApi, data: map).then((value) {
        print('Response Data: ${value.data}');

        if (appController.checkUpModel.isNotEmpty) {
          appController.checkUpModel.clear();
        }
        var data = value.data['data'];

        data.forEach((element) {
          CheckUpModel checkUpModel = CheckUpModel.fromMap(element);
          appController.checkUpModel.add(checkUpModel);
        });
        appController.checkUpModel.sort((a, b) => b.visittime.compareTo(a.visittime));
      });
    } on Exception catch (e) {
      print(e);

      AppDialog().normalDialog(
          title: 'เวลา Login หมดอายุ ',
          contentWidget:
              const Center(child: WidgetText(data: 'กรุณาใส่ PIN CODE ใหม่')),
          iconWidget: const WidgetImageAsset(
            path: 'images/doctor1.png',
          ),
          actionWidget: WidgetButton(
            text: 'PIN CODE',
            pressFunc: () {
              Get.back();
              Get.offAll(const PinCode(
                activePage: '/checkup',
              ));
            },
          ));
    }
  }

  // ดึงข้อมูล การมารักษา

  Future<void> readMedicalTreatResult() async {
    String urlApi = 'https://go.nmd.go.th/gohiApiNEXT/ovst';

    Map<String, dynamic> map = {};
    var valueIdentificationNumber = <String>[];
    valueIdentificationNumber.add(appController.mapUser['username']);
    //print('##20dec >>>>>>>$valueIdentificationNumberovst');

    map['identificationNumber'] = valueIdentificationNumber;

    //print('##20dec >>>>>>>$map');

    Dio dio = Dio();

    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers['Authorization'] =
        'Bearer ${appController.mapUser["token"]}';
    //print('##25dec >>>>>>>>>>>>>>>>>>>>>>${appController.mapUser}');

    try {
      await dio.post(urlApi, data: map).then((value) {
        //print('Response Data: ${value.data}');
        if (appController.medicalTreatModel.isNotEmpty) {
          appController.medicalTreatModel.clear();
        }

        var data = value.data['data'];
        //print('##25dec >>>>>>>>>>>>>>>>>>>>>>$data');
        //print('Data from API: $data');

        data.forEach((element) {
          MedicalTreatModel medicalTreatModel =
              MedicalTreatModel.fromMap(element);
          appController.medicalTreatModel.add(medicalTreatModel);
        });
        appController.medicalTreatModel.sort((a, b) => b.vstdate.compareTo(a.vstdate));
      });
    } on Exception catch (e) {
      print(e);
      

      AppDialog().normalDialog(
          title: 'เวลา Login หมดอายุ ',
          contentWidget:
              const Center(child: WidgetText(data: 'กรุณาใส่ PIN CODE ใหม่')),
          iconWidget: const WidgetImageAsset(
            path: 'images/doctor1.png',
          ),
          actionWidget: WidgetButton(
            text: 'PIN CODE',
            pressFunc: () {
              Get.back();
              Get.offAll(const PinCode(
                activePage: '/visit',
              ));
            },
          ));
    }
  }
//   ดึงข้อมูลยา
Future<void> readDrugResult() async {
    String urlApi = 'https://go.nmd.go.th/gohiApiNEXT/ovst_prescription';

    Map<String, dynamic> map = {};
    var valueIdentificationNumber = <String>[];
    valueIdentificationNumber.add(appController.mapUser['username']);
    //print('##20dec >>>>>>>$valueIdentificationNumberovst');

    map['identificationNumber'] = valueIdentificationNumber;

    //print('##20dec >>>>>>>$map');

    Dio dio = Dio();

    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers['Authorization'] =
        'Bearer ${appController.mapUser["token"]}';
    //print('##25dec >>>>>>>>>>>>>>>>>>>>>>${appController.mapUser}');

    try {
      await dio.post(urlApi, data: map).then((value) {
        //print('Response Data: ${value.data}');
        if (appController.drugModel.isNotEmpty) {
          appController.drugModel.clear();
        }

        var data = value.data['data'];
        //print('##25dec >>>>>>>>>>>>>>>>>>>>>>$data');
        //print('Data from API: $data');

        data.forEach((element) {
          DrugModel drugModel =
              DrugModel.fromMap(element);
          appController.drugModel.add(drugModel);
        });
        appController.drugModel.sort((a, b) => b.vstdate.compareTo(a.vstdate));
      });
    } on Exception catch (e) {
      print(e);
      

      AppDialog().normalDialog(
          title: 'เวลา Login หมดอายุ ',
          contentWidget:
              const Center(child: WidgetText(data: 'กรุณาใส่ PIN CODE ใหม่')),
          iconWidget: const WidgetImageAsset(
            path: 'images/doctor1.png',
          ),
          actionWidget: WidgetButton(
            text: 'PIN CODE',
            pressFunc: () {
              Get.back();
              Get.offAll(const PinCode(
                activePage: '/visit',
              ));
            },
          ));
    }
  }


  //   ดึงข้อมูล Lab
Future<void> readLabResult() async {
    String urlApi = 'https://go.nmd.go.th/gohiApiNEXT/patient_lab_result';

    Map<String, dynamic> map = {};
    var valueIdentificationNumber = <String>[];
    valueIdentificationNumber.add(appController.mapUser['username']);
    //print('##20dec >>>>>>>$valueIdentificationNumberovst');

    map['identificationNumber'] = valueIdentificationNumber;

    //print('##20dec >>>>>>>$map');

    Dio dio = Dio();

    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers['Authorization'] =
        'Bearer ${appController.mapUser["token"]}';
    //print('##25dec >>>>>>>>>>>>>>>>>>>>>>${appController.mapUser}');

    try {
      await dio.post(urlApi, data: map).then((value) {
        print('Response Data: ${value.data}');
        if (appController.labModel.isNotEmpty) {
          appController.labModel.clear();
        }

        var data = value.data['data'];
        //print('##25dec >>>>>>>>>>>>>>>>>>>>>>$data');
        //print('Data from API: $data');

        data.forEach((element) {
          LabModel labModel =
              LabModel.fromMap(element);
          appController.labModel.add(labModel);
        });
        appController.labModel.sort((a, b) => b.report_date!.compareTo(a.report_date!));
      });
    } on Exception catch (e) {
      print(e);
      

      AppDialog().normalDialog(
          title: 'เวลา Login หมดอายุ ',
          contentWidget:
              const Center(child: WidgetText(data: 'กรุณาใส่ PIN CODE ใหม่')),
          iconWidget: const WidgetImageAsset(
            path: 'images/doctor1.png',
          ),
          actionWidget: WidgetButton(
            text: 'PIN CODE',
            pressFunc: () {
              Get.back();
              Get.offAll(const PinCode(
                activePage: '/visit',
              ));
            },
          ));
    }
  }





  //    UpdateToken

  Future<void> processUpdateToken() async {
    if (appController.mapUser.isEmpty) {
      processFindMapUser();
    }

    Map<String, String> map = {};
    map['username'] = appController.mapUser['username'];
    map['password'] = appController.mapUser['password'];

    await Dio().post(AppConstant.urlLoginApi, data: map).then((value) async {
      UserModel userModel = UserModel.fromMap(value.data);

      Map<String, dynamic> currentMapUser = appController.mapUser;
      currentMapUser['token'] = userModel.token;
      await GetStorage().write('user', currentMapUser).then((value) {
        print('## update token ');
      });
    });
  }

  String changeDateTimeToString({required String dateTimeString}) {
    String string = dateTimeString;
    var strings = string.split('T');

    String dateString = strings[0];

    var dateSrings = dateString.split('-');
    DateTime dateTime = DateTime(int.parse(dateSrings[0]),
        int.parse(dateSrings[1]), int.parse(dateSrings[2]));

    DateFormat dateFormat = DateFormat('dd MMMM yyyy');

    String result = dateFormat.format(dateTime);

    return result;
  }

  Color calculateColorBmi({required double bmi}) {
    Color color;

    if (bmi < 18.5) {
      color = Colors.red;
    } else if (bmi > 22.9) {
      color = Colors.red;
    } else {
      color = Colors.green;
    }
    return color;
  }
}
