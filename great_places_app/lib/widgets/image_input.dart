import 'package:flutter/material.dart';
import 'dart:io';

class ImageInput extends StatefulWidget {
  const ImageInput({Key? key}) : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

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
            : Text(
                'No image taken',
                textAlign: TextAlign.center,
              ),
      ),
      SizedBox(width: 10),
      Expanded(
        child: ElevatedButton.icon(
          icon: Icon(Icons.camera),
          onPressed: () {},
          label: Text('Take Picture'),
          style: ElevatedButton.styleFrom(elevation: 0, textStyle: Theme.of(context).textTheme.labelLarge),
        ),
      )
    ]);
  }
}
