import 'package:flutter/material.dart';

import '../views/home_page.dart';

enum HomeState { home }

List<Page> onGenerateHomePage(HomeState state, List<Page> pages) {
  switch (state) {
    case HomeState.home:
      return [HomePage.page()];
  }
}
