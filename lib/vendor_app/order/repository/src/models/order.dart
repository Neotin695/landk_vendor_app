import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:vendor_app/models/address_info.dart';
import 'package:vendor_app/vendor_app/order/repository/src/models/product_quantity.dart';

class Order extends Equatable {
  final String id;
  final List<ProductQuantity> productQuantity;
  final String orderNum;
  final double deliveryPrice;
  final bool acceptable;
  final bool delivered;
  final String customer;
  final String delegate;
  final FieldValue deliveryDate;
  final AddressInfo addressInfo;
  final String paymentMethod;
  const Order({
    required this.id,
    required this.productQuantity,
    required this.orderNum,
    required this.deliveryPrice,
    required this.acceptable,
    required this.customer,
    required this.delivered,
    required this.delegate,
    required this.deliveryDate,
    required this.addressInfo,
    required this.paymentMethod,
  });

  static Order empty() => Order(
      id: '',
      productQuantity: const [],
      orderNum: '',
      deliveryPrice: 0,
      acceptable: false,
      customer: '',
      delivered: false,
      delegate: '',
      deliveryDate: FieldValue.serverTimestamp(),
      addressInfo: AddressInfo.empty(),
      paymentMethod: '');

  @override
  List<Object?> get props => [
        id,
        productQuantity,
        orderNum,
        deliveryPrice,
        acceptable,
        customer,
        delivered,
        delegate,
        deliveryDate,
        addressInfo,
        paymentMethod
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'productQuantity': productQuantity.map((x) => x.toMap()).toList(),
      'orderNum': orderNum,
      'deliveryPrice': deliveryPrice,
      'acceptable': acceptable,
      'customer': customer,
      'delivered': delivered,
      'delegate': delegate,
      'deliveryDate': deliveryDate,
      'addressInfo': addressInfo.toMap(),
      'paymentMethod': paymentMethod,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] as String,
      productQuantity: List<ProductQuantity>.from(
        (map['productQuantity'] as List<int>).map<ProductQuantity>(
          (x) => ProductQuantity.fromMap(x as Map<String, dynamic>),
        ),
      ),
      customer: map['customer'] as String,
      orderNum: map['orderNum'] as String,
      deliveryPrice: map['deliveryPrice'] as double,
      acceptable: map['acceptable'] as bool,
      delivered: map['delivered'] as bool,
      delegate: map['delegate'] as String,
      deliveryDate: map['deliveryDate'] as FieldValue,
      addressInfo:
          AddressInfo.fromMap(map['addressInfo'] as Map<String, dynamic>),
      paymentMethod: map['paymentMethod'] as String,
    );
  }
}
