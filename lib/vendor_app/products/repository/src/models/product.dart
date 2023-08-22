// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:vendor_app/models/review.dart';

class Product extends Equatable {
  final String id;
  final String title;
  final String description;
  final String coverUrl;
  final List<String> images;
  final bool soldOut;
  final String category;
  final double price;
  final int quantity;
  final int discount;
  final bool active;
  final List<Review> reviews;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.coverUrl,
    required this.images,
    required this.active,
    required this.soldOut,
    required this.category,
    required this.price,
    required this.quantity,
    required this.discount,
    required this.reviews,
  });

  static Product empty() => const Product(
        id: '',
        title: '',
        description: '',
        coverUrl: '',
        images: [],
        soldOut: false,
        category: '',
        price: 0,
        active: false,
        quantity: 0,
        discount: 0,
        reviews: [],
      );

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        coverUrl,
        images,
        soldOut,
        category,
        price,
        active,
        quantity,
        discount,
        reviews
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'coverUrl': coverUrl,
      'images': images,
      'active': active,
      'soldOut': soldOut,
      'category': category,
      'price': price,
      'quantity': quantity,
      'discount': discount,
      'reviews': reviews.map((x) => x.toMap()).toList(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      category: map['category'] as String,
      coverUrl: map['coverUrl'] as String,
      description: map['description'] as String,
      discount: map['discount'] as int,
      id: map['id'] as String,
      active: map['active'] as bool,
      images: List<String>.from(map['images'].map((e) => e)),
      price: map['price'] as double,
      quantity: map['quantity'] as int,
      reviews: List<Review>.from(map['reviews'].map((e) => Review.fromMap(e))),
      soldOut: map['soldOut'] as bool,
      title: map['title'] as String,
    );
  }
  Product copyWith({
    String? id,
    String? title,
    String? description,
    String? coverUrl,
    List<String>? images,
    bool? soldOut,
    String? category,
    double? price,
    int? quantity,
    int? discount,
    bool? active,
    List<Review>? reviews,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      coverUrl: coverUrl ?? this.coverUrl,
      images: images ?? this.images,
      soldOut: soldOut ?? this.soldOut,
      category: category ?? this.category,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      discount: discount ?? this.discount,
      active: active ?? this.active,
      reviews: reviews ?? this.reviews,
    );
  }
}
