import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../helpers/location_helper.dart';
import '../screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;

  const LocationInput({Key? key, required this.onSelectPlace}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  void _onLocationRetrieved(double latitude, double longitude) {
    final previewUrl = LocationHelper.generateLocationPreview(latitude: latitude, longitude: longitude);
    setState(() {
      _previewImageUrl = previewUrl;
    });
    widget.onSelectPlace(latitude, longitude);
  }

  Future<void> _getCurrentUserLocation() async {
    final locationData = await Location().getLocation();
    _onLocationRetrieved(locationData.latitude!, locationData.longitude!);
  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => const MapScreen(
              isSelecting: true,
            )));
    if (selectedLocation != null) {
      _onLocationRetrieved(selectedLocation.latitude, selectedLocation.longitude);
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          child: _previewImageUrl == null
              ? const Text('No location chosen', textAlign: TextAlign.center)
              : Image.network(_previewImageUrl!, fit: BoxFit.cover, width: double.infinity),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: () async {
                await _getCurrentUserLocation();
              },
              icon: const Icon(Icons.location_on),
              label: const Text('Current Location'),
              style: TextButton.styleFrom(textStyle: Theme.of(context).textTheme.labelLarge),
            ),
            TextButton.icon(
              onPressed: _selectOnMap,
              icon: const Icon(Icons.map),
              label: const Text('Select on map'),
              style: TextButton.styleFrom(textStyle: Theme.of(context).textTheme.labelLarge),
            ),
          ],
        )
      ],
    );
  }
}
