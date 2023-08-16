import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Category extends Equatable {
  String id;
  String imageUrl;
  String nameEn;
  String nameAr;

  Category({
    required this.id,
    required this.imageUrl,
    required this.nameEn,
    required this.nameAr,
  });

  static Category empty() => Category(
        id: '',
        imageUrl: '',
        nameEn: '',
        nameAr: '',
      );
  @override
  List<Object?> get props => [
        id,
        imageUrl,
        nameEn,
        nameAr,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'imageUrl': imageUrl,
      'nameEn': nameEn,
      'nameAr': nameAr,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as String,
      imageUrl: map['imageUrl'] as String,
      nameEn: map['nameEn'] as String,
      nameAr: map['nameAr'] as String,
    );
  }
}
