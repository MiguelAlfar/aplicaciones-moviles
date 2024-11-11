import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tienda_virtual/products/camera/camera_page.dart';
import 'package:tienda_virtual/products/maps/map_model.dart';
import 'package:tienda_virtual/products/maps/maps_page.dart';
import 'package:tienda_virtual/products/pages/cart_page.dart';
import 'package:tienda_virtual/products/pages/products_list_page.dart';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const ProductsPage());

      case '/shoppping':
        return MaterialPageRoute(builder: (_) => const ShoppingCartPage());
      case '/camera':
        if (arguments is List<CameraDescription>) {
          return MaterialPageRoute(
              builder: (_) => CameraPage(cameras: arguments));
        } else {
          return _errorRoute();
        }
      case '/map':
        if (arguments is MapModel) {
          return MaterialPageRoute(
              builder: (_) => LocationMap(mapModel: arguments));
        } else {
          return _errorRoute();
        }
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
