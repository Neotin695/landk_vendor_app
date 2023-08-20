import 'package:flutter/material.dart';
import 'package:vendor_app/vendor_app/order/repository/order_repository.dart';

import 'preview_view.dart';

class PreviewPage extends StatelessWidget {
  const PreviewPage({super.key, required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return PreviewView(order:order);
  }
}
