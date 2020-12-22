import 'package:ace_of_spades/utils/config.helper.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: loadConfigFile(),
          builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
            print(snapshot.toString());
            if (snapshot.hasData) {
              return MapboxMap(
                accessToken: snapshot.data['mapbox_api_token'],
                initialCameraPosition: CameraPosition(
                  target: LatLng(45.45, 45.45),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
