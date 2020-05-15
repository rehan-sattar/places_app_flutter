import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/places_provider.dart';
import './place_details_screen.dart';
import './add_places_screen.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Places'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlacesScreen.routeName);
            },
          )
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: Provider.of<PlacesProvider>(
            context,
            listen: false,
          ).getAndSetPlaces(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Consumer<PlacesProvider>(
              child: Center(child: Text('No items. Try adding some!')),
              builder: (ctx, placesData, ch) {
                return placesData.items.length <= 0
                    ? ch
                    : ListView.builder(
                        itemBuilder: (ctx, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: FileImage(
                                placesData.items[index].image,
                              ),
                            ),
                            title: Text(placesData.items[index].title),
                            subtitle: Text(
                              placesData.items[index].location.address,
                            ),
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                PlaceDetailsScreen.routeName,
                                arguments: placesData.items[index].id,
                              );
                            },
                          );
                        },
                        itemCount: placesData.items.length,
                      );
              },
            );
          },
        ),
      ),
    );
  }
}
