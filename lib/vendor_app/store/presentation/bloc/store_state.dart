part of 'store_bloc.dart';

sealed class StoreState extends Equatable {
  const StoreState();

  @override
  List<Object> get props => [];
}

final class StoreInitial extends StoreState {}

final class StoreLoading extends StoreState {}

final class StoreLoaded extends StoreState {
  final Store store;

  const StoreLoaded({required this.store});
}

final class StoreFailure extends StoreState {
  final String message;

  const StoreFailure({required this.message});
}
