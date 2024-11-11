import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tienda_virtual/products/pages/views/cart_item.dart';
import 'package:tienda_virtual/products/view_models/cart_view_model.dart';

class CartList extends StatelessWidget {
  const CartList({super.key});

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartViewModel>(context);
    var items = cart.items;
    
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return CartItem(cartItem: items[index]);
      },
    );
  }
}
