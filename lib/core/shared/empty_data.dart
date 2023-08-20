import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:vendor_app/core/tools/tools_widget.dart';

class EmptyData extends StatelessWidget {
  const EmptyData({super.key, required this.assetIcon, required this.title});

  final String assetIcon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(
            assetIcon,
            width: 30.w,
            height: 30.h,
          ),
          vSpace(3),
          Text(
            title,
            style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
