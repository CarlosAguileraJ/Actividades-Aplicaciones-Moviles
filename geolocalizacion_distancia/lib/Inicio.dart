import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  double _latitud , _logitud ; // modificar aqui las coordenadas del destino
  String inputstr = "";
  String inputstr2 = "";
  //= 20.6737883,-103.3704326;

  final myController = TextEditingController();
  final myController2 = TextEditingController();

  //= 20.6737883,-103.3704326;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ubicación"),
      ),
      //backgroundColor: Colors.lightBlue,
      body: SingleChildScrollView(
        child: Center(
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
            Text("\n  \t Ingresar coordenadas completas", style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic, color: Colors.teal),),
             TextField(
               style: TextStyle(color: Colors.teal),
               autofocus: true,
                cursorColor: Colors.teal,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.numberWithOptions(signed: true,decimal: true),
                decoration:  InputDecoration(
                border: OutlineInputBorder(),
                  labelText: '  Ingresar Latitud de destino',
              ),
              onChanged: (String textinput) {
                setState(() {
                  inputstr = textinput;
                  _latitud=double.tryParse(inputstr);
                });
              },
              controller: myController,
            ),
            Text("\n"),



            new TextField(
              autofocus: true,
              cursorColor: Colors.teal,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.teal),
              keyboardType: TextInputType.numberWithOptions(signed: true,decimal: true),
              decoration: new InputDecoration(
                  border: OutlineInputBorder(),
                    labelText: '  Ingresar Longitud de destino'
              ),
              onChanged: (String textinput2) {
                setState(() {
                  inputstr2 = textinput2;
                  _logitud= double.tryParse(inputstr2);
                });
              },
              controller: myController2,
            ),
            Text("\n"),

            // boton obtener ubicacion
            RaisedButton(
              textColor: Colors.white,
              padding: const EdgeInsets.all(0.0),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Color(0xFF2962FF),
                      Color(0xFF2979FF),
                      Color(0xFF2196F3),
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(21.7),
                child: const Text(
                  'Ingresar Coordenadas',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              onPressed: () {
                return showDialog(

                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      // Recupera el texto que el usuario ha digitado utilizando nuestro
                      // TextEditingController
                      content: Text("Coordenadas Ingresadas: "+"\n\nLatitud:"+ myController.text+"\nLongitud: "+myController2.text,
                      style: TextStyle(fontSize: 20),
                      ),
                      contentTextStyle: TextStyle(color: Colors.teal),
                    );
                  },
                );
              },

            ),
            Text("\n\n"),

            // boton obtener destino
            RaisedButton(
              textColor: Colors.white,
              padding: const EdgeInsets.all(0.0),
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
                padding: const EdgeInsets.all(14.0),
                child: const Text(
                    'Obtener ubicaciones',
                    style: TextStyle(fontSize: 20)
                ),
              ),
              onPressed: () {
                _convertir();
                _getCurrentLocation();
                _ubicacionDestino();

              },
            ),
            Text("\n"),

            // boton obtener distancia
            RaisedButton(
              textColor: Colors.white,
              padding: const EdgeInsets.all(0.0),
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
                padding: const EdgeInsets.all(27.0),
                child: const Text(
                    'Obtener distancia',
                    style: TextStyle(fontSize: 20)
                ),
              ),
              onPressed: () {
                _getCurrentLocation();
                _obtenerDistancia();
                _ubicacionDestino();
                _distanciakm = _distanciaEnMetros/1000;
              },
            ),
            Text("\n"),

            // boton mostrar mapa
            RaisedButton(
              textColor: Colors.white,
              padding: const EdgeInsets.all(0.0),
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
                padding: const EdgeInsets.all(43.5),
                child: const Text(
                    'Mostrar mapa',
                    style: TextStyle(fontSize: 20)
                ),
              ),
              onPressed: () {
                _getCurrentLocation();
                //Abro pantalla pasando como parámetro el objeto Position
                Navigator.push(context, MaterialPageRoute(builder: (context) => Distancia(posicion: _currentPosition,)));
              },
            ),

            Text("\n"),

          ],
        ),
      ),
    )
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
    _ubicacionDestino();
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
  _convertir()async{
    try {
      String x = myController.toString();
      String y = myController2.toString();
      setState(() {
        _logitud = double.parse(y);
        _latitud = double.parse(x);
      });
    }catch(e){
      print(e);
    }
  }
}


