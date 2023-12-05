import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constances/media_const.dart';
import '../../../core/language/lang.dart';
import '../../../core/theme/colors/landk_colors.dart';
import '../../../core/theme/fonts/landk_fonts.dart';
import '../../../core/tools/tools_widget.dart';
import '../bloc/dashboard_bloc.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  late final DashboardBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<DashboardBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DashboardBloc, DashboardStatus>(
        builder: (context, state) {
          if (state == DashboardStatus.loading) {
            return Center(child: loadingWidget());
          } else if (state == DashboardStatus.success ||
              state == DashboardStatus.initial) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _DashboardCard(
                        label: AppLocalizations.of(context)!.review,
                        count: context.select((DashboardBloc value) =>
                            value.analysis.reviewCount),
                        icon: iStar,
                      ),
                      _DashboardCard(
                        label: AppLocalizations.of(context)!.order,
                        count: context.select((DashboardBloc value) =>
                            value.analysis.ordersCount),
                        icon: iOrders,
                      ),
                      _DashboardCard(
                        label: AppLocalizations.of(context)!.products,
                        count: context.select((DashboardBloc value) =>
                            value.analysis.productsCount),
                        icon: iProducts,
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return empty();
          }
        },
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  const _DashboardCard({
    required this.label,
    required this.icon,
    required this.count,
  });

  final String label;
  final String icon;
  final num count;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: orange45,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: SizedBox(
        width: 30.w,
        height: 20.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                icon,
                width: 8.w,
                height: 8.h,
              ),
            ),
            Text(
              '$count',
              style: h5.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              label,
              style: h5.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
