import 'package:ace_of_spades/api/repositories/api.repository.dart';
import 'package:ace_of_spades/utils/config.helper.dart';
import 'package:ace_of_spades/utils/location.helper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:googleapis/doubleclickbidmanager/v1_1.dart';
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
          onPressed: () {
            showDialog(
              context: context,
              child: Dialog(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(),
                      RaisedButton(
                        onPressed: () {},
                        child: Text('Search'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
        body: FutureBuilder(
          future: loadConfigFile(),
          builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (snapshot.hasData) {
              return MapboxMap(
                cameraTargetBounds: CameraTargetBounds(
                  LatLngBounds(
                    southwest: LatLng(7.239157512248738, 80.58135242077032),
                    northeast: LatLng(7.279977791172868, 80.61140926621937),
                  ),
                ),
                styleString: snapshot.data['mapbox_style_string'].toString(),
                accessToken: snapshot.data['mapbox_api_token'],
                initialCameraPosition: CameraPosition(
                  target: LatLng(45.45, 45.45),
                ),
                onMapCreated: (MapboxMapController mapController) async {
                  await mapController.animateCamera(
                    CameraUpdate.newLatLngBounds(
                      LatLngBounds(
                        southwest: LatLng(7.239157512248738, 80.58135242077032),
                        northeast: LatLng(7.279977791172868, 80.61140926621937),
                      ),
                    ),
                  );

                  // final _location = await getCurrentLocation();
                  // final animateCameraResult = await mapController.animateCamera(
                  //   CameraUpdate.newCameraPosition(
                  //     CameraPosition(target: _location, zoom: 15),
                  //   ),
                  // );

                  // print(animateCameraResult);

                  // if (animateCameraResult) {
                  //   mapController.addCircle(
                  //     CircleOptions(
                  //       circleRadius: 10,
                  //       circleColor: '#000000',
                  //       geometry: _location,
                  //     ),
                  //   );
                  // }

                  /* final animateCameraResult = await mapController.animateCamera(
                    CameraUpdate.newLatLngBounds(
                      LatLngBounds(
                        southwest: LatLng(80.57513609064677, 7.23794270873293),
                        northeast: LatLng(80.61080833461193, 7.279563382697944),
                      ),
                    ),
                  );

                  final animateCameraResult2 = await mapController.animateCamera(
                    CameraUpdate.zoomTo(15),
                  ); */
                },
                onMapClick: (point, coordinates) async {
                  final result = await repository.performReverseGeocoding(coordinates.latitude, coordinates.longitude);
                  print(result.toString());
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
