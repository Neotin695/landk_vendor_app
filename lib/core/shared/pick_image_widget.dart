import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class PickImageWidget extends StatefulWidget {
  PickImageWidget({
    super.key,
    required this.width,
    required this.height,
    this.source,
    required this.onTap,
    required this.label,
    this.sources,
  });

  double width;
  double height;
  final String? source;
  final List<String>? sources;
  final VoidCallback onTap;
  final String label;

  @override
  State<PickImageWidget> createState() => _PickImageWidgetState();
}

class _PickImageWidgetState extends State<PickImageWidget> {
  var urlPattern =
      r"(https?|http)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";

  @override
  Widget build(BuildContext context) {
    print(widget.source);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(widget.label),
        Container(
          width: widget.width.w,
          height: widget.height.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.grey),
          child: Center(
            child: InkWell(
              onTap: widget.onTap,
              child: Uri.parse(widget.source ?? '').host.isEmpty
                  ? offlineImages()
                  : onlineImages(),
            ),
          ),
        )
      ],
    );
  }

  Widget onlineImages() {
    print('online');
    return widget.source == null
        ? widget.sources!.isNotEmpty && widget.sources != null
            ? CarouselSlider(
                items: widget.sources!
                    .map((e) => Image.network(
                          e,
                          fit: BoxFit.cover,
                        ))
                    .toList(),
                options: CarouselOptions(aspectRatio: 7 / 4),
              )
            : const Icon(Icons.image)
        : widget.source!.isEmpty
            ? const Icon(Icons.image)
            : Image.network(
                widget.source!,
                fit: BoxFit.cover,
              );
  }

  Widget offlineImages() {
    return widget.source == null
        ? widget.sources!.isNotEmpty && widget.sources != null
            ? CarouselSlider(
                items: widget.sources!
                    .map((e) => Image.file(
                          File(e),
                          fit: BoxFit.cover,
                        ))
                    .toList(),
                options: CarouselOptions(aspectRatio: 7 / 4),
              )
            : const Icon(Icons.image)
        : widget.source!.isEmpty
            ? const Icon(Icons.image)
            : Image.file(
                File(widget.source!),
                fit: BoxFit.cover,
              );
  }
}
