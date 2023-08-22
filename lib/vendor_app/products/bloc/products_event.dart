// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'products_bloc.dart';

sealed class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class InsertProduct extends ProductsEvent {}

class UpdateProduct extends ProductsEvent {
  final String id;
  const UpdateProduct({
    required this.id,
  });
}

class DeleteProduct extends ProductsEvent {
  final String id;
  const DeleteProduct({
    required this.id,
  });
}

class FetchOneProduct extends ProductsEvent {
  final String id;
  const FetchOneProduct({
    required this.id,
  });
}

class _FetchAllProducts extends ProductsEvent {
  final List<Product> products;
  const _FetchAllProducts({
    required this.products,
  });
}

class ToggleActiveProduct extends ProductsEvent {
  final String id;
  final bool state;
  const ToggleActiveProduct({
    required this.id,
    required this.state,
  });
}
