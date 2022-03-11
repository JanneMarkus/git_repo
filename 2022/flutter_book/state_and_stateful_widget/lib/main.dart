// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class Car {
  final String _make;
  final String _model;
  final String _imageSrc;
  Car(this._make, this._model, this._imageSrc);
  operator ==(other) =>
      (other is Car) && (_make == other._make) && (_model == other._model);
  @override
  int get hashCode => _make.hashCode ^ _model.hashCode ^ _imageSrc.hashCode;
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _HomePageState createState() => _HomePageState("Cars");
}

class _HomePageState extends State<MyHomePage> {
  final String _title;
  List<Car> _cars;
  _HomePageState(this._title) {
    _cars = [
      Car("Bmw", "M3",
          "Https://media.ed.edmundsmedia.com/bmw/m3/2018/oem/2018_bmw_m3_sedan_base_fq_oem_4_150.jpg"),
      Car(
        "Nissan",
        "GTR",
        "Https://media.ed.edmunds-media.com/nissan/gtr/2018/oem/2018_nissan_gt-r_coupe_nismo_fq_oem_1_150.jpg",
      ),
      Car(
        "Nissan",
        "Sentra",
        "Https://media.ed.edmundsmedia.com/nissan/sentra/2017/oem/2017_nissan_sentra_sedan_srturbo_fq_oem_4_150.jpg",
      )
    ];
  }
  @override
  Widget build(BuildContext context) {
    List<CarWidget> carWidgets = _cars.map((Car car) {
      return CarWidget(car);
    }).toList();
    return Scaffold(
        appBar: AppBar(
          title: Text(_title),
        ),
        body: ListView(children: carWidgets));
  }
}

class CarWidget extends StatelessWidget {
  const CarWidget(this._car) : super();
  final Car _car;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
            decoration: BoxDecoration(border: Border.all()),
            padding: const EdgeInsets.all(20.0),
            child: Center(
                child: Column(children: <Widget>[
              Text('${_car._make} ${_car._model}',
                  style: const TextStyle(fontSize: 24.0)),
              Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Image.network(_car._imageSrc))
            ]))));
  }
}
