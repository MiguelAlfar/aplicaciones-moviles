import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tienda_virtual/products/models/error_service_model.dart';
import 'package:tienda_virtual/products/services/imake_purchase_service.dart';
import 'package:tienda_virtual/products/services/url_mixin.dart';
import 'package:tienda_virtual/products/view_models/make_purchase_model.dart';
import 'package:tienda_virtual/utils/constants.dart';

class APIPurchasePhotoService with UriMixin implements IMakePuchaseService {
  final http.Client client;
  final headers = {
    'Content-Type': 'application/json',
  };

  APIPurchasePhotoService(this.client);

  @override
  Future<PurchaseModel> getPurchase() async {
    try {
      final url = getUri('user/653c20ac96680964f7286ccb');
      var response = await http.get(url);
      final dynamic result = json.decode(response.body);
      return PurchaseModel.fromJson(result);
    } catch (exception) {
      throw ErrorServiceModel(kGenericError);
    }
  }

  @override
  Future<bool> updatePurchase(Map<String, dynamic> body) async {
    try {
      final url = getUri('user/653c20ac96680964f7286ccb');
      var response = await http.patch(
        url,
        headers: headers,
        body: json.encode(body),
      );
      return response.statusCode == 200;
    } catch (exception) {
      throw ErrorServiceModel(kGenericError);
    }
  }
}
