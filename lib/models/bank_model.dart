// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class BankModel extends Equatable {
  final String accountNumber;
  final String bankName;
  final String branchName;
  final String holderName;
  final String otherDetails;
  const BankModel({
    required this.accountNumber,
    required this.bankName,
    required this.branchName,
    required this.holderName,
    required this.otherDetails,
  });

  @override
  List<Object> get props {
    return [
      accountNumber,
      bankName,
      branchName,
      holderName,
      otherDetails,
    ];
  }

  static BankModel empty() => const BankModel(
      accountNumber: '',
      bankName: '',
      branchName: '',
      holderName: '',
      otherDetails: '');

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accountNumber': accountNumber,
      'bankName': bankName,
      'branchName': branchName,
      'holderName': holderName,
      'otherDetails': otherDetails,
    };
  }

  factory BankModel.fromMap(Map<String, dynamic> map) {
    return BankModel(
      accountNumber: map['accountNumber'] as String,
      bankName: map['bankName'] as String,
      branchName: map['branchName'] as String,
      holderName: map['holderName'] as String,
      otherDetails: map['otherDetails'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BankModel.fromJson(String source) =>
      BankModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
