import 'package:flutter/material.dart';

class FormTextFieldWidget extends StatelessWidget {
  const FormTextFieldWidget({
    super.key,
    required this.decoration,
    required this.textInputType,
    required this.textEditingController,
    required this.validatorFun,
    this.focusNode,
  });

  final InputDecoration decoration;
  final TextInputType textInputType;
  final TextEditingController textEditingController;
  final String? Function(String) validatorFun;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      keyboardType: textInputType,
      maxLines: null,
      controller: textEditingController,
      validator: (value) => validatorFun(value!),
      decoration: decoration,
    );
  }
}
