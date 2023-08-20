import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'package:vendor_app/core/tools/tools_widget.dart';
import 'package:vendor_app/vendor_app/order/view/preview_page.dart';

import '../bloc/order_bloc.dart';
import '../repository/src/models/order.dart';

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
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => PreviewPage(order: widget.order)));
              },
              leading: Text(widget.order.orderNum),
              title: Text(widget.order.paymentMethod),
              trailing: Text(DateFormat('yyyy-MM-DD HH:mm a').format(
                  DateTime.fromMillisecondsSinceEpoch(
                      widget.order.deliveryDate.millisecondsSinceEpoch))),
            ),
            ListTile(
              leading: Text(widget.order.deliveryPrice.toString()),
              title:
                  Text(widget.order.delivered ? 'delivered' : 'not delivered'),
              trailing: Text('${widget.order.productQuantity.length}'),
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
    );
  }
}
