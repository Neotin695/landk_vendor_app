import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vendor_app/vendor_app/products/widget/product_iten.dart';

import '../../../core/constances/media_const.dart';
import '../../../core/shared/empty_data.dart';
import '../../../core/tools/tools_widget.dart';
import '../bloc/products_bloc.dart';
import '../repository/product_repository.dart';

class DisabledProduct extends StatefulWidget {
  const DisabledProduct({super.key, required this.procucts});

  final List<Product> procucts;

  @override
  State<DisabledProduct> createState() => _DisabledProductState();
}

class _DisabledProductState extends State<DisabledProduct> {
  List<Product> _disableProducts = [];

  @override
  void initState() {
    _disableProducts =
        widget.procucts.where((element) => element.active == true).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, Productstate>(
      builder: (context, state) {
        if (state == Productstate.successData) {
          return ListView.builder(
            itemCount: _disableProducts.length,
            itemBuilder: (context, index) {
              final product = _disableProducts[index];

              return ProductItem(product: product);
            },
          );
        }
        return EmptyData(
            assetIcon: iEmpty, title: trans(context).noDisabledProduct);
      },
    );
  }
}
