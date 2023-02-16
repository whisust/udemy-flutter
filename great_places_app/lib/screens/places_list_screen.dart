import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './add_place_screen.dart';
import '../providers/user_places.dart';

class PlacesListScreen extends StatelessWidget {
  static const routeName = '/places';

  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Places'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: FutureBuilder(
          future: Provider.of<GreatPlaces>(context, listen: false).fetchPlaces(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Consumer<GreatPlaces>(
                  child: Center(child: Text('No places yet, start by adding some')),
                  builder: (ctx, greatPlaces, child) {
                    final places = greatPlaces.items;
                    return places.isEmpty
                        ? child!
                        : ListView.builder(
                            itemCount: places.length,
                            itemBuilder: (ctx, i) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage: FileImage(places[i].image),
                              ),
                              title: Text(places[i].title),
                              onTap: () {
                                // todo go to details page
                              },
                            ),
                          );
                  });
            }
          },
        ));
  }
}
