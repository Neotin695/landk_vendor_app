part of 'store_bloc.dart';

sealed class StoreEvent extends Equatable {
  const StoreEvent();

  @override
  List<Object> get props => [];
}

class FetchStoreEvent extends StoreEvent {}

class DeleteStoreEvent extends StoreEvent {}

class UpdateStoreEvent extends StoreEvent {}
