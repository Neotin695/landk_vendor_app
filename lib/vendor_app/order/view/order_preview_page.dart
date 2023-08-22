import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vendor_app/vendor_app/order/bloc/order_bloc.dart';
import 'package:vendor_app/vendor_app/order/repository/order_repository.dart';

import 'order_preview_view.dart';

class OrderPreviewPage extends StatelessWidget {
  const OrderPreviewPage(
      {super.key, required this.order, required this.orderRepository});

  final Order order;
  final OrderRepository orderRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: orderRepository,
        child: BlocProvider(
          create: (context) => OrderBloc(orderRepository),
          child: OrderPreviewView(
            order: order,
          ),
        ));
  }
}
