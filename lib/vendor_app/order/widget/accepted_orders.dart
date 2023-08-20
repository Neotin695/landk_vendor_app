import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vendor_app/core/constances/media_const.dart';
import 'package:vendor_app/core/shared/empty_data.dart';
import 'package:vendor_app/vendor_app/order/bloc/order_bloc.dart';
import 'package:vendor_app/vendor_app/order/repository/src/models/order.dart';
import 'package:vendor_app/vendor_app/order/widget/order_item.dart';

class AcceptedOrder extends StatefulWidget {
  const AcceptedOrder({super.key, required this.orders});

  final List<Order> orders;

  @override
  State<AcceptedOrder> createState() => _AcceptedOrderState();
}

class _AcceptedOrderState extends State<AcceptedOrder> {
  late final OrderBloc bloc;
  late final List<Order> orders;

  @override
  void initState() {
    bloc = context.read<OrderBloc>();
    orders =
        widget.orders.where((element) => element.acceptable == true).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return orders.isNotEmpty
        ? ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return OrderItem(order: order);
            },
          )
        : EmptyData(assetIcon: iEmpty,title:'no Order');
  }
}
