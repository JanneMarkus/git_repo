import 'package:flutter/material.dart';

// Set default values for initial run
var count = 0;
var name = "Janne";
var makes = 0;
var stackSize = 5;
var distance = 15;
var shotType = 1;
var stance = '';
var goal = 100;
var date = "";
var green = const Color.fromRGBO(152, 190, 100, 1);
var backgroundColor = Colors.transparent;
var startTab = 1;
var table = [];

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();
