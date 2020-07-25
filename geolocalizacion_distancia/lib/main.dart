import 'package:flutter/material.dart';
import 'Inicio.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo geolocalización',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Inicio(),
    );
  }
}

