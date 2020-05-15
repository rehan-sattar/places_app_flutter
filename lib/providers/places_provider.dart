import 'dart:io';

import 'package:flutter/foundation.dart';

import '../models/place.dart';
import '../helpers/db_helper.dart';

class PlacesProvider with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String pickedTitle, File pickedImage) {
    final newPlace = new Place(
      id: DateTime.now().toString(),
      title: pickedTitle,
      image: pickedImage,
      location: null,
    );
    _items.add(newPlace);
    notifyListeners();
    DbHelper.insert('places', {
      'id': DateTime.now().toString(),
      'title': newPlace.title,
      'image': newPlace.image.path,
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
          location: null,
        );
      },
    ).toList();
    notifyListeners();
  }
}
