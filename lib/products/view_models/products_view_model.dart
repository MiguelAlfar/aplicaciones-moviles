import 'package:flutter/material.dart';
import 'package:tienda_virtual/products/models/error_service_model.dart';
import 'package:tienda_virtual/products/models/product_model.dart';
import 'package:tienda_virtual/products/services/iproduct_service.dart';

class ProductsViewModel extends ChangeNotifier {
  bool _loading = false;
  List<ProductModel> _productListModel = [];
  ErrorServiceModel? _productError;
  final IProductService _productService;
   

  bool get loading => _loading;
  List<ProductModel> get producListtModel => _productListModel;
  ErrorServiceModel? get productError => _productError;
  

  ProductsViewModel(this._productService) {
    getProducts();
  }

   _setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

   _setProductListModel(List<ProductModel> productListModel) {
    _productListModel = productListModel;
  }

    _setProductError(ErrorServiceModel productError) {
    _productError = productError;
  }
  
// Método para obtener los productos del servicio.
getProducts() async {
    _setLoading(true);
    var response = await _productService.getProduct(null);
    if (response is List<ProductModel>) {
      _setProductListModel(response);
    } else if (response is ErrorServiceModel) {
      _setProductError(response as ErrorServiceModel);
    }
    _setLoading(false);
  }
}
