import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './map_screen.dart';
import '../providers/user_places.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = '/place-detail';
  const PlaceDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final placeId = ModalRoute.of(context)?.settings.arguments;
    if (placeId != null) {
      final place = Provider.of<GreatPlaces>(context, listen: false).findById(placeId as String);
      if (place != null) {
        return Scaffold(
            appBar: AppBar(
              title: Text(place.title),
            ),
            body: Column(children: [
              Container(
                height: 250,
                width: double.infinity,
                child: Image.file(place.image, fit: BoxFit.cover, width: double.infinity),
              ),
              const SizedBox(height: 10),
              Text(
                place.location.address ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20, color: Colors.black45),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      foregroundColor: Colors.black87,
                      elevation: 0),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (ctx) => MapScreen(initialLocation: place.location, isSelecting: false)));
                  },
                  child: const Text('View on map'))
            ]));
      }
    }
    return Scaffold(
        appBar: AppBar(
      title: const Text('Place not found'),
    ));
  }
}
