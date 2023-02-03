class Config {
  static const FIREBASE_URL =
      'https://udemy-flutter-shopp-app-default-rtdb.europe-west1.firebasedatabase.app';

  static const PRODUCTS_TABLE = 'products';

  static Uri getFirebaseUrlFor(String table, String? id) {
    var url;
    if (id == null) {
      url = '$FIREBASE_URL/$table.json';
    } else {
      url = '$FIREBASE_URL/$table/$id.json';
    }
    return Uri.parse(url);
  }
}
