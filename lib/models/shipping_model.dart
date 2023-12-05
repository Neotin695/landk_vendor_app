// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:vendor_app/models/rental_model.dart';

class ShippingModel extends Equatable {
  final String city;
  final String country;
  final String email;
  final String line1;
  final String line2;
  final String postalCode;
  final String name;
  final Rental rental;
  const ShippingModel({
    required this.city,
    required this.country,
    required this.email,
    required this.line1,
    required this.line2,
    required this.postalCode,
    required this.name,
    required this.rental,
  });

  @override
  List<Object> get props {
    return [
      city,
      country,
      email,
      line1,
      line2,
      postalCode,
      name,
      rental,
    ];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'city': city,
      'country': country,
      'email': email,
      'line1': line1,
      'line2': line2,
      'postalCode': postalCode,
      'name': name,
      'rental': rental.toMap(),
    };
  }

  factory ShippingModel.fromMap(Map<String, dynamic> map) {
    return ShippingModel(
      city: map['city'] as String,
      country: map['country'] as String,
      email: map['email'] as String,
      line1: map['line1'] as String,
      line2: map['line2'] as String,
      postalCode: map['postalCode'] as String,
      name: map['name'] as String,
      rental: Rental.fromMap(map['rental'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ShippingModel.fromJson(String source) =>
      ShippingModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
