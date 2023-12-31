import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:vendor_app/core/language/lang.dart';

import '../../vendor_app/app/views/app.dart';
import '../services/common.dart';
import '../theme/colors/landk_colors.dart';

Widget vSpace(double height) => SizedBox(height: height.h);
Widget hSpace(double width) => SizedBox(width: width.h);

Widget loadingWidget() {
  return const SizedBox(child: Center(child: CircularProgressIndicator()));
}

TextDirection directionField(BuildContext context) =>
    locale(context) ? TextDirection.rtl : TextDirection.ltr;

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
    ? AppLocalizations.of(context)!.localeName == 'ar'
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

showPickImageBottomSheet(BuildContext context, cameraMethod, galleryMethod) {
  return showBottomSheet(
      context: context,
      builder: (context) {
        return Card(
          elevation: 5,
          color: grey2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: cameraMethod, icon: const Icon(Icons.camera)),
                IconButton(
                    onPressed: galleryMethod,
                    icon: const Icon(Icons.photo_album)),
              ],
            ),
          ),
        );
      });
}
