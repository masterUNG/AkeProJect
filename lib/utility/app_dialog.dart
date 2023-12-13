import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocheckproj/widgets/widget_button.dart';
import 'package:gocheckproj/widgets/widget_text.dart';

class AppDialog {
  void normalDialog({
    required String title,
    Widget? iconWidget,
    Widget? contentWidget,
    Widget? actionWidget,
  }) {
    Get.dialog(
      AlertDialog(scrollable: true,
        icon: iconWidget,
        title: WidgetText(data: title),
        content: contentWidget,
        actions: [actionWidget ?? WidgetButton(text: 'OK', pressFunc: () => Get.back(),)],
      ),
      barrierDismissible: false,
    );
  }
}
