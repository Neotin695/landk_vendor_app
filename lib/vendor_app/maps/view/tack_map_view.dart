import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:vendor_app/core/constances/media_const.dart';
import 'package:vendor_app/core/theme/colors/landk_colors.dart';
import 'package:vendor_app/core/tools/tools_widget.dart';
import 'package:vendor_app/vendor_app/maps/bloc/map_bloc.dart';
import 'package:vendor_app/vendor_app/order/view/order_preview_view.dart';

class TrackMapView extends StatefulWidget {
  const TrackMapView({super.key, required this.delegate});
  final String delegate;
  @override
  State<TrackMapView> createState() => _MapViewState();
}

class _MapViewState extends State<TrackMapView> {
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
    bloc.add(FetchDelegate(id: widget.delegate));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<MapBloc>().add(GetCurrentLocation());
    return Scaffold(
      key: customKey,
      body: SafeArea(
        child: BlocBuilder<MapBloc, MapState>(
          builder: (context, state) {
            if (state is SuccessState) {
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  _GoogleMap(bloc: bloc),
                  _toolMapType(),
                  _windowDelegate(),
                ],
              );
            } else if (state is LoadingState) {
              return Align(alignment: Alignment.center, child: loadingWidget());
            } else {
              return empty();
            }
          },
        ),
      ),
    );
  }

  Align _toolMapType() {
    return Align(
      alignment: Alignment.topRight,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: () {
                  bloc.mapType = MapType.satellite;
                  setState(() {});
                },
                icon: Icon(
                  Icons.satellite,
                  color: orange,
                )),
            IconButton(
                onPressed: () {
                  bloc.mapType = MapType.terrain;
                  setState(() {});
                },
                icon: Icon(
                  Icons.terrain,
                  color: orange,
                )),
            IconButton(
                onPressed: () {
                  bloc.mapType = MapType.normal;
                  setState(() {});
                },
                icon: Icon(
                  Icons.map,
                  color: orange,
                ))
          ],
        ),
      ),
    );
  }

  Positioned _windowDelegate() {
    return Positioned(
      bottom: 30,
      child: SizedBox(
        width: 75.w,
        height: 10.h,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            leading: bloc.delegate.photoUrl.isEmpty
                ? SvgPicture.asset(
                    iPerson,
                  )
                : CachedNetworkImage(
                    imageUrl: bloc.delegate.photoUrl,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
            title: Text(bloc.delegate.name),
            subtitle: Text(bloc.delegate.phoneNum),
          ),
        ),
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
          target: LatLng(widget.bloc.delegate.location.latitude,
              widget.bloc.delegate.location.longitude),
          zoom: 18),
      onMapCreated: (controller) {
        widget.bloc.add(InitMapController(mapController: controller));
        widget.bloc.add(
          AddMarker(
            id: 'delegate',
            latLng: LatLng(widget.bloc.delegate.location.latitude,
                widget.bloc.delegate.location.longitude),
          ),
        );
      },
      markers: widget.bloc.marker.values.toSet(),
    );
  }
}
