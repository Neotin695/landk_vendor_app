import 'package:equatable/equatable.dart';

import '../../../../../models/address_info.dart';
import 'onwer.dart';

class Store extends Equatable {
  final bool acceptable;
  final bool active;
  final AddressInfo addressInfo;
  final String category;
  final String coverUrl;
  final String id;
  final String logoUrl;
  final String name;
  final Onwer onwer;
  final List<String> reviews;

  const Store(
      {required this.id,
      required this.onwer,
      required this.active,
      required this.category,
      required this.logoUrl,
      required this.name,
      required this.coverUrl,
      required this.acceptable,
      required this.addressInfo,
      required this.reviews});

  static Store empty() => Store(
        id: '',
        onwer: Onwer.empty(),
        active: false,
        category: '',
        name: '',
        acceptable: false,
        logoUrl: '',
        coverUrl: '',
        addressInfo: AddressInfo.empty(),
        reviews: const [],
      );

  @override
  List<Object?> get props => [
        id,
        onwer,
        active,
        acceptable,
        category,
        name,
        logoUrl,
        coverUrl,
        addressInfo,
        reviews
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'onwer': onwer.toMap(),
      'active': active,
      'category': category,
      'logoUrl': logoUrl,
      'acceptable': acceptable,
      'coverUrl': coverUrl,
      'name': name,
      'addressInfo': addressInfo.toMap(),
      'reviews': reviews,
    };
  }

  factory Store.fromMap(Map<String, dynamic> map) {
    return Store(
      id: map['id'] as String,
      onwer: Onwer.fromMap(map['onwer'] as Map<String, dynamic>),
      active: map['active'] as bool,
      category: map['category'] as String,
      logoUrl: map['logoUrl'] as String,
      acceptable: map['acceptable'] as bool,
      coverUrl: map['coverUrl'] as String,
      name: map['name'] as String,
      addressInfo:
          AddressInfo.fromMap(map['addressInfo'] as Map<String, dynamic>),
      reviews: List<String>.from(map['reviews'].map((e) => e)),
    );
  }
  Store copyWith(
      {String? id,
      Onwer? onwer,
      bool? active,
      String? category,
      String? logoUrl,
      String? coverUrl,
      String? name,
      bool? acceptable,
      AddressInfo? addressInfo,
      List<String>? reviews}) {
    return Store(
        id: id ?? this.id,
        onwer: onwer ?? this.onwer,
        active: active ?? this.active,
        category: category ?? this.category,
        logoUrl: logoUrl ?? this.logoUrl,
        name: name ?? this.name,
        coverUrl: coverUrl ?? this.coverUrl,
        acceptable: acceptable ?? this.acceptable,
        addressInfo: addressInfo ?? this.addressInfo,
        reviews: reviews ?? this.reviews);
  }
}
