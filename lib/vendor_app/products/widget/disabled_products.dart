import 'package:flutter/material.dart';
import 'package:vendor_app/core/constances/media_const.dart';
import 'package:vendor_app/core/shared/empty_data.dart';
import 'package:vendor_app/core/tools/tools_widget.dart';
import 'package:vendor_app/vendor_app/products/widget/product_iten.dart';

import '../repository/product_repository.dart';

class DisabledProduct extends StatefulWidget {
  const DisabledProduct({super.key, required this.products});

  final List<Product> products;

  @override
  State<DisabledProduct> createState() => _DisabledProductState();
}

class _DisabledProductState extends State<DisabledProduct> {
  List<Product> _disableProducts = [];

  @override
  void initState() {
    _disableProducts =
        widget.products.where((element) => element.active == false).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _disableProducts.isNotEmpty
        ? ListView.builder(
            itemCount: _disableProducts.length,
            itemBuilder: (context, index) {
              final product = _disableProducts[index];

              return ProductItem(product: product);
            },
          )
        : EmptyData(assetIcon: iEmpty, title: trans(context).noDisabledProduct);
  }
}
