import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:vendor_app/core/services/permission_handler/src/permission_handler.dart';

import '../../../../models/delegate.dart';

abstract class _MapRepository {
  Future<void> getCurrentLocation();
  Map<String, Marker> addMarker(String id, LatLng latLng, title, subTitle);

  GoogleMapController initMapController(GoogleMapController mapController);

  Stream<Delegate> fetchDelegate(String id);
}

class MapRepository implements _MapRepository {
  late LocationData _currentLocation;
  late final Location _location;

  late final PermissionHandler _permissionHandler;

  late final FirebaseFirestore _firestore;

  // map setup
  GoogleMapController? mapController;

  Map<String, Marker> marker = {};
  late final CameraPosition initialCameraPosition;
  late final Completer<GoogleMapController> controller;

  MapRepository() {
    initialCameraPosition =
        const CameraPosition(target: LatLng(1.454545, 1.234235), zoom: 15);
    controller = Completer();
    _permissionHandler = PermissionHandler();
    _location = Location();
    _firestore = FirebaseFirestore.instance;
  }

  @override
  Future<LocationData?> getCurrentLocation() async {
    if (await _permissionHandler.handlePermission()) {
      _currentLocation = await _location.getLocation();

      _location.onLocationChanged.listen((newLoc) {
        _currentLocation = newLoc;
      });
      return _currentLocation;
    } else {
      return null;
    }
  }

  @override
  Map<String, Marker> addMarker(String id, LatLng latLng, title, subTitle) {
    final mark = Marker(
      markerId: MarkerId(id),
      position: latLng,
      infoWindow: InfoWindow(
        title: title,
        snippet: subTitle,
      ),
    );
    marker[id] = mark;
    return marker;
  }

  @override
  GoogleMapController initMapController(GoogleMapController mapController) {
    mapController = mapController;
    return mapController;
  }

  @override
  Stream<Delegate> fetchDelegate(String id) {
    try {
      return _firestore
          .collection('delegates')
          .doc(id)
          .snapshots()
          .map((event) => Delegate.fromMap(event.data()!));
    } catch (e) {
      return Stream.error(e);
    }
  }
}
