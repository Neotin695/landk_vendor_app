import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:vendor_app/vendor_app/maps/map_repository/map_repository.dart';
import '../../../models/delegate.dart';
part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc(this.mapRepository) : super(MapInitial()) {
    on<InitMapController>(_initMapController);
    on<AddMarker>(_addMarker);
    on<GetCurrentLocation>(_getCurrentLocation);
    on<FetchDelegate>(_fetchDelegate);
    customInfoWindowController = CustomInfoWindowController();
  }

  FutureOr<void> _fetchDelegate(FetchDelegate event, emit) async {
    _subscriptionDelegate =
        mapRepository.fetchDelegate(event.id).listen((delegateVal) async {
      delegate = delegateVal;
      if (mapController != null) {
        final zoomLevel = await mapController!.getZoomLevel();

        add(AddMarker(
            id: 'delegate',
            latLng: LatLng(delegateVal.location.latitude,
                delegateVal.location.longitude)));
        await mapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: zoomLevel,
              target: LatLng(delegateVal.location.latitude,
                  delegateVal.location.longitude),
            ),
          ),
        );
      }
    });
  }

  bool isShown = false;

  Delegate delegate = Delegate.empty();

  late final StreamSubscription<Delegate> _subscriptionDelegate;

  @override
  Future<void> close() {
    _subscriptionDelegate.cancel();
    return super.close();
  }

  final MapRepository mapRepository;
  LocationData? currentLocation;
  MapType mapType = MapType.normal;
  Map<String, Marker> marker = {};
  GoogleMapController? mapController;
  late CustomInfoWindowController customInfoWindowController;
  Map<PolylineId, Polyline> polylines = {};
  PolylinePoints polylinePoints = PolylinePoints();

  FutureOr<void> _getCurrentLocation(GetCurrentLocation event, emit) async {
    emit(LoadingState());
    await mapRepository.getCurrentLocation().then((value) {
      currentLocation = value;
      if (currentLocation != null) {
        emit(FailureState());
      }
    });
    emit(SuccessState());
  }

  String name = '';

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool get isOpen => _scaffoldKey.currentState?.showBottomSheet != null;

  bool isBottomSheetOpen = false;

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  FutureOr<void> _addMarker(AddMarker event, emit) async {
    emit(LoadingState());

    marker = mapRepository.addMarker(event.id, event.latLng, '', '');

    emit(SuccessState());
  }

  FutureOr<void> _initMapController(InitMapController event, emit) {
    mapController = mapRepository.initMapController(event.mapController);
    customInfoWindowController.googleMapController = mapController;
  }
}
