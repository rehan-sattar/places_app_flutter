import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:places_app/helpers/location_helper.dart';

import '../models/place.dart';
import '../helpers/db_helper.dart';

class PlacesProvider with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Future<void> addPlace(
    String pickedTitle,
    File pickedImage,
    PlaceLocation pickedLocation,
  ) async {
    final address = await LocationHelper.getLocationAddres(
      pickedLocation.latitude,
      pickedLocation.longtitude,
    );

    final location = PlaceLocation(
      latitude: pickedLocation.latitude,
      longtitude: pickedLocation.longtitude,
      address: address,
    );
    final newPlace = new Place(
      id: DateTime.now().toString(),
      title: pickedTitle,
      image: pickedImage,
      location: location,
    );
    _items.add(newPlace);
    notifyListeners();
    DbHelper.insert('places', {
      'id': DateTime.now().toString(),
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_long': newPlace.location.longtitude,
      'address': newPlace.location.address,
    });
  }

  Future<void> getAndSetPlaces() async {
    final data = await DbHelper.getData('places');
    _items = data.map(
      (item) {
        return Place(
          id: item['id'],
          title: item['title'],
          // since the item['image'] contains the path, we are creating the image using File.
          image: File(item['image']),
          location: PlaceLocation(
            latitude: item['loc_lat'],
            longtitude: item['loc_long'],
            address: item['address'],
          ),
        );
      },
    ).toList();
    notifyListeners();
  }
}
