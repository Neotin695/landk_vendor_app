import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:vendor_app/core/services/common.dart';
import 'package:vendor_app/core/shared/txt_field.dart';
import 'package:vendor_app/core/tools/tools_widget.dart';
import 'package:vendor_app/vendor_app/products/bloc/products_bloc.dart';

import '../../../core/shared/pick_image_widget_online.dart';
import '../../../core/theme/colors/landk_colors.dart';
import '../../../core/theme/fonts/landk_fonts.dart';

class InsertProductView extends StatefulWidget {
  const InsertProductView({super.key});

  @override
  State<InsertProductView> createState() => _InsertProductViewState();
}

class _InsertProductViewState extends State<InsertProductView> {
  late final ProductsBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<ProductsBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Common.scaffoldKey.currentContext == null ? null : AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<ProductsBloc, Productstate>(
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.w,
                          vertical: 2.h,
                        ),
                        child: PickImageWidgetOnline(
                          width: 30,
                          height: 15,
                          source: bloc.coverPath,
                          onTap: () {
                            bloc.add(PickCover());
                          },
                          label: trans(context).product,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.w,
                          vertical: 2.h,
                        ),
                        child: PickImageWidgetOnline(
                          width: 30,
                          height: 15,
                          sources: bloc.imagesPaths,
                          onTap: () {
                            bloc.add(PickImages());
                          },
                          label: trans(context).product,
                        ),
                      ),
                    ],
                  );
                },
              ),
              TxtField(
                cn: bloc.titleAr,
                label: 'اسم المنتج بالعربية',
              ),
              TxtField(
                cn: bloc.titleAr,
                label: 'Product title en',
              ),
              TxtField(
                cn: bloc.titleAr,
                label: 'وصف المنتج بالعربية',
              ),
              TxtField(
                cn: bloc.titleAr,
                label: 'Product description en',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: TxtField(
                      cn: bloc.titleAr,
                      label: 'Product quantity',
                      inputType: TextInputType.number,
                    ),
                  ),
                  Expanded(
                    child: TxtField(
                      cn: bloc.titleAr,
                      label: 'Product Price',
                      inputType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              vSpace(3),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: BlocBuilder<ProductsBloc, Productstate>(
                  builder: (context, state) {
                    return ElevatedButton.icon(
                      onPressed: () {
                        bloc.add(InsertProduct());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: orange,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        minimumSize: Size(100.w, 7.h),
                      ),
                      label: state == Productstate.loading
                          ? loadingWidget()
                          : Text(
                              trans(context).insertProduct,
                              style: h4.copyWith(color: black),
                            ),
                      icon: Icon(
                        Icons.add,
                        color: black,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
