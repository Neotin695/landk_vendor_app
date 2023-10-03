import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vendor_app/vendor_app/products/repository/src/product_repository.dart';

import '../bloc/products_bloc.dart';
import 'products_view.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key, required this.repository});

  final ProductRepository repository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: repository,
      child: BlocProvider(
        create: (context) => ProductsBloc(repository),
        child: const ProductsView(),
      ),
    );
  }
}
