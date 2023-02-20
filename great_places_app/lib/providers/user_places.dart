import 'dart:io';

import 'package:flutter/foundation.dart';
import '../helpers/db_helper.dart';
import '../helpers/location_helper.dart';
import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Future<void> addPlace(String title, File image, Location pickedLocation) async {
    final address = await LocationHelper.getPlaceAddress(pickedLocation.latitude, pickedLocation.longitude);
    final location = pickedLocation.copyWith(address: address);
    final place = Place(id: DateTime.now().toString(), title: title, location: location, image: image);
    _items.add(place);
    notifyListeners();
    DBHelper.insert(DBHelper.PLACES_TABLE, {
      'id': place.id,
      'title': place.title,
      'image': place.image.path,
      'loc_lat': location.latitude,
      'loc_lng': location.longitude,
      'loc_address': location.address
    });
  }

  Future<void> fetchPlaces() async {
    final placesData = await DBHelper.getData(DBHelper.PLACES_TABLE);
    _items = placesData.map((item) {
      final location = Location(latitude: item['loc_lat'], longitude: item['loc_lng'], address: item['loc_address']);
      return Place(id: item['id'], title: item['title'], image: File(item['image']), location: location);
    }).toList();
    notifyListeners();
  }

  Place? findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }
}
