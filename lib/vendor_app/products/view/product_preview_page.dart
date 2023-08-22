import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vendor_app/vendor_app/products/view/product_preview_view.dart';

import '../bloc/products_bloc.dart';
import '../repository/product_repository.dart';

class ProductPreviewPage extends StatelessWidget {
  const ProductPreviewPage(
      {super.key, required this.product, required this.productRepository});

  final Product product;
  final ProductRepository productRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: productRepository,
      child: BlocProvider(
        create: (context) => ProductsBloc(productRepository),
        child: ProductPreviewView(product: product),
      ),
    );
  }
}
