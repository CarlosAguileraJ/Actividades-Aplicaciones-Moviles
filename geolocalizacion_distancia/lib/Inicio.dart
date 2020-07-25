import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'Distancia.dart';



class Inicio extends StatefulWidget {
  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {

  final Geolocator geolocator = Geolocator()
    ..forceAndroidLocationManager;
  Position _currentPosition;

  String _currentAddress;

  String _AddressDes;
  // distancias en metro km
  double _distanciaEnMetros, _distanciakm;
  // asignamos longitud y latitud del destino
  double _latitud= 20.6737883, _logitud=-103.3704326 ; // modificar aqui las coordenadas del destino

  //= 20.6737883,-103.3704326;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ubicación"),
      ),
      //backgroundColor: Colors.lightBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            //Si el objeto que contiene las coordenadas no es nulo, muestra la ubicación
            if (_currentPosition != null)
            //Text("LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}"),
              Text("\n \n \nSu dirección es: $_currentAddress", style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.teal), ),
            if (_AddressDes != null)
              Text("\n \nLatitud de destino: $_latitud ",style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.teal),),
            if (_AddressDes != null)
              Text("\nLongitud de destino: $_logitud ", style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.teal),),
            if (_AddressDes != null)
              Text("\n \nDirección destino: $_AddressDes ", style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.teal),),
            if (_distanciakm != null)
              Text("\n  \t \t Distancia al destino:  $_distanciakm"+" Km  ", style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.teal),),

            Text("\n\n"),

            // boton obtener ubicacion
            RaisedButton(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Color(0xFF00796B),
                      Color(0xFF009688),
                      Color(0xFF80CBC4),
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(21.7),
                child: const Text(
                  'Ubicación actual',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              onPressed: () {
                _getCurrentLocation();
              },

            ),

            // boton obtener destino
            RaisedButton(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Color(0xFF00796B),
                      Color(0xFF009688),
                      Color(0xFF80CBC4),
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(25.0),
                child: const Text(
                    'Obtener destino',
                    style: TextStyle(fontSize: 20)
                ),
              ),
              onPressed: () {
                _ubicacionDestino();
              },
            ),

            // boton obtener distancia
            RaisedButton(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Color(0xFF00796B),
                      Color(0xFF009688),
                      Color(0xFF80CBC4),
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(17.0),
                child: const Text(
                    'Obtener distancia',
                    style: TextStyle(fontSize: 20)
                ),
              ),
              onPressed: () {
                _getCurrentLocation();
                _obtenerDistancia();
                _obtenerDistancia();
                _distanciakm = _distanciaEnMetros/1000;
              },
            ),

            // boton mostrar mapa
            RaisedButton(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Color(0xFF00796B),
                      Color(0xFF009688),
                      Color(0xFF80CBC4),
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(42.0),
                child: const Text(
                    'Abrir mapas',
                    style: TextStyle(fontSize: 20)
                ),
              ),
              onPressed: () {
                //Abro pantalla pasando como parámetro el objeto Position
                Navigator.push(context, MaterialPageRoute(builder: (context) => Distancia(posicion: _currentPosition,)));
              },
            ),
          ],
        ),
      ),
    );
  }

  _getCurrentLocation() {
    //final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    //En caso de éxito, actualizamos el estado y en caso de error, mostramos mensaje
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
      //Convertimos cooordenadas a dirección
      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    //_currentPosition es un objeto de tipo Position y de aquí sacamos las coordenadas
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);
      Placemark place = p[0];
      setState(() {
        _currentAddress = "${place.locality},${place.administrativeArea},${place.postalCode},${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  _obtenerDistancia() async {
    _distanciaEnMetros = await geolocator.distanceBetween(
        _currentPosition.latitude, _currentPosition.longitude, _latitud,
        _logitud);
  }

  _ubicacionDestino() async {
    try {
      List<Placemark> d = await geolocator.placemarkFromCoordinates(_latitud, _logitud);
      Placemark place = d[0];
      setState(() {
        _AddressDes = "${place.locality}, ${place.administrativeArea},${place.postalCode}, ${place.country}";
      });
    }
    catch (e) {
      print(e);
    }
  }
}

