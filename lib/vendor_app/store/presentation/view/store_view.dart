import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:vendor_app/core/services/common.dart';
import 'package:vendor_app/vendor_app/products/repository/src/product_repository.dart';
import 'package:vendor_app/vendor_app/products/view/insert_product_page.dart';

import '../../../../core/theme/colors/landk_colors.dart';
import '../../../../core/theme/fonts/landk_fonts.dart';
import '../../../../core/tools/tools_widget.dart';
import '../../../products/view/products_page.dart';
import '../../bloc/store_bloc.dart';

class StoreView extends StatefulWidget {
  const StoreView({
    super.key,
  });

  @override
  State<StoreView> createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> {
  late final StoreBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<StoreBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            Common.scaffoldKey.currentContext!,
            MaterialPageRoute(
              builder: (_) => InsertProductPage(
                repository: ProductRepository(),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: BlocConsumer<StoreBloc, StoreState>(
        listener: (context, state) {
          if (state is StoreFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text(state.message)),
              );
          }
        },
        builder: (context, state) {
          if (state is StoreLoaded) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  iconTheme: IconThemeData(color: orange),
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.share,
                        color: orange,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.favorite_outline_sharp,
                        color: orange,
                      ),
                    ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: CachedNetworkImage(
                      fit: BoxFit.cover,
                      height: 25.h,
                      width: double.infinity,
                      imageUrl: state.store.coverUrl,
                      placeholder: (context, url) => loadingWidget(),
                    ),
                  ),
                  pinned: true,
                  expandedHeight: 25.h,
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.w, vertical: 1.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.store.name,
                                  style:
                                      h4.copyWith(fontWeight: bold.fontWeight),
                                ),
                                Text(
                                  '',
                                  style: bold,
                                ),
                              ],
                            ),
                            hSpace(2),
                            Icon(
                              Icons.star,
                              color: yellow,
                            ),
                            const Spacer(),
                            CircleAvatar(
                              radius: 25.sp,
                              foregroundImage:
                                  NetworkImage(state.store.logoUrl),
                            )
                          ],
                        ),
                      ),
                      ListTile(
                        title: Text(
                          trans(context).products,
                          style: h4.copyWith(fontWeight: bold.fontWeight),
                        ),
                      ),
                      ProductsPage(
                        repository: ProductRepository(),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is StoreLoading) {
            return loadingWidget();
          }
          return empty();
        },
      ),
    );
  }
}
