import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:vendor_app/core/tools/tools_widget.dart';
import 'package:vendor_app/vendor_app/maps/bloc/map_bloc.dart';

class MapView extends StatefulWidget {
  const MapView({super.key, required this.state});
  final String state;
  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late final MapBloc bloc;

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    bloc = context.read<MapBloc>();
    context.read<MapBloc>().add(GetCurrentLocation());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<MapBloc>().add(GetCurrentLocation());
    return Scaffold(
      key: bloc.scaffoldKey,
      body: SafeArea(
        child: BlocBuilder<MapBloc, MapState>(
          builder: (context, state) {
            if (state is SuccessState) {
              return _GoogleMap(bloc: bloc);
            } else if (state is LoadingState) {
              return Align(alignment: Alignment.center, child: loadingWidget());
            } else {
              return empty();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (widget.state == 'locate') {
            if (bloc.marker['selectPlace'] != null) {
              Navigator.pop<LocationData>(
                context,
                LocationData.fromMap(
                  {
                    'latitude': bloc.marker['selectPlace']!.position.latitude,
                    'longitude': bloc.marker['selectPlace']!.position.longitude,
                  },
                ),
              );
            }
          } else {
            bloc.add(GetCurrentLocation());
          }
        },
        child: Icon(widget.state == 'locate' ? Icons.done : Icons.my_location),
      ),
    );
  }
}

class _GoogleMap extends StatefulWidget {
  const _GoogleMap({
    required this.bloc,
  });

  final MapBloc bloc;

  @override
  State<_GoogleMap> createState() => _GoogleMapState();
}

class _GoogleMapState extends State<_GoogleMap> {
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: widget.bloc.mapType,
      initialCameraPosition: CameraPosition(
          target: LatLng(widget.bloc.currentLocation!.latitude!,
              widget.bloc.currentLocation!.longitude!),
          zoom: 15),
      onMapCreated: (controller) {
        widget.bloc.add(InitMapController(mapController: controller));
      },
      onTap: (latLng) async {
        widget.bloc.add(
          AddMarker(
            id: 'selectPlace',
            latLng: latLng,
          ),
        );
      },
      markers: widget.bloc.marker.values.toSet(),
    );
  }
}
