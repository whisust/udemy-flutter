import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  const ImageInput({Key? key, required this.onSelectImage}) : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(source: ImageSource.camera, maxWidth: 600);
    if (imageFile != null) {
      setState(() {
        _storedImage = File(imageFile.path);
      });
      final appDir = await syspath.getApplicationDocumentsDirectory();
      final imageFileName = path.basename(imageFile.path);
      final imagePath = path.join(appDir.path, imageFileName);
      await imageFile.saveTo(imagePath);
      widget.onSelectImage(_storedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
        alignment: Alignment.center,
        child: _storedImage != null
            ? Image.file(_storedImage!, fit: BoxFit.cover, width: double.infinity)
            : const Text(
                'No image taken',
                textAlign: TextAlign.center,
              ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: ElevatedButton.icon(
          icon: const Icon(Icons.camera),
          onPressed: _takePicture,
          label: const Text('Take Picture'),
          style: ElevatedButton.styleFrom(elevation: 0, textStyle: Theme.of(context).textTheme.labelLarge),
        ),
      )
    ]);
  }
}
