import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../tools/tools_widget.dart';

class TxtField extends StatelessWidget {
  const TxtField({
    super.key,
    required this.onChange,
    this.label,
    this.icon,
    this.errorTxt,
    this.inputType = TextInputType.text,
    this.keyboardAction = TextInputAction.next,
    this.obsecureTxt = false,
  });

  final Function(String value) onChange;
  final String? label;
  final Widget? icon;
  final String? errorTxt;
  final bool obsecureTxt;
  final TextInputAction keyboardAction;
  final TextInputType inputType;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      child: TextField(
        textDirection: directionField(context),
        textInputAction: keyboardAction,
        onChanged: onChange,
        keyboardType: inputType,
        obscureText: obsecureTxt,
        decoration: InputDecoration(
          prefixIcon: icon,
          labelText: label,
          errorText: errorTxt,
        ),
      ),
    );
  }
}
