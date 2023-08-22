import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'package:vendor_app/core/tools/tools_widget.dart';
import 'package:vendor_app/vendor_app/order/repository/order_repository.dart';

import '../../maps/map_repository/map_repository.dart';
import '../../maps/view/track_map_page.dart';
import '../bloc/order_bloc.dart';
import '../view/order_preview_page.dart';

class OrderItemAccepted extends StatefulWidget {
  const OrderItemAccepted({super.key, required this.order});
  final Order order;
  @override
  State<OrderItemAccepted> createState() => _OrderItemAcceptedState();
}

class _OrderItemAcceptedState extends State<OrderItemAccepted> {
  late final OrderBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<OrderBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => OrderPreviewPage(
                        order: widget.order,
                        orderRepository: OrderRepository())));
          },
          child: Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                          '${trans(context).deliveryPrice}: ${widget.order.deliveryPrice}'),
                      Text(
                          '${trans(context).paymentMethod}: ${widget.order.paymentMethod}'),
                    ],
                  ),
                  vSpace(2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        '${trans(context).orderState}: ${widget.order.delivered ? trans(context).delivered : trans(context).noDelivered}',
                      ),
                    ],
                  ),
                  vSpace(2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        '${trans(context).date}: ${(DateFormat('yyyy-MM-DD HH:mm a').format(DateTime.fromMillisecondsSinceEpoch(widget.order.deliveryDate.millisecondsSinceEpoch)))}',
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => TrackMapPage(
                                  delegate: widget.order.delegate,
                                  mapRepository: MapRepository())));
                    },
                    child: Text(trans(context).tracking),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
