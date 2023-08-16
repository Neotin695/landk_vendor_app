import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../theme/colors/landk_colors.dart';

class LandkTab extends StatelessWidget {
  const LandkTab(
      {super.key,
      required this.controller,
      required this.tabs,
      this.labelStyle});

  final TabController controller;
  final List<Tab> tabs;
  final TextStyle? labelStyle;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: SizedBox(
        width: 35.w,
        child: TabBar(
          labelStyle: labelStyle,
          indicatorColor: orange,
          labelColor: black,
          controller: controller,
          tabs: tabs,
        ),
      ),
    );
  }
}
