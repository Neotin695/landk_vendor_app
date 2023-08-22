import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    _tabController = TabController(length: 3, vsync: this);
    bloc = BlocProvider.of<ProductsBloc>(context);

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
      body: TabBarView(
        controller: _tabController,
        children: [
          ActiveProducts(
            procucts: bloc.products,
          ),
          DisabledProduct(
            procucts: bloc.products,
          ),
        ],
      ),
    );
  }
}
