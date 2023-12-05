// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:vendor_app/models/bank_model.dart';
import 'package:vendor_app/models/img_model.dart';
import 'package:vendor_app/models/rental_model.dart';

class UserEntity extends Equatable {
  final String id;
  final bool active;
  final bool isActive;
  final String fcmToken;
  final String firstName;
  final String lastName;
  final String email;
  final String? tempPathImg;
  final ImgModel photoUrl;
  final String role;
  final Timestamp lastOnline;
  final Settings settings;
  final BankModel bankDetails;
  final Rental rental;
  final String phonNum;
  final double walletAmount;

  

  const UserEntity({
    required this.id,
    required this.fcmToken,
    required this.firstName,
    required this.active,
    this.tempPathImg,
    required this.isActive,
    required this.lastName,
    required this.email,
    required this.photoUrl,
    required this.role,
    required this.lastOnline,
    required this.settings,
    required this.bankDetails,
    required this.rental,
    required this.phonNum,
    required this.walletAmount,
  });

  @override
  List<Object> get props {
    return [
      id,
      fcmToken,
      firstName,
      lastName,
      active,
      isActive,
      tempPathImg!,
      email,
      photoUrl,
      role,
      lastOnline,
      settings,
      bankDetails,
      rental,
      phonNum,
      walletAmount,
    ];
  }

  

  UserEntity copyWith({
    String? id,
    bool? active,
    bool? isActive,
    String? fcmToken,
    String? firstName,
    String? lastName,
    String? email,
    String? tempPathImg,
    ImgModel? photoUrl,
    String? role,
    Timestamp? lastOnline,
    Settings? settings,
    BankModel? bankDetails,
    Rental? rental,
    String? phonNum,
    double? walletAmount,
  }) {
    return UserEntity(
      id: id ?? this.id,
      active: active ?? this.active,
      isActive: isActive ?? this.isActive,
      fcmToken: fcmToken ?? this.fcmToken,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      tempPathImg: tempPathImg ?? this.tempPathImg,
      photoUrl: photoUrl ?? this.photoUrl,
      role: role ?? this.role,
      lastOnline: lastOnline ?? this.lastOnline,
      settings: settings ?? this.settings,
      bankDetails: bankDetails ?? this.bankDetails,
      rental: rental ?? this.rental,
      phonNum: phonNum ?? this.phonNum,
      walletAmount: walletAmount ?? this.walletAmount,
    );
  }
}
