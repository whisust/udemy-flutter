import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File image) onImagePicked;
  const UserImagePicker({Key? key, required this.onImagePicked}) : super(key: key);

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera, imageQuality: 50, maxWidth: 150);
    if (pickedImage != null) {
      setState(() {
        _pickedImage = File(pickedImage.path);
      });
      widget.onImagePicked(_pickedImage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CircleAvatar(
          radius: 40,
          backgroundColor: Theme.of(context).colorScheme.primary,
          backgroundImage: _pickedImage != null ? FileImage(_pickedImage!) : null),
      TextButton.icon(onPressed: _pickImage, icon: Icon(Icons.image), label: Text('Add picture')),
    ]);
  }
}
