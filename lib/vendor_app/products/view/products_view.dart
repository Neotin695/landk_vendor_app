import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vendor_app/core/tools/tools_widget.dart';

import '../bloc/products_bloc.dart';
import '../widget/product_iten.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  late final ProductsBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<ProductsBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, Productstate>(
      builder: (context, state) {
        if (state == Productstate.loadingData) return loadingWidget();
        if (state == Productstate.successData) {
          return ListView.builder(
            itemCount: bloc.products.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final product = bloc.products[index];
              return ProductItem(product: product);
            },
          );
        }
        return empty();
      },
    );
  }
}
