import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tienda_virtual/products/models/product_model.dart';
import 'package:tienda_virtual/products/view_models/cart_view_model.dart';


class ProductsItem extends StatelessWidget {
  const ProductsItem(this.product, this.onSelect, {super.key});

  final ProductModel product;
  final void Function() onSelect;

  @override
  Widget build(BuildContext context) {
    Provider.of<CartViewModel>(context, listen: false);

    return InkWell(
      onTap: onSelect,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(8),
                width: 80,
                height: 80,
                child: Image.asset('assets/images/product.png'),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    Text(product.description, style: const TextStyle(fontSize: 14)),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Precio:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    Text('S/.${product.price.toStringAsFixed(2)}', style: const TextStyle(fontSize: 14)),
                    const SizedBox(height: 5),
                    Consumer<CartViewModel>(
                      builder: (context, cart, _) => Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color.fromARGB(255, 188, 189, 188),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                cart.decreaseItemQuantity(product.id); // Disminuir la cantidad
                              },
                              icon: const Icon(Icons.remove),
                            ),
                            Text(cart.getQuantity(product.id).toString()), // Mostrar la cantidad
                            IconButton(
                              onPressed: () {
                                // Pasa el contexto al llamar a addItemToCart
                                cart.addItemToCart(product, context); // Aumentar la cantidad
                              },
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
