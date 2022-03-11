import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp() extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return new MaterialApp(
    title: "Flutter Demo",
    theme: new ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: new MyHomePage(),
    );
  }
}

class Car {
  String _make;
  String _model;
  String _imageSrc;

  Car(this._make, this._model, this._imageSrc);

  operator ==(other) =>
  (other is Car) && (_make == other._make) && (_model == other._model);

  int get hashCode => _make.hashCode ^ _model.hashCode ^ _imageSrc.hashCode;
  }

class MyHomePage extends StatefulWidget {
  @override 
  _HomePageState createState() => _HomePageState("Cars");

}

class _HomePageState extends State<MyHomePage> {

  String _title;
  List<Car> _cars;
}