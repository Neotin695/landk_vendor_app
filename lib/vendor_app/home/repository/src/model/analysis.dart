import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Analysis extends Equatable {
  double reviewCount;
  int productsCount;
  int ordersCount;
  Analysis({
    required this.reviewCount,
    required this.productsCount,
    required this.ordersCount,
  });

  static Analysis empty() =>
      Analysis(reviewCount: 0, productsCount: 0, ordersCount: 0);

  @override
  List<Object?> get props => [reviewCount, productsCount, ordersCount];
}
