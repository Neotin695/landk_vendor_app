// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class AddressInfo extends Equatable {
  double longitude;
  double latitude;
  String specialMarque;
  AddressInfo({
    required this.longitude,
    required this.latitude,
    required this.specialMarque,
  });

  @override
  List<Object?> get props => [longitude, latitude, specialMarque];

  static empty() => AddressInfo(longitude: 0, latitude: 0, specialMarque: '');

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'longitude': longitude,
      'latitude': latitude,
      'specialMarque': specialMarque,
    };

  }

  factory AddressInfo.fromMap(Map<String, dynamic> map) {
    return AddressInfo(
      longitude: double.parse(map['longitude'].toString()),
      latitude: double.parse(map['latitude'].toString()),
      specialMarque: map['specialMarque'] as String,
    );
  }

  @override
  bool get stringify => true;
}
