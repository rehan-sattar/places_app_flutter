import 'package:flutter/material.dart';

class PlaceInputField extends StatefulWidget {
  PlaceInputField({Key key}) : super(key: key);

  @override
  _PlaceInputFieldState createState() => _PlaceInputFieldState();
}

class _PlaceInputFieldState extends State<PlaceInputField> {
  String _previewImageUrl;
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
              onPressed: () {},
              textColor: Theme.of(context).primaryColor,
            ),
            FlatButton.icon(
              icon: Icon(Icons.map),
              label: Text('Select on Map'),
              onPressed: () {},
              textColor: Theme.of(context).primaryColor,
            )
          ],
        )
      ],
    );
  }
}
