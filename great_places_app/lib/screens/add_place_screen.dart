import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/place.dart';
import '../providers/user_places.dart';
import '../widgets/location_input.dart';
import '../widgets/image_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';

  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;
  Location? _pickedLocation;

  void _selectImage(File image) {
    _pickedImage = image;
  }

  void _selectPlace(double lat, double lng) {
    _pickedLocation = Location(latitude: lat, longitude: lng);
  }

  Future<void> _savePlace() async {
    if (_titleController.text.isEmpty || _pickedImage == null || _pickedLocation == null) {
      return;
    } else {
      await Provider.of<GreatPlaces>(context, listen: false)
          .addPlace(_titleController.text, _pickedImage!, _pickedLocation!);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Add a new place')),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(children: [
                  TextField(
                    decoration: const InputDecoration(labelText: 'Title'),
                    controller: _titleController,
                  ),
                  const SizedBox(height: 10),
                  ImageInput(onSelectImage: _selectImage),
                  const SizedBox(height: 10),
                  LocationInput(onSelectPlace: _selectPlace),
                ]),
              ),
            )),
            TextButton.icon(
                onPressed: _savePlace,
                icon: const Icon(Icons.add),
                label: const Text('Add Place'),
                style: TextButton.styleFrom(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  foregroundColor: Colors.black87,
                  // textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.black87)),
                )),
          ],
        ));
  }
}
