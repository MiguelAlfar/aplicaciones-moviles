import 'package:flutter/material.dart';

class ProductsHeader extends StatelessWidget {
  const ProductsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 8, bottom: 8, right: 8),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Color(0xFF6DF574),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child:  Row(
          children: [
            const Text(
              'Lista de Productos',
              style: TextStyle(
                color: Color.fromARGB(255, 3, 3, 3),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const Spacer(),
            Image.asset('assets/images/productlista.png',
            width: 80,
            height: 80,
            fit: BoxFit.cover,
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
