import 'package:flutter/material.dart';
import 'package:vendor_app/core/theme/colors/landk_colors.dart';

class PickPersonalPhoto extends StatelessWidget {
  const PickPersonalPhoto(
      {super.key,
      required this.onTap,
      required this.src,
      required this.radius});

  final VoidCallback onTap;
  final ImageProvider<Object> src;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: radius,
          foregroundImage: src,
        ),
        Positioned(
          top: 60,
          left: 60,
          child: FloatingActionButton.small(
            onPressed: onTap,
            backgroundColor: orange,
            child: const Icon(Icons.add_a_photo),
          ),
        )
      ],
    );
  }
}
