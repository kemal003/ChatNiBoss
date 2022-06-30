import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({Key? key}) : super(key: key);

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;

  void _pickImage() async {
    final imagePick = await ImagePicker().pickImage(source: ImageSource.camera);
    final pickedImage = File(imagePick!.path);
    setState(() {
      _pickedImage = pickedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          radius: 30,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage!) : null,
        ),
        TextButton.icon(
          icon: const Icon(Icons.image),
          label: const Text('Tambahkan foto profil'),
          style: TextButton.styleFrom(
            primary: Theme.of(context).colorScheme.primary,
            backgroundColor: Colors.grey[200],
          ),
          onPressed: _pickImage,
        ),
      ],
    );
  }
}
