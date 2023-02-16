import 'dart:io';

import 'package:flutter/foundation.dart';
import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String title, File image) {
    final location = Location(latitude: 0, longitude: 0, address: 'home'); // todo
    _items.add(Place(id: DateTime.now().toString(), title: title, location: location, image: image));
    print("######## Added new place $title");
    notifyListeners();
  }
}
