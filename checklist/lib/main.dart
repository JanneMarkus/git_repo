// I need to make a listview that makes a list item for each question in a list of checklist items
// Make a list of checklist items
// Make a listview widget with a listview builder
// Make a list item widget that includes the checkbox for each item
// Add a toggle switch to each item.
// I need to have a checkbox nested in each list item that I can use to select when I've checked that Item
// I want to have a switch on each tile that allows me to toggle between fail and pass

import 'package:flutter/material.dart';

void main() {
  runApp(const ChecklistApp());
}

class ChecklistApp extends StatelessWidget {
  const ChecklistApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pre-Flight Physical Checklist',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Checklist(),
    );
  }
}

class CheckItemWidget extends StatefulWidget {
  const CheckItemWidget({Key? key, required this.text}) : super(key: key);
  final text;
  @override
  State<CheckItemWidget> createState() => _CheckItemWidgetState();
}

class _CheckItemWidgetState extends State<CheckItemWidget> {
  bool _isChecked = false;
  bool _hasPassed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            Flexible(
              child: Text('${widget.text}'),
            ),
            IconButton(
                onPressed: () {
                  _isChecked == false ? _isChecked = true : _isChecked = false;
                  setState(() {});
                },
                icon: _isChecked == false
                    ? const Icon(Icons.check_box_outline_blank)
                    : const Icon(Icons.check_box)),
            Switch(
                value: _hasPassed == false ? false : true,
                onChanged: (bool newValue) {
                  setState(() {
                    _hasPassed == false
                        ? _hasPassed = true
                        : _hasPassed = false;
                  });
                })
          ],
        ));
  }
}

class Checklist extends StatefulWidget {
  List checkItems = [
    'Check antenna',
    'check bolts',
    'props are clean and free of damage',
    'check connectors'
  ];
  Checklist({Key? key}) : super(key: key);
  @override
  State<Checklist> createState() => _ChecklistState();
}

class _ChecklistState extends State<Checklist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pre-flight Physical Checklist')),
      body: ListView.builder(
        itemBuilder: (context, int index) =>
            CheckItemWidget(text: widget.checkItems[index]),
        itemCount: widget.checkItems.length,
      ),
    );
  }
}

// this video has the answers to what you want to do https://www.youtube.com/watch?v=l3KnuUmlr-w