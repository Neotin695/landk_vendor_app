import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

abstract class _PermissionHandler {
  Future<bool> handlePermission();
}

class PermissionHandler implements _PermissionHandler {
  late final Location _location;
  bool _locationServiceEnabled = false;
  LocationPermission? _locationPermission;

  PermissionHandler() : _location = Location();

  @override
  Future<bool> handlePermission() async {
    _locationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    _locationPermission = await Geolocator.checkPermission();

    if (_locationServiceEnabled &&
        _locationPermission == LocationPermission.denied) {
      _locationPermission = await Geolocator.requestPermission();

      if (_locationPermission == LocationPermission.denied) {
        _locationServiceEnabled = await _location.requestService();
      }
      print(_locationServiceEnabled);
      print(_locationPermission == LocationPermission.denied);
      return _locationServiceEnabled &&
          _locationPermission == LocationPermission.denied;
    } else {
      print(_locationServiceEnabled);
      print(_locationPermission != LocationPermission.denied);
      return _locationServiceEnabled &&
          _locationPermission != LocationPermission.denied;
    }
  }
}
