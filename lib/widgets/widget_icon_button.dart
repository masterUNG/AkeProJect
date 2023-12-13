// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:gocheckproj/utility/app_constant.dart';

class WidgetIconButton extends StatelessWidget {
  const WidgetIconButton({
    Key? key,
    required this.iconData,
    required this.preesFunc,
    this.gfButtonType,
  }) : super(key: key);

  final IconData iconData;
  final Function() preesFunc;
  final GFButtonType? gfButtonType;
  @override
  Widget build(BuildContext context) {
    return GFIconButton(
      icon: Icon(iconData),
      onPressed: preesFunc,
      type: gfButtonType ?? GFButtonType.transparent,color: AppConstant.primaryColor,
    );
  }
}
