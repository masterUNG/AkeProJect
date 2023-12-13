import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:gocheckproj/utility/app_constant.dart';
import 'package:gocheckproj/widgets/widget_button.dart';
import 'package:gocheckproj/widgets/widget_form.dart';
import 'package:gocheckproj/widgets/widget_image_asset.dart';
import 'package:gocheckproj/widgets/widget_text.dart';

class Authen extends StatelessWidget {
  const Authen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: GestureDetector(onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
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
                    ],
                  ),
                ],
              ),
              Positioned(bottom: 0,
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
      pressFunc: () {},
      fullWidthButton: true,
    );
  }

  WidgetForm formPassword() {
    return const WidgetForm(
      hintText: 'password:',
      suffixWidget: Icon(Icons.lock),obscure: true,
    );
  }

  WidgetForm formUser() {
    return const WidgetForm(
      hintText: 'user:',
      suffixWidget: Icon(Icons.account_circle_sharp),
    );
  }

  Container displayLogo() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          const WidgetImageAsset(
            width: 60,
          ),
          WidgetText(
            data: AppConstant.appName,
            textStyle: AppConstant().h2style(),
          )
        ],
      ),
    );
  }
}
