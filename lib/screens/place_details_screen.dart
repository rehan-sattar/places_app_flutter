import 'package:flutter/material.dart';
import 'package:places_app/screens/map_screen.dart';
import 'package:provider/provider.dart';

import '../providers/places_provider.dart';

class PlaceDetailsScreen extends StatelessWidget {
  static const routeName = '/places-deails';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final place = Provider.of<PlacesProvider>(context, listen: false).getById(
      id,
    );
    return Scaffold(
      appBar: AppBar(title: Text(place.title)),
      body: Column(
        children: <Widget>[
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              place.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              place.location.address,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          FlatButton.icon(
            icon: Icon(Icons.chevron_right),
            label: Text(
              'View on Map',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => MapsScreen(
                    initialLocation: place.location,
                    isSelecting: false,
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
