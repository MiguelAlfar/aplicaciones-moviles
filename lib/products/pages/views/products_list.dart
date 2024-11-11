import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tienda_virtual/products/models/product_model.dart';
import 'package:tienda_virtual/products/pages/views/products_item.dart';
import 'package:tienda_virtual/products/view_models/products_view_model.dart';

class ProductsList extends StatelessWidget {
  const ProductsList(this.products, this.onSelect, {super.key});

  final List<ProductModel> products;
  final void Function() onSelect;

  @override
  Widget build(BuildContext context) {
    ProductsViewModel productsViewModel = context.watch<ProductsViewModel>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListView.builder(
        itemCount: productsViewModel.producListtModel.length,
        itemBuilder: (ctx, index) => Dismissible(
          background: Container(
            color: Colors.redAccent,
            margin: const EdgeInsets.symmetric(horizontal: 16),
          ),
          key: ValueKey(products[index]),
          child: ProductsItem(products[index], onSelect),
        ),
      ),
    );
  }
}
