import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../tools/tools_widget.dart';

class TxtField extends StatelessWidget {
  const TxtField(
      {super.key,
      required this.cn,
      required this.label,
      this.inputType = TextInputType.text});

  final TextEditingController cn;
  final String label;
  final TextInputType inputType;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
      child: TextField(
        textDirection: directionField(context),
        controller: cn,
        keyboardType: inputType,
        decoration: InputDecoration(
          labelText: label,
        ),
      ),
    );
  }
}
