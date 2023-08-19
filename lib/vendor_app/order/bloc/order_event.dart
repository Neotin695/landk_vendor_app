// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'order_bloc.dart';

sealed class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class AcceptOrder extends OrderEvent {
  const AcceptOrder({required this.id});
  final String id;
}

class RejectOrder extends OrderEvent {
  final String id;
  const RejectOrder({
    required this.id,
  });
}

class _FetchAllOrders extends OrderEvent {
  final List<Order> orders;
  const _FetchAllOrders({
    required this.orders,
  });
}

class FetchOneOrder extends OrderEvent {
  final String id;
  const FetchOneOrder({
    required this.id,
  });
}

class FetchCustomer extends OrderEvent {
  final String id;
  const FetchCustomer({
    required this.id,
  });
}

class FetchDelegate extends OrderEvent {
  final String id;
  const FetchDelegate({
    required this.id,
  });
}

class FetchProduct extends OrderEvent {
  final List<String> ids;
  const FetchProduct({
    required this.ids,
  });
}
