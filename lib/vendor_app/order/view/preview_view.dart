import 'package:flutter/material.dart';
import 'package:vendor_app/vendor_app/order/repository/order_repository.dart';

class PreviewView extends StatelessWidget {
  const PreviewView({super.key, required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              order.id,
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              order.orderNum,
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              order.addressInfo.toString(),
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
    );
  }
}
