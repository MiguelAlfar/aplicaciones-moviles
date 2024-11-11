// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tienda_virtual/products/pages/home_button.dart';
import 'package:tienda_virtual/products/pages/make_purchase_page.dart';
import 'package:tienda_virtual/products/pages/products_list_page.dart';

class FailedPage extends StatefulWidget {
  const FailedPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<FailedPage> createState() => _FailedPageState();
}

Color themeColor = const Color(0xFF43D19E);

class _FailedPageState extends State<FailedPage> {
  double screenWidth = 600;
  double screenHeight = 400;
  Color textColor = const Color(0xFF32567A);

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 170,
              padding: EdgeInsets.all(35),
              decoration: BoxDecoration(
                color: themeColor,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                "assets/images/failed.png",
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: screenHeight * 0.1),
            Text(
              "Oops ocurrio un problema!",
              style: TextStyle(
                color: themeColor,
                fontWeight: FontWeight.w600,
                fontSize: 25,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              "",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w400,
                fontSize: 17,
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            SizedBox(height: screenHeight * 0.06),
            Flexible(
              child: HomeButton(
                title: 'Volver a Intentar',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MakePurchasePage()),
                  );
                },
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Flexible(
              child: HomeButton(
                title: 'Regresar al inicio',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProductsPage()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
