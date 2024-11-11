import 'package:flutter/material.dart';
import 'package:tienda_virtual/common_components/error_dialog.dart';
import 'package:tienda_virtual/products/models/product_model.dart'; 
import 'package:tienda_virtual/products/models/cart_item_model.dart'; 

class CartViewModel extends ChangeNotifier {
  final List<CartItemModel> _items = [];

  List<CartItemModel> get items => _items;

  // Método para calcular el monto total del carrito.
  double get totalAmount {
    double total = 0;
    for (var item in _items) {
      total += item.price * item.quantity;
    }
    return total;
  }

  // Método para agregar un producto al carrito.
  void addItemToCart(ProductModel product, BuildContext context) {
  int existingIndex =
      _items.indexWhere((item) => item.productId == product.id);
  if (existingIndex != -1) {
    if (_items[existingIndex].quantity < product.stock) {
      _items[existingIndex].quantity++;
    } else {
      showErrorDialog(context);
    }
  } else {
    if (product.stock > 0) {
      _items.add(CartItemModel(
        productId: product.id,
        productName: product.name,
        price: product.price,
        quantity: 1,
      ));
    } else {
      showErrorDialog(context);
    }
  }
  notifyListeners();
}

  // Método para disminuir la cantidad de un producto en el carrito.
  void decreaseItemQuantity(String productId) {
  int existingIndex = _items.indexWhere((item) => item.productId == productId);
  if (existingIndex != -1) {
    if (_items[existingIndex].quantity > 1) {
      _items[existingIndex].quantity--;
    } else {
      _items.removeAt(existingIndex);
    }
    notifyListeners();
  }
}

  // Método para eliminar un producto del carrito.
  void removeItemFromCart(String productId) {
    _items.removeWhere((item) => item.productId == productId);
    notifyListeners();
  }

   // Método para obtener la cantidad de un producto en el carrito.
  int getQuantity(String productId) {
    var item = _items.firstWhere((item) 
    => item.productId == productId, orElse: () 
    => CartItemModel(productId: '', productName: '', price: 0, quantity: 0));
    return item.quantity;
  }
  
  
}
