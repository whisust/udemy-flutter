class Config {
  static const FIREBASE_URL =
      'https://udemy-flutter-shopp-app-default-rtdb.europe-west1.firebasedatabase.app';

  static const FIREBASE_AUTH_URL = 'https://identitytoolkit.googleapis.com/v1';

  static const FIREBASE_API_KEY = '';

  static const PRODUCTS_TABLE = 'products';

  static Uri getFirebaseUrlFor(
      {required String table,
      String? id,
      String? authToken,
      String? orderBy,
      String? equalTo}) {
    var url;
    if (id == null) {
      url = '$FIREBASE_URL/$table.json';
    } else {
      url = '$FIREBASE_URL/$table/$id.json';
    }
    var params = [];
    if (authToken != null) {
      params.add('auth=$authToken');
    }
    if (orderBy != null) {
      params.add('orderBy="$orderBy"');
    }
    if (equalTo != null) {
      params.add('equalTo="$equalTo"');
    }
    if (params.isNotEmpty) {
      url = '$url?${params.join('&')}';
    }
    return Uri.parse(url);
  }

  static Uri getFirebaseAuthUri(String action) {
    return Uri.parse('$FIREBASE_AUTH_URL/$action?key=$FIREBASE_API_KEY');
  }
}
