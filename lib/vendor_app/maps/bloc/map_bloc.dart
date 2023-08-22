import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
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
    //emit(LoadingState());
    _subscriptionDelegate =
        mapRepository.fetchDelegate(event.id).listen((event) {
      delegate = event;
      if (delegate != Delegate.empty()) {
       // emit(SuccessState());
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
  late GoogleMapController mapController;
  late CustomInfoWindowController customInfoWindowController;

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
    List<Placemark> placemarks = await placemarkFromCoordinates(
      event.latLng.latitude,
      event.latLng.longitude,
    );
    emit(LoadingState());
    // String imageUrl =
    //     await fetchPlaceId(event.latLng.latitude, event.latLng.longitude);
    if (placemarks.isNotEmpty) {
      marker = mapRepository.addMarker(event.id, event.latLng,
          placemarks[0].subAdministrativeArea, placemarks[0].street);
    }
    emit(SuccessState());
  }
/* 

  ////
  you need enable billing account in google cloud console
  ///

  Future<String> fetchPlaceId(double latitude, double longitude) async {
    final response = await http.get(
      Uri.parse(
          'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&radius=500&key=${LogicConst.googleMapApiKey}'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final firstPlace = data['results'];
      print(data);
      return await fetchPlacePhoto(firstPlace['place_id']);
    } else {
      throw Exception('Failed to retrieve place ID');
    }
  }

    Future<String> fetchPlacePhoto(String placeId) async {
    final response = await http.get(
      Uri.parse(
          'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=${LogicConst.googleMapApiKey}'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final photoReference = data['result']['photos'][0]['photo_reference'];
      return 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=$photoReference&key=${LogicConst.googleMapApiKey}';
    } else {
      throw Exception('Failed to load place photo');
    }
  }

  */

  FutureOr<void> _initMapController(InitMapController event, emit) {
    mapController = mapRepository.initMapController(event.mapController);
    customInfoWindowController.googleMapController = mapController;
  }
}
