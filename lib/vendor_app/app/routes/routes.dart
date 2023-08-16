import 'package:flutter/material.dart';

import '../../auth/views/auth_page.dart';
import '../../home/views/home_page.dart';
import '../bloc/app_bloc.dart';

List<Page> onGenerateAuthPage(AppStatus appState, List<Page> pages) {
  switch (appState) {
    case AppStatus.unauthenticated:
      return [AuthPage.page()];
    case AppStatus.authenticated:
      return [HomePage.page()];
    default:
      return [AuthPage.page()];
  }
}
