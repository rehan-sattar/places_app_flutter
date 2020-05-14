import 'dart:io';
import 'package:flutter/foundation.dart';

class PlaceLocation {
  final double longtitude;
  final double latitude;
  final String address;

  PlaceLocation({
    @required this.longtitude,
    @required this.latitude,
    this.address,
  });
}

class Place {
  final String id;
  final String title;
  final File image;
  final PlaceLocation location;

  Place({
    @required this.id,
    @required this.title,
    @required this.image,
    @required this.location,
  });
}
