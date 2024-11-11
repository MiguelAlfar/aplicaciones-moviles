import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tienda_virtual/products/models/error_service_model.dart';
import 'package:tienda_virtual/products/models/product_model.dart';
import 'package:tienda_virtual/products/services/iproduct_service.dart';
import 'package:tienda_virtual/products/services/url_mixin.dart';
import 'package:tienda_virtual/utils/constants.dart';

class APIProductService with UriMixin implements IProductService {
  final http.Client client;
  final headers = {
  };

  APIProductService(this.client);

  @override
  Future<List<Object>> getProduct(Map<String, dynamic>? queries) async {
    try {
      final url = getUri('product');
      var response = await http.get(url);
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((jsonProduct) {
        return ProductModel(
          id: jsonProduct['id'],
          slug: jsonProduct['slug'],
          name: jsonProduct['name'],
          description: jsonProduct['description'],
          price: jsonProduct['price'].toDouble(),
          stock: jsonProduct['stock'],
        );
      }).toList();
    } on ArgumentError {
      throw ErrorServiceModel(kParseError);
    } catch (exception) {
      throw ErrorServiceModel(kGenericError);
    }
  }

   
}

