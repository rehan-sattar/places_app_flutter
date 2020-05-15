import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/place.dart';
import '../widgets/image_input_field.dart';
import '../providers/places_provider.dart';
import '../widgets/location_input_field.dart';

class AddPlacesScreen extends StatefulWidget {
  AddPlacesScreen({Key key}) : super(key: key);
  static const routeName = '/add-places';
  @override
  _AddPlacesScreenState createState() => _AddPlacesScreenState();
}

class _AddPlacesScreenState extends State<AddPlacesScreen> {
  final _titleController = TextEditingController();
  File _pickedImage;
  PlaceLocation _pickedPlace;

  void _selectImage(File pickedImageFile) {
    _pickedImage = pickedImageFile;
  }

  void _savePlace() {
    if (_titleController.text.isEmpty ||
        _pickedImage == null ||
        _pickedPlace == null) {
      return;
    }
    Provider.of<PlacesProvider>(context, listen: false).addPlace(
      _titleController.text,
      _pickedImage,
      _pickedPlace,
    );
    Navigator.of(context).pop();
  }

  void _selectPlace(double lat, double long) {
    _pickedPlace = PlaceLocation(latitude: lat, longtitude: long);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text('Add Place')),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(labelText: 'Title'),
                        controller: _titleController,
                      ),
                      SizedBox(height: 10.0),
                      Container(),
                      ImageInputField(_selectImage),
                      SizedBox(height: 10.0),
                      PlaceInputField(_selectPlace),
                    ],
                  ),
                ),
              ),
            ),
            RaisedButton.icon(
              icon: Icon(Icons.add),
              label: Text('Add Place'),
              elevation: 0,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              color: Theme.of(context).accentColor,
              onPressed: _savePlace,
            )
          ],
        ),
      ),
    );
  }
}
