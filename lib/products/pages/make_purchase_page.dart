import 'dart:math';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tienda_virtual/common_components/app_loading.dart';
import 'package:tienda_virtual/products/maps/map_model.dart';
import 'package:tienda_virtual/products/pages/failed_page.dart';
import 'package:tienda_virtual/products/pages/success_page.dart';
import 'package:tienda_virtual/products/services/widgets/foto.dart';
import 'package:tienda_virtual/products/view_models/make_purchase_view_model.dart';

class RouteGeneratorRandom {
  static List<String> myRandomPages = ['success', 'failed'];

  static String getRandomNameOfRoute() {
    return myRandomPages[Random().nextInt(myRandomPages.length)];
  }
}

class MakePurchasePage extends StatefulWidget {
  const MakePurchasePage({super.key});

  @override
  State<MakePurchasePage> createState() {
    return _MakePurchasePageState();
  }
}

class _MakePurchasePageState extends State<MakePurchasePage> {
  String _dropDownValue = '';
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MakePurchaseViewModel makePurchaseViewModel =
        context.watch<MakePurchaseViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('LLenar Datos de Compra'),
      ),
      body: _ui(context, makePurchaseViewModel),
    );
  }

  _ui(BuildContext context, MakePurchaseViewModel makePurchaseViewModel) {
    if (makePurchaseViewModel.loading) {
      return const AppLoading();
    }

    String result;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Column(
          children: [
            DropdownButton(
              hint: _dropDownValue == ''
                  ? Text('Seleccione un Tipo de Pago')
                  : Text(
                      _dropDownValue,
                      style:
                          const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    ),
              isExpanded: true,
              iconSize: 30.0,
              style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
              items: ['Visa', 'Mastercard', 'ContraEntrega'].map(
                (val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: Text(val),
                  );
                },
              ).toList(),
              onChanged: (val) {
                setState(
                  () {
                    _dropDownValue = val!;
                  },
                );
              },
            ),
            TextField(
                decoration: const InputDecoration(
                  label: Text('Nombre:'),
                ),
                onChanged: (_) => {}),
            TextField(
                decoration: const InputDecoration(
                  label: Text('Telefono:'),
                ),
                onChanged: (_) => {}),
            // TextField(
            //   controller: _nameController
            //     ..text = makePurchaseViewModel.purchase?.name ?? '',
            //   decoration: const InputDecoration(
            //     label: Text('Telefono:'),
            //   ),
            //   onChanged: (text) => makePurchaseViewModel.purchase?.name = text,
            // ),
            TextField(
              controller: _addressController
                ..text = makePurchaseViewModel.purchase?.address ?? '',
              decoration: InputDecoration(
                labelText: "Dirección",
                suffixIcon: InkWell(
                  onTap: () {
                    _goToMap(makePurchaseViewModel);
                  },
                  child: Tab(icon: Image.asset('assets/images/map.png')),
                ),
              ),
              onChanged: (text) =>
                  makePurchaseViewModel.purchase?.address = text,
            ),
            const SizedBox(height: 30),
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //       backgroundColor: const Color.fromARGB(255, 59, 196, 59)),
            //   onPressed: () async {
            //     final result = await makePurchaseViewModel.updateUserProfile();
            //     if (!context.mounted) {
            //       return;
            //     }
            //     _showSnackbar(result);
            //   },
            //   child: const Text('Update user'),
            // ),

            Foto(picture: makePurchaseViewModel.picture),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 195, 204, 209)),
              onPressed: () async {
                await availableCameras().then(
                  (value) => _goToCamera(makePurchaseViewModel, value),
                );
              },
              child: const Text('Tomar Foto'),
            ),
            const Divider(
              height: 20,
              color: Color.fromARGB(255, 211, 206, 206),
              thickness: 5,
            ),
            TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green)),
                onPressed: () => {
                      result = RouteGeneratorRandom.getRandomNameOfRoute(),
                      if (result == "success")
                        {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const SuccessPage(title: "Gracias")),
                          )
                        }
                      else
                        {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const FailedPage(title: "Error")),
                          )
                        }
                    },
                child: const Text('Comprar'))
          ],
        ),
      ),
    );
  }

  _goToCamera(
    MakePurchaseViewModel makePurchaseViewModel,
    List<CameraDescription> cameras,
  ) async {
    final picture = await Navigator.pushNamed(
      context,
      '/camera',
      arguments: cameras,
    );
    if (picture is Uint8List) {
      makePurchaseViewModel.setPicture(picture);
    }
  }

  _goToMap(MakePurchaseViewModel makePurchaseViewModel) async {
    final mapModel = await Navigator.pushNamed(
      context,
      '/map',
      arguments: makePurchaseViewModel.mapModel,
    );
    if (mapModel is MapModel) {
      makePurchaseViewModel.setLocation(mapModel);
    }
  }
}
