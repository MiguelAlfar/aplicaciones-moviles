import 'package:http/http.dart';
import 'package:tienda_virtual/products/services/api_purchase_photo_service.dart';
import 'package:tienda_virtual/products/services/imake_purchase_service.dart';
import 'package:tienda_virtual/products/view_models/make_purchase_view_model.dart';

class MakePurchaseBuilder {
  static MakePurchaseViewModel builder() {
    IMakePuchaseService makePuchaseService = APIPurchasePhotoService(Client());
    return MakePurchaseViewModel(makePuchaseService);
  }
}
