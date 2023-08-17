import 'package:equatable/equatable.dart';

import '../../../../../models/model.dart';

// ignore: must_be_immutable
class Customer extends Equatable {
  String id;
  String photoUrl;
  String name;
  String email;
  String phoneNum;
  String token;
  bool isEmailVerified;
  bool active;
  AddressInfo location;

  List<String> orders;

  static Customer empty() => Customer(
      id: '',
      active: false,
      name: '',
      photoUrl: '',
      email: '',
      isEmailVerified: false,
      phoneNum: '',
      token: '',
      location: AddressInfo.empty(),
      orders: const []);

  Customer({
    required this.id,
    required this.active,
    required this.name,
    required this.photoUrl,
    required this.email,
    required this.isEmailVerified,
    required this.phoneNum,
    required this.location,
    required this.token,
    required this.orders,
  });

  @override
  List<Object> get props {
    return [
      id,
      active,
      name,
      email,
      photoUrl,
      phoneNum,
      token,
      isEmailVerified,
      location,
      orders,
    ];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'active': active,
      'name': name,
      'isEmailVerified': isEmailVerified,
      'email': email,
      'token': token,
      'phoneNum': phoneNum,
      'photoUrl': photoUrl,
      'location': location.toMap(),
      'orders': orders,
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
        id: map['id'] as String,
        photoUrl: map['photoUrl'] as String,
        name: map['name'] as String,
        token: map['token'] as String,
        email: map['email'] as String,
        active: map['active'] as bool,
        phoneNum: map['phoneNum'] as String,
        isEmailVerified: map['isEmailVerified'] as bool,
        location: AddressInfo.fromMap(map['location'] as Map<String, dynamic>),
        orders: List<String>.from(map['orders'].map((e) => e)));
  }
}
