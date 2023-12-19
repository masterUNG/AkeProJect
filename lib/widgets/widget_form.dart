// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class WidgetForm extends StatelessWidget {
  const WidgetForm({
    Key? key,
    this.hintText,
    this.suffixWidget,
    this.obscure,
    this.validateFunc,
    this.textEditingController,
    this.textInputType,
  }) : super(key: key);

  final String? hintText;
  final Widget? suffixWidget;
  final bool? obscure;
  final String? Function(String?)? validateFunc;
  final TextEditingController? textEditingController;
  final TextInputType? textInputType;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        keyboardType: textInputType,
        controller: textEditingController,
        validator: validateFunc,
        obscureText: obscure ?? false,
        decoration: InputDecoration(
          suffixIcon: suffixWidget,
          hintText: hintText,
          filled: true,
          fillColor: Colors.grey.shade100,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
