import 'package:equatable/equatable.dart';

class ProductQuantity extends Equatable {
  final String productId;
  final int quantity;
  const ProductQuantity({
    required this.productId,
    required this.quantity,
  });

  static ProductQuantity empty() =>
      const ProductQuantity(productId: '', quantity: 0);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'quantity': quantity,
    };
  }

  factory ProductQuantity.fromMap(Map<String, dynamic> map) {
    return ProductQuantity(
      productId: map['productId'] as String,
      quantity: map['quantity'] as int,
    );
  }

  @override
  List<Object?> get props => [productId, quantity];
}
