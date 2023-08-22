import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'package:vendor_app/core/tools/tools_widget.dart';
import 'package:vendor_app/vendor_app/order/repository/order_repository.dart';
import 'package:vendor_app/vendor_app/order/view/order_preview_page.dart';

import '../bloc/order_bloc.dart';

class OrderItem extends StatefulWidget {
  const OrderItem({super.key, required this.order});
  final Order order;
  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
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
                      '${trans(context).location}: ${widget.order.addressInfo}',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        bloc.add(AcceptOrder(id: widget.order.id));
                      },
                      child: Text(trans(context).accept),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        bloc.add(RejectOrder(id: widget.order.id));
                      },
                      child: Text(trans(context).reject),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
