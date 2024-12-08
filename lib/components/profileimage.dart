// profileimage.dart
import 'dart:typed_data';
import 'package:flutter/material.dart';


class ProfileImage extends StatelessWidget {
  final Uint8List? image;

  const ProfileImage({super.key, this.image});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 70,
      backgroundImage: image != null ? MemoryImage(image!) : const AssetImage('assets/default_image.png') as ImageProvider,
      child: image == null ? const Icon(Icons.person, size: 100, color: Colors.white) : null,
    );
  }
}
