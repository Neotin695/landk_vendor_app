import 'package:equatable/equatable.dart';

class Review extends Equatable {
  final String id;
  final String user;
  final double rate;
  final String description;
  const Review({
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

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      id: map['id'] as String,
      user: map['user'] as String,
      rate: double.parse(map['rate'].toString()),
      description: map['description'] as String,
    );
  }

  @override
  List<Object?> get props => [id, user, rate, description];
}
