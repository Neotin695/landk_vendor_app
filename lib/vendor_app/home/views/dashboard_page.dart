import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/dashboard_bloc.dart';
import '../repository/dashboard_repository.dart';
import 'dashboard_view.dart';

class DashboardPage extends StatelessWidget {
  static Page page() => MaterialPage(
          child: DashboardPage(
        dashboardRepository: DashboardRepository(),
      ));
  const DashboardPage({super.key, required this.dashboardRepository});
  final DashboardRepository dashboardRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: dashboardRepository,
      child: BlocProvider(
        create: (context) =>
            DashboardBloc(dashboardRepository: dashboardRepository)
              ..add(AnalyseData()),
        child: const DashboardView(),
      ),
    );
  }
}
