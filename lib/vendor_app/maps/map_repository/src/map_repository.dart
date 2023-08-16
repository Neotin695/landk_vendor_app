import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:vendor_app/core/services/permission_handler/src/permission_handler.dart';

abstract class _MapRepository {
  Future<void> getCurrentLocation();
  Map<String, Marker> addMarker(String id, LatLng latLng, title, subTitle);

  GoogleMapController initMapController(GoogleMapController mapController);
}

class MapRepository implements _MapRepository {
  late LocationData _currentLocation;
  late final Location _location;

  late final PermissionHandler _permissionHandler;

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
  }

  @override
  Future<LocationData?> getCurrentLocation() async {
    if (await _permissionHandler.handlePermission()) {
      await _location.getLocation().then((value) async {
        _currentLocation = value;
      });

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
}
