import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tienda_virtual/products/models/cart_item_model.dart';
import 'package:tienda_virtual/products/pages/make_purchase_page.dart';
import 'package:tienda_virtual/products/view_models/cart_view_model.dart';
import 'package:tienda_virtual/products/pages/views/cart_item.dart';

class ShoppingCartPage extends StatelessWidget {
  const ShoppingCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Carrito de compras',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF090455),
          ),
        ),
      ),
      body: Container(
        color: const Color(0xFFE6E2E2),
        child: _buildCartItems(context),
      ),
    );
  }

  Widget _buildCartItems(BuildContext context) {
    final cartViewModel = Provider.of<CartViewModel>(context);
    final List<CartItemModel> cartItems = cartViewModel.items;

    if (cartItems.isEmpty) {
      return const Center(
        child: Text(
          'El carrito está vacío',
          style: TextStyle(
            fontSize: 20,
            color: Color(0xFF1A018A),
          ),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: cartItems.length + 1,
        itemBuilder: (context, index) {
          if (index < cartItems.length) {
            final cartItem = cartItems[index];
            return CartItem(cartItem: cartItem);
          } else {
            return _buildTotalPrice(cartViewModel.totalAmount, context);
          }
        },
      );
    }
  }

  Widget _buildTotalPrice(double totalPrice, BuildContext context) {
    return ListTile(
      title: Center(
        child: Text(
          'Total: S/.${totalPrice.toStringAsFixed(2)}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF020760),
            fontSize: 25,
          ),
        ),
      ),
      subtitle: Column(
        children: <Widget>[
          TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MakePurchasePage()),
                );
              },
              child: const Text('Realizar la compra'))
        ],
      ),
    );
  }
}
