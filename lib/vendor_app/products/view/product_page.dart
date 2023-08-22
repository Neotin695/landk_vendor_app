import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/products_bloc.dart';
import '../repository/product_repository.dart';

class ProductPage extends StatelessWidget {
  static Page page() => MaterialPage(
          child: ProductPage(
        repository: ProductRepository(),
      ));
  const ProductPage({super.key, required this.repository});

  final ProductRepository repository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: repository,
      child: BlocProvider(
        create: (context) => ProductsBloc(repository),
        child: Container(),
      ),
    );
  }
}
