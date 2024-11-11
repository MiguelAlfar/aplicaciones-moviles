import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tienda_virtual/products/maps/map_model.dart';
import 'package:tienda_virtual/products/services/imake_purchase_service.dart';
import 'package:tienda_virtual/products/view_models/make_purchase_model.dart';

class MakePurchaseViewModel extends ChangeNotifier {
  IMakePuchaseService makePuchaseService;
  bool _loading = false;
  PurchaseModel? _purchase;
  Uint8List? _picture;
  final defaultLocation = const LatLng(-12.0593574, -77.1127197);

  bool get loading => _loading;
  Uint8List? get picture => _picture;
  PurchaseModel? get purchase => _purchase;
  MapModel get mapModel => MapModel(
        _purchase?.latitude ?? defaultLocation.latitude,
        _purchase?.longitude ?? defaultLocation.longitude,
        '',
      );

  MakePurchaseViewModel(this.makePuchaseService) {
    fetchUserProfile();
  }

  fetchUserProfile() async {
    _setLoading(true);
    _purchase = await makePuchaseService.getPurchase();
    if (_purchase?.avatarImage != null) {
      _picture = base64Decode(_purchase!.avatarImage!);
    }
    _setLoading(false);
  }

  Future<bool> updateUserProfile() async {
    _setLoading(true);
    if (_picture == null && _purchase != null) {
      return false;
    }
    _purchase!.avatarImage = await _preparePicture(_picture!);
    final result = await makePuchaseService.updatePurchase(_purchase!.toJson());
    _setLoading(false);
    return result;
  }

  setPicture(Uint8List? file) {
    _picture = file;
    notifyListeners();
  }

  setLocation(MapModel mapModel) {
    _purchase?.address = mapModel.address;
    _purchase?.latitude = mapModel.latitude;
    _purchase?.longitude = mapModel.longitude;
    notifyListeners();
  }

  _setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  Future<String> _preparePicture(Uint8List picture) async {
    final pictureCompressed = await FlutterImageCompress.compressWithList(
      picture,
      minHeight: 960,
      minWidth: 540,
      quality: 10,
      rotate: 0,
    );
    return base64Encode(pictureCompressed);
  }
}
