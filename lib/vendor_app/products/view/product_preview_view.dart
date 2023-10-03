import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:vendor_app/core/theme/colors/landk_colors.dart';
import 'package:vendor_app/core/theme/fonts/landk_fonts.dart';
import 'package:vendor_app/core/tools/tools_widget.dart';
import 'package:vendor_app/vendor_app/order/view/order_preview_view.dart';

import '../repository/product_repository.dart';

class ProductPreviewView extends StatelessWidget {
  const ProductPreviewView({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: customKey,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          vSpace(1),
          CarouselSlider(
            options: CarouselOptions(height: 30.h),
            items: product.images.map(
              (i) {
                return Builder(
                  builder: (BuildContext context) {
                    return CachedNetworkImage(
                      imageUrl: i,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    );
                  },
                );
              },
            ).toList(),
          ),
          vSpace(3),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
             locale(context)? product.titleAr: product.titleEn,
              style: h3.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          vSpace(2),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              locale(context)? product.descriptionAr:product.descriptionEn,
              style: h4.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          vSpace(2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                '${trans(context).price}: ${product.price.toString()}',
                style: h4,
              ),
              Text(
                '${trans(context).quantity}: ${product.quantity.toString()}',
                style: h4,
              ),
            ],
          ),
          vSpace(3),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                '${trans(context).state}: ${product.soldOut ? trans(context).soldOut : trans(context).available}',
                style: h4,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  trans(context).review,
                  style: h3,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: product.reviews.length,
                itemBuilder: (context, index) {
                  final review = product.reviews[index];
                  return Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(review.description),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star,
                              color: yellow,
                            ),
                            Text(review.rate.toString()),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
