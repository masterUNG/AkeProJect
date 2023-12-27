// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:gocheckproj/utility/app_constant.dart';

class WidgetText_Rich extends StatelessWidget {
  const WidgetText_Rich({
    Key? key,
    required this.head,
    required this.tail,
    
    this.colorHead,
  }) : super(key: key);
  final String head;
  final String tail;
  

  final Color? colorHead;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: head,
        style: AppConstant().h3style(
            color: colorHead ?? AppConstant.primaryColor,
            fontWeight: FontWeight.bold),
        children: [
          const TextSpan(text: ' : '),
          TextSpan(text: tail, style: AppConstant().h3style()),
          
        ],
      ),
    );
  }
}
