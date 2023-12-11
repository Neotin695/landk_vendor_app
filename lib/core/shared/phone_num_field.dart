import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sizer/sizer.dart';
import 'package:vendor_app/core/tools/tools_widget.dart';

class PhoneNumField extends StatelessWidget {
  const PhoneNumField({super.key, required this.onChange});
  final Function(String) onChange;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      child: InternationalPhoneNumberInput(
        onInputChanged: (PhoneNumber number) => onChange(number.phoneNumber!),
        ignoreBlank: true,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        inputDecoration: InputDecoration(
          labelText: trans(context).phoneNum,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          isDense: true,
          errorBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        ),
        inputBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        initialValue: PhoneNumber(isoCode: 'US'),
        selectorConfig:
            const SelectorConfig(selectorType: PhoneInputSelectorType.DIALOG),
      ),
    );
  }
}
