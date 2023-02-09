import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../configuration.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isFavorite = false});

  Future<void> toggleFavorite(String? authToken, String? userId) async {
    final previousStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    try {
      final response = await http.put(
          Config.getFirebaseUrlFor(table: 'userFavorites/$userId', id: id, authToken: authToken),
          body: json.encode(isFavorite));
      if (response.statusCode >= 400) {
        isFavorite = previousStatus;
      }
    } catch (err) {
      isFavorite = previousStatus;
      // throw new Exception('failed to toggle favorite my dude');
    } finally {
      notifyListeners();
    }
  }

  Product copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    String? imageUrl,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite,
    );
  }
}
