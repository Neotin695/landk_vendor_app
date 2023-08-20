import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vendor_app/core/constances/media_const.dart';
import 'package:vendor_app/core/shared/empty_data.dart';
import 'package:vendor_app/core/tools/tools_widget.dart';
import 'package:vendor_app/vendor_app/order/bloc/order_bloc.dart';
import 'package:vendor_app/vendor_app/order/widget/accepted_orders.dart';
import 'package:vendor_app/vendor_app/order/widget/new_orders.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

late TabController tabcontroller;

class _OrderViewState extends State<OrderView> with TickerProviderStateMixin {
  late final OrderBloc bloc;

  @override
  void initState() {
    bloc = context.read<OrderBloc>();
    tabcontroller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabBar(
        tabs: [
          Tab(text: trans(context).newOrder),
          Tab(text: trans(context).acceptedOrder)
        ],
        controller: tabcontroller,
      ),
      body: SafeArea(
        child: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            if (state is OrderSuccessState) {
              return TabBarView(
                controller: tabcontroller,
                children: [
                  NewOrders(
                    orders: bloc.orders,
                  ),
                  AcceptedOrder(
                    orders: bloc.orders,
                  ),
                ],
              );
            }
            return EmptyData(
              assetIcon: iEmpty,
              title: 'no Orders',
            );
          },
        ),
      ),
    );
  }
}
