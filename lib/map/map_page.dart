import 'dart:collection';

import 'package:ace_of_spades/api/repositories/api.repository.dart';
import 'package:ace_of_spades/utils/config.helper.dart';
import 'package:ace_of_spades/utils/location.helper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:googleapis/doubleclickbidmanager/v1_1.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:mapbox_search_flutter/mapbox_search_flutter.dart';

import '../constants.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final repository = ApiRepository.instance;
  MapboxMapController mapController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: loadConfigFile(),
          builder: (BuildContext context,
              AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (snapshot.hasData) {
              return Stack(
                alignment: Alignment.bottomRight,
                children: [
                  MapboxMap(
                    cameraTargetBounds: CameraTargetBounds(
                      LatLngBounds(
                        southwest: LatLng(7.239157512248738, 80.58135242077032),
                        northeast: LatLng(7.279977791172868, 80.61140926621937),
                      ),
                    ),
                    styleString:
                        snapshot.data['mapbox_style_string'].toString(),
                    accessToken: snapshot.data['mapbox_api_token'],
                    initialCameraPosition: CameraPosition(
                      target: LatLng(45.45, 45.45),
                    ),
                    onMapCreated: (mapController) async {
                      await mapController.animateCamera(
                        CameraUpdate.newLatLngBounds(
                          LatLngBounds(
                            southwest:
                                LatLng(7.239157512248738, 80.58135242077032),
                            northeast:
                                LatLng(7.279977791172868, 80.61140926621937),
                          ),
                        ),
                      );

                      final _location =
                          LatLng(7.254212510590577, 80.5967939152037);
                      //FIXME: Remove comment, commented to temporarily disabled get location
                      //await getCurrentLocation();

                      final LatLng _defaultLocation =
                          LatLng(7.254212510590577, 80.5967939152037);
                      bool animateCameraResult;

                      if (_location == null) {
                        animateCameraResult = await mapController.animateCamera(
                          CameraUpdate.newCameraPosition(
                            CameraPosition(target: _defaultLocation, zoom: 13),
                          ),
                        );

                        if (animateCameraResult) {
                          mapController.addCircle(
                            CircleOptions(
                              circleRadius: 10,
                              circleColor: '#000000',
                              geometry: _defaultLocation,
                            ),
                          );
                        }
                      } else {
                        animateCameraResult = await mapController.animateCamera(
                          CameraUpdate.newCameraPosition(
                            CameraPosition(target: _location, zoom: 12),
                          ),
                        );
                        if (animateCameraResult) {
                          mapController.addCircle(
                            CircleOptions(
                              circleRadius: 10,
                              circleColor: '#000000',
                              geometry: _location,
                            ),
                          );
                        }
                      }
                    },
                    onMapClick: (point, coordinates) async {
                      final result = await repository.performReverseGeocoding(
                          coordinates.latitude, coordinates.longitude);
                      print(result.toString());
                      Scaffold.of(context).showBottomSheet((context) {
                        return Wrap(children: [Text(result.toString())]);
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FloatingActionButton(
                          backgroundColor: redColor,
                          mini: true,
                          child: Icon(Icons.search),
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
                        SizedBox(
                          height: 10,
                        ),
                        FloatingActionButton(
                          backgroundColor: redColor,
                          mini: true,
                          child: Icon(Icons.my_location),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  MapBoxPlaceSearchWidget(
                      onSelected: (place) {},
                      popOnSelect: true,
                      context: context,
                      apiKey: snapshot.data['mapbox_api_token'].toString()),
                ],
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
