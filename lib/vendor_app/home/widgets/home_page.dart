import 'package:flutter/material.dart';
import 'package:vendor_app/vendor_app/home/repository/src/dashboard_repository.dart';
import 'package:vendor_app/vendor_app/home/views/dashboard_page.dart';

class HomePage extends StatelessWidget {
  static Page page() => const MaterialPage(child: HomePage());
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardPage(dashboardRepository: DashboardRepository());
  }
}
