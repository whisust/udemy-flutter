# Shop App

Application E-Commerce

## Sujets abordés

### State management
- ChangeNotifier
- Provider
- MultiProvider
- Consumer
- Difference entre Stateful widgets et Provider
- Stateful widget
- ChangeNotifierProxyProvider

### UI
- GridView
- ListView + Expanded
- Spacer
- Chip
- PopupMenuButton + Item
- Drawer
- Card
- ListTile
- `showDialog` + AlertDialog
- Center + CircularProgressIndicator
- TextButton.disable si la fonction handler est `null`
- FutureBuilder pour des widgets à rendement dynamique selon une future 
- Transform avec Matrix4 + rotate
- LinearGradient
- Box + BoxDecoration + BoxShadow
- Flexible

### Animation
- AnimationController -> controller.forward() / .reverse()
- Animation<T>
- Tween
- CurvedAnimation / Curves.*
- AnimatedBuilder / AnimatedContainer
- SlideTransition
- FadeTransition
- Hero transition
- Slivers pour la gestion de multiple zones scrollables (SliverAppBar + SliverList)
- FadeInImage pour les placeholders
- Custom Route.buildTransitions
- Custom PageTransitionBuilder
- PageTransitionsTheme

### User Input
- Form / FormTextField
- FocusNode
- TextEditingController
- GlobalKey

### Retour utilisateur
- Modale de confirmation
- Snackbar

### Dart Syntax, stdlib, packages
- imports avec conflits de nommage
- Future / then / catchError
- catchError retourne `Future<Null>`, et non pas `Future<void>`
- async / await pour complémenter les future.then.catch
- Notation .. pour accéder à une méthode et retourner l'objet courant au passage
- Timer dans le package async
- `shared_preferences` package pour du local storage KV Store


### Network & Backend
- Firebase
- Realtime database coté firebase + POST `table.json` pour créer une table
- module `http` et `dart:convert` + `json.encode` pour la sérialisation
- PATCH & DELETE coté Firebase
- `http` module: une non-200 réponse ne génère une erreur que pour du GET et POST

### Comportement Flutter
- passage d'information et initialisation de widget depuis `didChangeDependencies` plutôt que `initState`
- Destruction du `context` lors d'utilisation avec await -> il faut pin le context à une closure supérieure
- assets dans `pubspec.yaml`
- AssetImage + NetworkImage

### Firebase
- DB Rules
- Authentication avec la clef d'API
- Authentication utilisateur dans l'UI et dans les appels
- Login / Logout
- Filtrage des donnés via le query param 'orderBy'