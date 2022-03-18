// Add grouping feature to the checklist items.
// Add number to each item. The number begins at 1 for the first item in a group
// Each group has a Title and a description.
// I can make a list of 10 items where each item is a group. Then each group item contains a list of the check that are in that group.
// Then I can display the groups as a list view, and in each item of the list view I can have the group number as the leading, the title, the description.
// I would display the group title and such on the init of the group, then I would return the list tiles on all remaining runs.

// I could also add metadata to each item in the checklist which tells which group it's in and which item it is.
// Then I just do separate listView widgets for each group.

// Add feature that opens the camera on selfie mode when you press the icon on the prop bolts checklist item.
// I could pass a "Special feature" field for each list item. The item that needs the camera to open could have the function for that, and the items that are followed by a different group could have the group header constructor passed in.
// fields with no special features just pass null.

import 'dart:io';
import 'package:flutter/material.dart';

main() {
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
  final String text;
  @override
  State<CheckItemWidget> createState() => _CheckItemWidgetState();
}

class _CheckItemWidgetState extends State<CheckItemWidget> {
  bool _isChecked = false;
  bool _hasPassed = false;

  @override
  Widget build(BuildContext context) {
    if (widget.text == 'All propeller bolt alignment marks have not moved') {
      return ListTile(
          title: Text(widget.text),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Tooltip(
                  message: 'Open front-facing camera',
                  child: IconButton(
                    onPressed: () => {},
                    icon: const Icon(Icons.camera_alt),
                  )),
              IconButton(
                  onPressed: () {
                    _isChecked == false
                        ? _isChecked = true
                        : _isChecked = false;
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
    } else {
      return ListTile(
          title: Text(widget.text),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: () {
                    _isChecked == false
                        ? _isChecked = true
                        : _isChecked = false;
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
}

class Checklist extends StatefulWidget {
  List checkItems = [
    '900 MHz telemetry antenna (front)',
    'Cellular antenna (rear)',
    'Jump start cable is plugged in for charging avionics battery',
    'Ensure that all bolts are secure',
    'Check for any loose, disconnected, or damaged components',
    'Check all connectors on battery back plane for cracks or bent terminals',
    'Check all wiring to ensure proper connections (Do not pull on any wires)',
    'Both front and rear landing gear are not twisted',
    'The landing gear is properly secured to the airframe',
    'Visually inspect landing gear for any cracks',
    'Overall inspection for any damaged components',
    'All propellers are undamaged and clean',
    'The T-Motor logo is always facing up',
    'All propellers are 22x6.6 (Sparrow) or 28x9.2 (Robin)',
    'All propellers are correct as shown in Figure 1',
    'All propeller bolt alignment marks have not moved',
    'All motor arms(A-D) are plugged into the correct connector as shown in Figure 1',
    'All boom LED strips and wires are secure',
    'All 8 arm wingnuts are tightly secured with the longer screws at the top and the shorter screws at the bottom',
    'Cowling/Landing Gear',
    'Open payload door and visually inspect that the payload drop doors are closed and leveled.'
  ];

  List checkGroups = [
    {
      'title': 'Antenna',
      'Description':
          'Ensure all power is disconnected from the RPA and check the following:'
    },
    {'title': 'Battery', 'Description': 'Ensure avionics batter is connected:'},
    {
      'title': 'Airframe',
      'Description': 'Examine entire airframe and cowling:'
    },
    {
      'title': 'Landing Gear',
      'Description': 'Examine the landing gear and verify:'
    },
    {
      'title': 'Propellers',
      'Description': 'Examine the propellers and verify that:'
    },
    {
      'title': 'Motor Arm Connector + interior Check',
      'Description':
          '*Only perform if Motor Arms need to be assembled (Do not remove Motor arms or Top Cowling to perform check)\nInspect the Motor Arm Connectors + Interior and verify that:'
    },
    {
      'title': 'Motor Arm',
      'Description': 'Plug in all 4 motor arms then verify:'
    },
    {'title': 'Wipe-Down', 'Description': 'Cleaning:'},
    {
      'title': 'Payload Drop',
      'Description': 'Perform if RPA features a payload drop mechanism:'
    }
  ];
  Checklist({Key? key}) : super(key: key);
  @override
  State<Checklist> createState() => _ChecklistState();
}

class _ChecklistState extends State<Checklist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pre-flight Physical Checklist')),
      body: ListView.builder(
        itemBuilder: (context, int index) =>
            CheckItemWidget(text: widget.checkItems[index]),
        itemCount: widget.checkItems.length,
      ),
    );
  }
}

// this video has the answers to what you want to do https://www.youtube.com/watch?v=l3KnuUmlr-w