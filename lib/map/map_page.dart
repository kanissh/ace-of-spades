import 'package:ace_of_spades/api/repositories/api.repository.dart';
import 'package:ace_of_spades/utils/config.helper.dart';
import 'package:ace_of_spades/utils/location.helper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final repository = ApiRepository.instance;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: FaIcon(FontAwesomeIcons.search),
          onPressed: () {},
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
        body: FutureBuilder(
          future: loadConfigFile(),
          builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (snapshot.hasData) {
              return MapboxMap(
                styleString: snapshot.data['mapbox_style_string'].toString(),
                // cameraTargetBounds: CameraTargetBounds(),
                accessToken: snapshot.data['mapbox_api_token'],
                initialCameraPosition: CameraPosition(
                  target: LatLng(45.45, 45.45),
                ),
                onMapCreated: (MapboxMapController mapController) async {
                  final _location = await getCurrentLocation();
                  final animateCameraResult = await mapController.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(target: _location, zoom: 15),
                    ),
                  );

                  print(animateCameraResult);

                  if (animateCameraResult) {
                    mapController.addCircle(
                      CircleOptions(
                        circleRadius: 10,
                        circleColor: '#000000',
                        geometry: _location,
                      ),
                    );
                  }
                },
                onMapClick: (point, coordinates) async {
                  final result = await repository.performGeocoding(coordinates.latitude, coordinates.longitude);
                  Scaffold.of(context).showBottomSheet((context) {
                    return Wrap(children: [Text(result.toString())]);
                  });
                },
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
