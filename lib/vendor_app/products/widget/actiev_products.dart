import 'package:flutter/material.dart';
import 'package:vendor_app/core/constances/media_const.dart';
import 'package:vendor_app/core/shared/empty_data.dart';
import 'package:vendor_app/core/tools/tools_widget.dart';
import 'package:vendor_app/vendor_app/products/widget/product_iten.dart';

import '../repository/product_repository.dart';

class ActiveProducts extends StatefulWidget {
  const ActiveProducts({super.key, required this.products});

  final List<Product> products;

  @override
  State<ActiveProducts> createState() => _ActiveProductsState();
}

class _ActiveProductsState extends State<ActiveProducts> {
  List<Product> _activeProducts = [];

  @override
  void initState() {
    _activeProducts =
        widget.products.where((element) => element.active == true).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _activeProducts.isNotEmpty
        ? ListView.builder(
            itemCount: _activeProducts.length,
            itemBuilder: (context, index) {
              final product = _activeProducts[index];
              return ProductItem(product: product);
            },
          )
        : EmptyData(assetIcon: iEmpty, title: trans(context).noActiveProdcut);
  }
}
