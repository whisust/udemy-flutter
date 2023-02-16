import 'dart:io';

import 'package:flutter/foundation.dart';
import '../helpers/db_helper.dart';
import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String title, File image) {
    final location = Location(latitude: 0, longitude: 0, address: 'home'); // todo
    final place = Place(id: DateTime.now().toString(), title: title, location: location, image: image);
    _items.add(place);
    print("######## Added new place $title");
    notifyListeners();
    DBHelper.insert(DBHelper.PLACES_TABLE, {'id': place.id, 'title': place.title, 'image': place.image.path});
  }

  Future<void> fetchPlaces() async {
    final placesData = await DBHelper.getData(DBHelper.PLACES_TABLE);
    _items = placesData.map((item) {
      final location = Location(latitude: 0, longitude: 0, address: 'home'); // todo
      return Place(id: item['id'], title: item['title'], image: File(item['image']), location: location);
    }).toList();
    notifyListeners();
  }
}
