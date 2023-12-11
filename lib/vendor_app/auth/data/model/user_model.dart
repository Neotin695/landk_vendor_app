import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vendor_app/models/img_model.dart';
import 'package:vendor_app/vendor_app/auth/domain/entities/user_entity.dart';

import '../../../../models/bank_model.dart';
import '../../../../models/rental_model.dart';
import 'package:intl/intl.dart';

class UserModel extends UserEntity {
  const UserModel(
      {required super.id,
      required super.fcmToken,
      required super.firstName,
      required super.active,
      required super.isActive,
      required super.lastName,
      required super.email,
      required super.photoUrl,
      required super.role,
      required super.lastOnline,
      required super.settings,
      required super.bankDetails,
      required super.rental,
      required super.phonNum,
      required super.walletAmount});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fcmToken': fcmToken,
      'firstName': firstName,
      'lastName': lastName,
      'active': active,
      'isActive': isActive,
      'email': email,
      'photoUrl': photoUrl.toMap(),
      'role': role,
      'lastOnline': lastOnline,
      'settings': null,
      'bankDetails': bankDetails.toMap(),
      'rental': rental.toMap(),
      'phonNum': phonNum,
      'walletAmount': walletAmount,
    };
  }

  factory UserModel.toModel(UserEntity userEntity) => UserModel(
      id: userEntity.id,
      fcmToken: userEntity.fcmToken,
      firstName: userEntity.firstName,
      active: userEntity.active,
      isActive: userEntity.isActive,
      lastName: userEntity.lastName,
      email: userEntity.email,
      photoUrl: userEntity.photoUrl,
      role: userEntity.role,
      lastOnline: userEntity.lastOnline,
      settings: userEntity.settings,
      bankDetails: userEntity.bankDetails,
      rental: userEntity.rental,
      phonNum: userEntity.phonNum,
      walletAmount: userEntity.walletAmount);

  static UserModel empty = UserModel(
      id: '',
      fcmToken: '',
      active: false,
      isActive: false,
      firstName: '',
      lastName: '',
      email: '',
      photoUrl: ImgModel.empty(),
      role: '',
      lastOnline: '2023-12-10 12:38:26.172',
      settings: const Settings(),
      bankDetails: BankModel.empty(),
      rental: Rental.empty(),
      phonNum: '',
      walletAmount: 0);

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      fcmToken: map['fcmToken'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      photoUrl: ImgModel.fromMap(map['photoUrl']),
      active: map['active'] as bool,
      isActive: map['isActive'] as bool,
      role: map['role'] as String,
      lastOnline: map['lastOnline'] as String,
      settings: const Settings(),
      bankDetails:
          BankModel.fromMap(map['bankDetails'] as Map<String, dynamic>),
      rental: Rental.fromMap(map['rental'] as Map<String, dynamic>),
      phonNum: map['phonNum'] as String,
      walletAmount: map['walletAmount'] as double,
    );
  }
}
