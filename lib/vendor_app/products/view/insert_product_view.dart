import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:vendor_app/core/services/category_repository/src/models/category.dart';
import 'package:vendor_app/core/services/common.dart';
import 'package:vendor_app/core/shared/pick_image_widget.dart';
import 'package:vendor_app/core/shared/txt_field.dart';
import 'package:vendor_app/core/tools/tools_widget.dart';
import 'package:vendor_app/vendor_app/products/bloc/products_bloc.dart';

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
                        child: PickImageWidget(
                          width: 30,
                          height: 15,
                          source: bloc.coverPath,
                          onTap: () {
                            bloc.add(PickCover());
                          },
                          label: trans(context).productImage,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.w,
                          vertical: 2.h,
                        ),
                        child: PickImageWidget(
                          width: 30,
                          height: 15,
                          sources: bloc.imagesPaths,
                          onTap: () {
                            bloc.add(PickImages());
                          },
                          label: trans(context).productImage,
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
                cn: bloc.titleEn,
                label: 'Product title en',
              ),
              TxtField(
                cn: bloc.descriptionAr,
                label: 'وصف المنتج بالعربية',
              ),
              TxtField(
                cn: bloc.descriptionEn,
                label: 'Product description en',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: TxtField(
                      cn: bloc.quantity,
                      label: 'Product quantity',
                      inputType: TextInputType.number,
                    ),
                  ),
                  Expanded(
                    child: TxtField(
                      cn: bloc.price,
                      label: 'Product Price',
                      inputType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              FutureBuilder(
                future: FirebaseFirestore.instance.collection('category').get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final categories = List<Category>.from(snapshot.data!.docs
                        .map((e) => Category.fromMap(e.data())));
                    return DropdownButton(
                        hint: Text(bloc.selectedCategory.isNotEmpty
                            ? locale(context)
                                ? categories
                                    .firstWhere((element) =>
                                        element.id == bloc.selectedCategory)
                                    .nameAr
                                : categories
                                    .firstWhere((element) =>
                                        element.id == bloc.selectedCategory)
                                    .nameEn
                            : ''),
                        items: categories
                            .map<DropdownMenuItem<String>>(
                              (e) => DropdownMenuItem(
                                value: e.id,
                                child:
                                    Text(locale(context) ? e.nameAr : e.nameEn),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          bloc.selectedCategory = value!;
                          setState(() {});
                        });
                  }
                  return empty();
                },
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
              vSpace(3),
            ],
          ),
        ),
      ),
    );
  }
}
