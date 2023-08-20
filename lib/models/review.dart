import 'package:equatable/equatable.dart';

class Reivew extends Equatable {
  final String id;
  final String user;
  final double rate;
  final String description;
  const Reivew({
    required this.id,
    required this.user,
    required this.rate,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user': user,
      'rate': rate,
      'description': description,
    };
  }

  factory Reivew.fromMap(Map<String, dynamic> map) {
    return Reivew(
      id: map['id'] as String,
      user: map['user'] as String,
      rate: map['rate'] as double,
      description: map['description'] as String,
    );
  }

  @override
  List<Object?> get props => [id, user, rate, description];
}
