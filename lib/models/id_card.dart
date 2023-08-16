import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class IdCard extends Equatable {
  String firstName;
  String middleName;
  String lastName;
  String nationalNum;
  IdCard({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.nationalNum,
  });

  @override
  List<Object?> get props => [firstName, middleName, lastName, nationalNum];

  static IdCard empty() =>
      IdCard(firstName: '', middleName: '', lastName: '', nationalNum: '');

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'nationalNum': nationalNum,
    };
  }

  factory IdCard.fromMap(Map<String, dynamic> map) {
    return IdCard(
      firstName: map['firstName'] as String,
      middleName: map['middleName'] as String,
      lastName: map['lastName'] as String,
      nationalNum: map['nationalNum'] as String,
    );
  }
}
