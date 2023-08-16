import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../theme/colors/landk_colors.dart';

// ignore: must_be_immutable
class PickImageWidget extends StatelessWidget {
  PickImageWidget({
    super.key,
    required this.width,
    required this.height,
    required this.source,
    required this.onTap,
    required this.label,
  });

  double width;
  double height;
  final File source;
  final VoidCallback onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label),
        Container(
          width: width.w,
          height: height.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: grey1),
          child: Center(
            child: InkWell(
                onTap: onTap,
                child: source.path.isEmpty
                    ? const Icon(Icons.camera)
                    : Image.file(
                        source,
                        fit: BoxFit.cover,
                      )),
          ),
        )
      ],
    );
  }
}
