// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Rental extends Equatable {
  final double latitude;
  final double longitude;
  const Rental({
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object> get props => [latitude, longitude];

  static Rental empty() => const Rental(latitude: 0, longitude: 0);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory Rental.fromMap(Map<String, dynamic> map) {
    return Rental(
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Rental.fromJson(String source) =>
      Rental.fromMap(json.decode(source) as Map<String, dynamic>);
}
