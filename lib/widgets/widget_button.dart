// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';

import 'package:gocheckproj/utility/app_constant.dart';

class WidgetButton extends StatelessWidget {
  const WidgetButton({
    Key? key,
    required this.text,
    required this.pressFunc,
    this.gfButtonType,
    this.fullWidthButton,
  }) : super(key: key);

  final String text;
  final Function() pressFunc;
  final GFButtonType? gfButtonType;
  final bool? fullWidthButton;

  @override
  Widget build(BuildContext context) {
    return GFButton(
      onPressed: pressFunc,
      text: text,
      color: AppConstant.primaryColor,
      type: gfButtonType ?? GFButtonType.solid,
      fullWidthButton: fullWidthButton,
    );
  }
}
