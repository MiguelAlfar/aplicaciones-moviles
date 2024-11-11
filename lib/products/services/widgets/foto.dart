import 'dart:typed_data';

import 'package:flutter/material.dart';

class Foto extends StatelessWidget {
  final Uint8List? picture;

  const Foto({super.key, this.picture});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color.fromARGB(255, 196, 59, 59),
          width: 5,
        ),
      ),
      child: ClipOval(
        child: SizedBox.fromSize(
          size: const Size.fromRadius(80),
          child: picture == null ? _defaultAvatar() : _imageAvatar(picture!),
        ),
      ),
    );
  }

  _defaultAvatar() {
    return Image.asset(
      'assets/images/user.png',
      fit: BoxFit.cover,
    );
  }

  _imageAvatar(Uint8List picture) {
    return Image.memory(picture, fit: BoxFit.cover);
  }
}
