import 'package:flutter/widgets.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:vendor_app/core/constances/media_const.dart';
import 'package:vendor_app/core/theme/fonts/landk_fonts.dart';
import 'package:vendor_app/core/tools/tools_widget.dart';

class OfflineWidget extends StatelessWidget {
  const OfflineWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: ((context, value, child) {
        if (value == ConnectivityResult.none) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                iServerDown,
                width: 20.w,
                height: 20.h,
              ),
              vSpace(3),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Text(
                  trans(context).noInternet,
                  style: h4,
                ),
              ),
              vSpace(20)
            ],
          ));
        } else {
          return child;
        }
      }),
      child: child,
    );
  }
}
