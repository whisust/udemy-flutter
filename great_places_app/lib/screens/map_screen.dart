import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/place.dart';

class MapScreen extends StatefulWidget {
  final Location initialLocation;
  final bool isSelecting;

  const MapScreen(
      {super.key,
      this.initialLocation = const Location(latitude: 48.78523, longitude: 2.36654, address: ''),
      this.isSelecting = false});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;

  void _selectLocation(LatLng location) {
    setState(() {
      _pickedLocation = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Map'),
          actions: [
            if (widget.isSelecting)
              IconButton(
                  onPressed: _pickedLocation == null
                      ? null
                      : () {
                          Navigator.of(context).pop(_pickedLocation);
                        },
                  icon: const Icon(Icons.check))
          ],
        ),
        body: GoogleMap(
          initialCameraPosition: CameraPosition(
              target: LatLng(widget.initialLocation.latitude, widget.initialLocation.longitude), zoom: 16),
          onTap: widget.isSelecting ? _selectLocation : null,
          markers: (_pickedLocation == null && widget.isSelecting)
              ? {}
              : {
                  Marker(
                      markerId: const MarkerId('kek'),
                      position:
                          _pickedLocation ?? LatLng(widget.initialLocation.latitude, widget.initialLocation.longitude))
                },
        ));
  }
}
