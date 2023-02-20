import 'package:http/http.dart' as http;
import 'dart:convert';

const GOOGLE_API_KEY = ''; // TODO remove me before pushing on git

class LocationHelper {
  static String generateLocationPreview({required double latitude, required double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?'
        'center=$latitude,$longitude'
        '&zoom=15'
        '&size=600x300'
        '&markers=color:red%7Clabel:C%7C$latitude,$longitude'
        '&key=$GOOGLE_API_KEY';
  }

  static Future<String?> getPlaceAddress(double lat, double lng) async {
    final resp = await http.get(Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY'));
    final data = json.decode(resp.body);
    if (data['status'] == 'OK') {
      final address = data['results'][0]['formatted_address'];
      return address as String;
    } else {
      return null;
    }
  }
}
