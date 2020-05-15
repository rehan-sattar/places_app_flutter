import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../screens/map_screen.dart';
import '../helpers/location_helper.dart';

class PlaceInputField extends StatefulWidget {
  PlaceInputField({Key key}) : super(key: key);

  @override
  _PlaceInputFieldState createState() => _PlaceInputFieldState();
}

class _PlaceInputFieldState extends State<PlaceInputField> {
  String _previewImageUrl;

  void _getAndShowCurrentLocation() async {
    final locData = await Location().getLocation();
    var previewUrl = LocationHelper.generateLocationPreviewImage(
      latitude: locData.latitude,
      longitude: locData.longitude,
    );
    setState(() {
      _previewImageUrl = previewUrl;
    });
  }

  Future<void> _selectLocationOnMap() async {
    final selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapsScreen(
          isSelecting: false,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 200,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
          ),
          child: _previewImageUrl == null
              ? Text(
                  'No location choosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.location_on),
              label: Text('Current Location'),
              onPressed: _getAndShowCurrentLocation,
              textColor: Theme.of(context).primaryColor,
            ),
            FlatButton.icon(
              icon: Icon(Icons.map),
              label: Text('Select on Map'),
              onPressed: _selectLocationOnMap,
              textColor: Theme.of(context).primaryColor,
            )
          ],
        )
      ],
    );
  }
}
