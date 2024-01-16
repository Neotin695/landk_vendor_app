// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class TimeStore extends Equatable {
  final String startTime;
  final String endTime;
  final String day;
  final String vacation;
  const TimeStore({
    required this.startTime,
    required this.endTime,
    required this.day,
    required this.vacation,
  });

  @override
  List<Object> get props => [startTime, endTime, day, vacation];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'startTime': startTime,
      'endTime': endTime,
      'day': day,
      'vacation': vacation,
    };
  }

  factory TimeStore.fromMap(Map<String, dynamic> map) {
    return TimeStore(
      startTime: map['startTime'] as String,
      endTime: map['endTime'] as String,
      day: map['day'] as String,
      vacation: map['vacation'] as String,
    );
  }
}
