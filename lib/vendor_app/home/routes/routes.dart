import 'package:flutter/material.dart';
import 'package:vendor_app/vendor_app/home/widgets/home_page.dart';
import 'package:vendor_app/vendor_app/home/widgets/menu_page.dart';
import 'package:vendor_app/vendor_app/order/view/order_page.dart';
import 'package:vendor_app/vendor_app/products/view/products_page.dart';
import 'package:vendor_app/vendor_app/store/view/store_page.dart';

enum HomeState {
  home,
  store,
  order,
  products,
  menu,
}

List<Page> onGenerateHomePage(HomeState state, List<Page> pages) {
  switch (state) {
    case HomeState.home:
      return [HomePage.page()];
    case HomeState.store:
      return [StorePage.page()];
    case HomeState.order:
      return [OrderPage.page()];
    case HomeState.menu:
      return [MenuPage.page()];
    case HomeState.products:
      return [ProductsPage.page()];
  }
}
