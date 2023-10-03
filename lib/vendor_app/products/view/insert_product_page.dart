import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vendor_app/vendor_app/products/repository/src/product_repository.dart';
import 'package:vendor_app/vendor_app/products/view/insert_product_view.dart';

import '../bloc/products_bloc.dart';

class InsertProductPage extends StatelessWidget {
  const InsertProductPage({super.key, required this.repository});
  final ProductRepository repository;
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: repository,
      child: BlocProvider(
        create: (context) => ProductsBloc(repository),
        child: const InsertProductView(),
      ),
    );
  }
}
