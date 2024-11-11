import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tienda_virtual/common_components/app_loading.dart';
import 'package:tienda_virtual/products/pages/cart_page.dart';
import 'package:tienda_virtual/products/pages/views/products_header.dart';
import 'package:tienda_virtual/products/pages/views/products_list.dart';
import 'package:tienda_virtual/products/view_models/products_view_model.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() {
    return _ProductsPageState();
  }
}

class _ProductsPageState extends State<ProductsPage> {
  List<Widget>? _barActions(
      ProductsViewModel productsViewModel, BuildContext context) {
    return [
      IconButton(
  iconSize: 30,
  onPressed: () {
     // Navega a la página del carrito cuando se presiona el botón
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ShoppingCartPage()),
              );
  },
  icon: Container(
    padding: const EdgeInsets.all(10), 
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      color: Color.fromARGB(255, 109, 245, 116),
    ),
    child: const Icon(
      Icons.shopping_cart,
      color: Color.fromARGB(255, 0, 0, 0),
    ),
  ),
)

    ];
  }

  @override
  Widget build(BuildContext context) {
    ProductsViewModel productsViewModel = context.watch<ProductsViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
    'Bodega Digital',
    style: TextStyle(
      color: Color(0xFF090455), // Color del texto
      fontWeight: FontWeight.bold, // Fuente más gruesa
      fontSize: 25, // Tamaño de la fuente (opcional)
    ),
  ),
  backgroundColor: const Color.fromARGB(255, 243, 238, 238),
  actions: _barActions(productsViewModel, context),
),
      body: _ui(productsViewModel),
    );
  }

  _ui(ProductsViewModel productsViewModel) {
    if (productsViewModel.loading) {
      return const AppLoading();
    }

    if (productsViewModel.productError != null) {
      return Container();
    }

     return Column(
      children: [
        const ProductsHeader(),
        Expanded(
          child: ProductsList(
            productsViewModel.producListtModel,
            () {
              (context);
            },
          ),
        )
      ],
    );
  }
}


 

