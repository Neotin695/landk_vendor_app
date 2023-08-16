import 'package:flutter/material.dart';

import '../theme/colors/landk_colors.dart';
import '../theme/fonts/landk_fonts.dart';

class OutlinedText extends StatelessWidget {
  const OutlinedText({super.key, required this.text, required this.title});

  final String text;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(
            title,
            style: h6.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: grey1, width: 2),
          ),
          child: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
