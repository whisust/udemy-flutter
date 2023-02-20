# Great Places App

App de sauvegarde d'endroits favoris.

## Setup

1. Récupérer la clef d'API
   dans [Google Maps Platform](https://console.cloud.google.com/projectselector2/google/maps-apis/credentials)
2. Entrer la clef d'API Google dans les endroits suivants:

- `android/app/src/main/AndroidManifest.xml`

```xml

<meta-data android:name="com.google.android.geo.API_KEY" android:value="<API_KEY>" />
```

- `lib/helpers/location_helper.dart`

```dart

const GOOGLE_API_KEY = 'API_KEY';
```

## Sujets abordés

### Configuration du build Android

- modification du fichier `android/app/build.gradle` s'il faut modifier des variables de build

### UI

- Scaffold / AppBar
- ListView
- ListTile
- CircleAvatar
- Expanded
- TextButton et TextButton.icon, TextButton.styleFrom
- ElevatedButton
- SizedBox
- FutureBuilder

### Fonctionnalités natives

- Appareil photo avec `package:image_picker`
- Localisation avec `package:location`

### Dart Syntax, stdlib et packages

- fichiers avec `dart:io`
- manipulation de chemins avec `package:paths`
- chemins pré-configurés avec `package:path_provider`
- SQLite avec `package:sqflite`
- Utilisation de Google Maps avec `package:google_maps_flutter` et le widget `GoogleMap`

### State management

- Consumer / Provider
- ChangeNotifier et `notifyListeners()`
- Passage de données via `ModalRoute.of().settings.arguments`
- Usage de SQLite pour la persistence

### Google Maps Platform

- Static Map API et génération d'image Maps
- Geocoding API et recherche inversée d'adresse