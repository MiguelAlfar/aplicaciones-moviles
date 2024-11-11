import 'package:tienda_virtual/products/view_models/make_purchase_model.dart';

abstract class IMakePuchaseService {
  Future<PurchaseModel> getPurchase();

  Future<bool> updatePurchase(Map<String, dynamic> body);
}
