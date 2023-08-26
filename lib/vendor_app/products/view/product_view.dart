import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vendor_app/core/constances/media_const.dart';
import 'package:vendor_app/core/shared/empty_data.dart';
import 'package:vendor_app/core/tools/tools_widget.dart';

import '../bloc/products_bloc.dart';
import '../widget/actiev_products.dart';
import '../widget/disabled_products.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  late final ProductsBloc bloc;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    bloc = context.read<ProductsBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabBar(
        controller: _tabController,
        tabs: [
          Tab(text: trans(context).activeProduct),
          Tab(text: trans(context).disabledProduct),
        ],
      ),
      body: BlocBuilder<ProductsBloc, Productstate>(
        builder: (context, state) {
          if (state == Productstate.successData) {
            return TabBarView(
              controller: _tabController,
              children: [
                ActiveProducts(
                  products: bloc.products,
                ),
                DisabledProduct(
                  products: bloc.products,
                ),
              ],
            );
          }
          return EmptyData(
              assetIcon: iEmpty, title: trans(context).noActiveProdcut);
        },
      ),
    );
  }
}
