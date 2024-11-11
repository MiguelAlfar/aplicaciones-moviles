
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tienda_virtual/products/models/cart_item_model.dart';
import 'package:tienda_virtual/products/view_models/cart_view_model.dart';

class CartItem extends StatelessWidget {
  final CartItemModel cartItem;

  const CartItem({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartViewModel>(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10), 
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), 
        border: Border.all(color: const Color(0xFF6DF574)), 
        color: const Color.fromARGB(255, 219, 218, 218),
      ),
       child: ListTile(
        leading: const Icon(
          Icons.shopping_cart,
          color: Color(0xFF117816),
        ),
        title: Text(cartItem.productName),
        subtitle: Text('${cartItem.quantity} x ${cartItem.price}'),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          color: const Color(0xFFFF0000),
          onPressed: () {
            cart.removeItemFromCart(cartItem.productId);
          },
        ),
      ),
    );
  }
}