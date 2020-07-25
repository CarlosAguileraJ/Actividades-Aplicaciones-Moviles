import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class Distancia extends StatelessWidget {
  GoogleMapController mapController;

  //posicion debe llamarse igual al key que pasé como parámetro
  final Position posicion;

  Distancia({Key key, @required this.posicion}) : super(key: key);

  void _onMapCreated(GoogleMapController controller) {
    //Guarda los datos de la Api de Google Maps
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Mapas'),
          backgroundColor: Colors.teal,
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: LatLng(posicion.latitude,posicion.longitude),
            zoom: 15.0,
          ),
        ),
      ),
    );
  }
}