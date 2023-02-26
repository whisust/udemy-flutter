# Chat App

Une application de chat en temps réel pour plonger plus loin dans l'implémentation avec Firebase.

## Setup

Ajouter les clefs d'api dans `lib/firebase_options.dart`

## Sujets abordés

### UI
- Theme de l'app avec `ColorScheme` et `*ButtonThemeData`
- StreamBuilder
- ScaffoldMessenger et SnackBar
- Dropdown
  - DropdownButton
  - DropdownMenuItem
- FloatingActionButton
- TextFormField + InputDecoration
- Expanded pour ajuster automatiquement la place prise par un widget
- MainAxisAlignement / CrossAxisAlignement
- CircleAvatar
- Stack + `clipBehavior`
- Positioned

### State Management
- State local avec le widget Form / TextFormField
- TextEditingController pour controller un champ texte

### Dart

### Flutter

### Packages externes
- `package:firebase_core` requis pour Firebase
- `package:cloud_firestore` requis pour s'interfacer avec Firestore
- `package:firebase_auth` pour gérer l'authentification avec Firebase et la gestion du state dans l'app
- `package:firebase_storage` pour la conection avec firebae Storage et les manipulation de fichiers
- `package:image_picker` pour selectionner une image du tel ou en prendre une avec l'appareil

### Firebase
- Initialisation dans le `main()` avec
```dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // runApp ...
}
```
- FirebaseAuth
  - register / sign in / sign out
  - `.authStateChanges()`
- FirebaseFirestore
  - `.collection()` / `.collection(...).doc()` / `collection().orderBy()`
  - `.snapshots()` pour avoir le stream des mises à jour
- Setup d'une db Firestore, collections + documents
- Règles d'accès avec le DSL
- FirebaseStorage 
  - `.ref()` / `.child()` pour obtenir une réference
  - `.putFile()` pour stocker un fichier / `.whenComplete()`
  - `.getDownloadURL()` pour récupérer l'url de DL