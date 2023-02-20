import 'dart:io';

class Location {
  final double latitude;
  final double longitude;
  final String? address;

  const Location({
    required this.latitude,
    required this.longitude,
    this.address,
  });

  @override
  String toString() {
    return 'Location{latitude: $latitude, longitude: $longitude, address: $address}';
  }

  Location copyWith({
    double? latitude,
    double? longitude,
    String? address,
  }) {
    return Location(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
    );
  }
}

class Place {
  final String id;
  final String title;
  final Location location;
  final File image;

  const Place({
    required this.id,
    required this.title,
    required this.location,
    required this.image,
  });
}