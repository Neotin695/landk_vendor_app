import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:vendor_app/core/language/lang.dart';

import '../../vendor_app/app/views/app.dart';
import '../services/common.dart';
import '../theme/colors/landk_colors.dart';

Widget vSpace(double height) => SizedBox(height: height.h);
Widget hSpace(double width) => SizedBox(width: width.h);

Widget loadingWidget() {
  return SizedBox(
      height: 5.h, child: const Center(child: CircularProgressIndicator()));
}

Alignment autoAlignTop(context) {
  return locale(context) ? Alignment.topRight : Alignment.topLeft;
}

Alignment autoAlignCenter(context) {
  return locale(context) ? Alignment.centerRight : Alignment.centerLeft;
}

Alignment autoAlignBottom(context) {
  return locale(context) ? Alignment.bottomRight : Alignment.bottomRight;
}

bool locale(context) => Common.prefs.getString('locale') == null
    ? AppLocalizations.of(context)!.localeName != 'ar'
    : Common.prefs.getString('locale')! == 'ar';
SizedBox empty() => const SizedBox();

AppBar customAppBar(BuildContext context, title) {
  return AppBar(
    backgroundColor: white,
    title: Text(
      title,
      style: TextStyle(color: black),
    ),
    centerTitle: true,
  );
}

AppLocalizations trans(BuildContext context) => AppLocalizations.of(context)!;

Widget dropDownButtonLang(BuildContext context) {
  return Align(
    child: DropdownButton(
      hint: Text(locale(context) ? 'العربية' : 'English'),
      items: const [
        DropdownMenuItem(
          value: 'ar',
          child: Text('العربية'),
        ),
        DropdownMenuItem(
          value: 'en',
          child: Text('English'),
        ),
      ],
      onChanged: (value) async {
        await Common.prefs
            .setString('locale', value.toString())
            .then((value) => AppView.restartApp(context));
      },
    ),
  );
}
