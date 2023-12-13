import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:gocheckproj/utility/app_constant.dart';
import 'package:gocheckproj/utility/app_controllor.dart';
import 'package:gocheckproj/widgets/widget_button.dart';
import 'package:gocheckproj/widgets/widget_form.dart';
import 'package:gocheckproj/widgets/widget_icon_button.dart';
import 'package:gocheckproj/widgets/widget_image_asset.dart';
import 'package:gocheckproj/widgets/widget_text.dart';

class Authen extends StatefulWidget {
  const Authen({super.key});

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  AppController appController = Get.put(AppController());

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          decoration: AppConstant().radioBox(),
          child: Stack(
            children: [
              ListView(
                padding: const EdgeInsets.only(top: 64),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 250,
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              displayLogo(),
                              formUser(),
                              formPassword(),
                              buttonLogin()
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                child: buttonCreataccount(),
              ),
            ],
          ),
        ),
      )),
    );
  }

  WidgetButton buttonCreataccount() {
    return WidgetButton(
      text: 'Create New Account',
      pressFunc: () {},
      gfButtonType: GFButtonType.transparent,
      fullWidthButton: true,
    );
  }

  WidgetButton buttonLogin() {
    return WidgetButton(
      text: 'Login',
      pressFunc: () {
        if (formKey.currentState!.validate()) {}
      },
      fullWidthButton: true,
    );
  }

  Widget formPassword() {
    return Obx(() {
      return WidgetForm(
        hintText: 'password:',
        suffixWidget: WidgetIconButton(
          iconData: appController.redEye.value
              ? Icons.visibility_off
              : Icons.visibility,
          preesFunc: () {
            appController.redEye.value = !appController.redEye.value;
          },
        ),
        obscure: appController.redEye.value,
        validateFunc: (p0) {
          if (p0?.isEmpty ?? true) {
            return 'please fill password';
          } else {
            return null;
          }
        },
      );
    });
  }

  WidgetForm formUser() {
    return WidgetForm(
      hintText: 'user:',
      suffixWidget: const Icon(Icons.account_circle_sharp),
      validateFunc: (p0) {
        if (p0?.isEmpty ?? true) {
          return 'please fill User';
        } else {
          return null;
        }
      },
    );
  }

  Widget displayLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Column(
            children: [
              const WidgetImageAsset(
                width: 100,
              ),
              WidgetText(
                data: AppConstant.appName,
                textStyle: AppConstant().h2style(),
              )
            ],
          ),
        ),
      ],
    );
  }
}
