import 'package:http/http.dart';
import 'package:tienda_virtual/products/services/api_product_service.dart';
import 'package:tienda_virtual/products/services/iproduct_service.dart';
import 'package:tienda_virtual/products/view_models/products_view_model.dart';

class ProductsBuilder {
  static ProductsViewModel builder() {
    IProductService service = APIProductService(Client());
    return ProductsViewModel(service);
  }
}
