part of 'map_bloc.dart';

abstract class MapState extends Equatable {
  const MapState();
  
  @override
  List<Object> get props => [];
}

class MapInitial extends MapState {}

class LoadingState extends MapState{}

class SuccessState extends MapState{}

class FailureState extends MapState{}


