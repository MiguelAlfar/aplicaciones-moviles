import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tienda_virtual/router_generator.dart';
import 'package:tienda_virtual/products/products_builder.dart';
import 'package:tienda_virtual/products/maps/map_builder.dart';
import 'package:tienda_virtual/products/purchase_builder.dart';
import 'package:tienda_virtual/products/view_models/cart_view_model.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductsBuilder.builder()),
        ChangeNotifierProvider(create: (_) => CartViewModel()),
        ChangeNotifierProvider(create: (_) => MakePurchaseBuilder.builder()),
        ChangeNotifierProvider(create: (_) => MapBuilder.builder()),
      ],
      child: const MaterialApp(
        initialRoute: '/',
        onGenerateRoute: RouterGenerator.generateRoute,
      ),
    );
  }
}
