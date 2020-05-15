import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:places_app/models/place.dart';

class MapsScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;
  MapsScreen({
    this.initialLocation = const PlaceLocation(
      longtitude: -122.084,
      latitude: 37.422,
    ),
    this.isSelecting = false,
  });
  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  LatLng _selectedPosition;

  void _selectLocation(LatLng position) {
    setState(() {
      _selectedPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Map'),
        actions: <Widget>[
          if (widget.isSelecting)
            IconButton(
              icon: Icon(Icons.check),
              onPressed: _selectedPosition == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_selectedPosition);
                    },
            )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longtitude,
          ),
          zoom: 16,
        ),
        onTap: _selectLocation,
        markers: _selectedPosition == null
            ? null
            : {Marker(markerId: MarkerId('v1'), position: _selectedPosition)},
      ),
    );
  }
}
