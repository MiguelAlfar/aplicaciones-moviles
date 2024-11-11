import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'package:tienda_virtual/products/maps/map_model.dart';
import 'package:tienda_virtual/products/maps/maps_view_model.dart';

class LocationMap extends StatefulWidget {
  final MapModel mapModel;
  const LocationMap({
    super.key,
    required this.mapModel,
  });

  @override
  State<LocationMap> createState() {
    return _LocationMapState();
  }
}

class _LocationMapState extends State<LocationMap> {
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var mapViewModel = Provider.of<MapViewModel>(context, listen: false);
      mapViewModel.setLocation(
          widget.mapModel.latitude, widget.mapModel.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    MapViewModel mapViewModel = context.watch<MapViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubicación'),
        backgroundColor: const Color.fromARGB(255, 196, 59, 59),
      ),
      body: _ui(mapViewModel),
    );
  }

  _ui(MapViewModel mapViewModel) {
    return Stack(
      children: <Widget>[
        GoogleMap(
          markers: mapViewModel.markers,
          mapType: MapType.normal,
          myLocationEnabled: false,
          zoomControlsEnabled: false,
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: LatLng(widget.mapModel.latitude, widget.mapModel.longitude),
            zoom: 11.0,
          ),
          onTap: (argument) async {
            mapViewModel.setLocation(argument.latitude, argument.longitude);
            _animateCamera(argument.latitude, argument.longitude);
            setState(() {});
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pop(context, mapViewModel.mapModel);
              },
              heroTag: 'save',
              child: const Icon(Icons.save),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: () async {
                var position = await mapViewModel.determineCurrentPosition();
                _animateCamera(
                  position.latitude,
                  position.longitude,
                );
              },
              heroTag: 'location',
              child: const Icon(Icons.location_on),
            ),
          ),
        ),
      ],
    );
  }

  _animateCamera(
    double latitude,
    double longitude,
  ) {
    final cameraUpdate = CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(
          latitude,
          longitude,
        ),
        zoom: 14,
      ),
    );
    mapController.animateCamera(cameraUpdate);
  }
}
