import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'package:vendor_app/core/tools/tools_widget.dart';

import '../bloc/order_bloc.dart';
import '../repository/src/models/order.dart';

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
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Text(widget.order.orderNum),
              title: Text(widget.order.paymentMethod),
              trailing: Text(DateFormat('YY-MM-DD HH:mm A').format(
                  DateTime.fromMillisecondsSinceEpoch(
                      widget.order.deliveryDate as int))),
            ),
            ListTile(
              leading: Text(widget.order.deliveryPrice.toString()),
              title: Text(widget.order.delivered.toString()),
              trailing: Text('${widget.order.productQuantity.length}'),
            ),
            Row(
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
    );
  }
}
