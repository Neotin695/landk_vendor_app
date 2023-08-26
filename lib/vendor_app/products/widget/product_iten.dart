import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vendor_app/vendor_app/products/repository/product_repository.dart';
import 'package:vendor_app/vendor_app/products/view/product_preview_page.dart';

import '../bloc/products_bloc.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({super.key, required this.product});

  final Product product;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  late final ProductsBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<ProductsBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductPreviewPage(
              product: widget.product,
              productRepository: ProductRepository(),
            ),
          ),
        );
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CachedNetworkImage(
              imageUrl: widget.product.coverUrl,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            title: Text(widget.product.title),
            subtitle: Text(widget.product.description),
            trailing: Switch(
                value: widget.product.active,
                onChanged: (value) {
                  bloc.add(
                      ToggleActiveProduct(id: widget.product.id, state: value));
                }),
          ),
        ),
      ),
    );
  }
}
