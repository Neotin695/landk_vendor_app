// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class InitialCameraPosition extends MapEvent {}

class InitMapController extends MapEvent {
  final GoogleMapController mapController;
  const InitMapController({
    required this.mapController,
  });
}

class GetCurrentLocation extends MapEvent {}

class FetchDelegate extends MapEvent {
  final String id;
  const FetchDelegate({
    required this.id,
  });
}

class CheckMarker extends MapEvent {}

class AddMarker extends MapEvent {
  final String id;
  final LatLng latLng;

  const AddMarker({
    required this.id,
    required this.latLng,
  });
}
