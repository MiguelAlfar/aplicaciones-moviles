import 'package:flutter/material.dart';
import 'package:flutter_address_from_latlng/flutter_address_from_latlng.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:tienda_virtual/products/maps/map_model.dart';

class MapViewModel extends ChangeNotifier {
  final Set<Marker> _markers = {};
  LatLng _currentLocation = const LatLng(45.521563, -122.677433);
  String? _address;

  Set<Marker> get markers => _markers;
  LatLng get currentLocation => _currentLocation;
  String? get address => _address;
  MapModel get mapModel => MapModel(
        _currentLocation.latitude,
        _currentLocation.longitude,
        _address ?? '',
      );

  Future<Position> determineCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      throw 'Servicio de ubicación desactivado';
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        throw 'Permiso de ubicación denegado';
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  void setLocation(double latitude, double longitude) async {
    _currentLocation = LatLng(latitude, longitude);
    _address = await _getAddressFrom(latitude, longitude);
    _addMarker(latitude, longitude);
    notifyListeners();
  }

  void _addMarker(double latitude, double longitude) {
    _markers.clear();
    _markers.add(
      Marker(
        markerId: const MarkerId('currentLocation'),
        position: LatLng(latitude, longitude),
      ),
    );
  }

  Future<String?> _getAddressFrom(double latitude, double longitude) async {
    var address = await FlutterAddressFromLatLng().getDirectionAddress(
      latitude: latitude,
      longitude: longitude,
      googleApiKey: 'AIzaSyDUy4renOh-m4v46s5C3LtrcKQIqiKGNB8',
    );
    return address?.formattedAddress;
  }
}
