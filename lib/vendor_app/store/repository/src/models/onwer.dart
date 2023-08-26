
import 'package:equatable/equatable.dart';

import 'package:vendor_app/models/id_card.dart';

class Onwer extends Equatable {
  final String id;
  final String userName;
  final String phoneNum;
  final String email;
  final IdCard idCard;
  const Onwer({
    required this.id,
    required this.userName,
    required this.phoneNum,
    required this.email,
    required this.idCard,
  });

  static Onwer empty() => Onwer(
      id: '', userName: '', phoneNum: '', email: '', idCard: IdCard.empty());

  @override
  List<Object?> get props => [id, userName, phoneNum, email, idCard];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userName': userName,
      'phoneNum': phoneNum,
      'email': email,
      'idCard': idCard.toMap(),
    };
  }

  factory Onwer.fromMap(Map<String, dynamic> map) {
    return Onwer(
      id: map['id'] as String,
      userName: map['userName'] as String,
      phoneNum: map['phoneNum'] as String,
      email: map['email'] as String,
      idCard: IdCard.fromMap(map['idCard'] as Map<String, dynamic>),
    );
  }

 
}
