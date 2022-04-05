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
  const CheckItemWidget({Key? key, required this.text, required this.index})
      : super(key: key);
  final String text;
  final int index;
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
          leading: Text('${widget.index + 1}.'),
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
          leading: Text('${widget.index + 1}.'),
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

class GroupHeading extends StatelessWidget {
  const GroupHeading({Key? key, required this.title, required this.description})
      : super(key: key);
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              textScaleFactor: 1.2,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          )),
      Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            description,
          ),
        ),
      )
    ]);
  }
}

class Checklist extends StatefulWidget {
  List checkItems = [
    // group 0
    '900 MHz telemetry antenna (front)',
    'Cellular antenna (rear)',
    // group 1
    'Jump start cable is plugged in for charging avionics battery',
    // group 2
    'Ensure that all bolts are secure',
    'Check for any loose, disconnected, or damaged components',
    'Check all connectors on battery back plane for cracks or bent terminals',
    'Check all wiring to ensure proper connections (Do not pull on any wires)',
    // group 3
    'Both front and rear landing gear are not twisted',
    'The landing gear is properly secured to the airframe',
    'Visually inspect landing gear for any cracks',
    'Overall inspection for any damaged components',
    // group 4
    'All propellers are undamaged and clean',
    'The T-Motor logo is always facing up',
    'All propellers are 22x6.6 (Sparrow) or 28x9.2 (Robin)',
    'All propellers are correct as shown in Figure 1',
    'All propeller bolt alignment marks have not moved',
    // group 5
    'All motor arms(A-D) are plugged into the correct connector as shown in Figure 1',
    'All boom LED strips and wires are secure',
    'All 8 arm wingnuts are tightly secured with the longer screws at the top and the shorter screws at the bottom',
    // group 6
    'Cowling/Landing Gear',
    // group 7
    'Open payload door and visually inspect that the payload drop doors are closed and leveled.'
  ];

  List checkGroups = [
    {
      'title': 'Antenna',
      'description':
          'Ensure all power is disconnected from the RPA and check the following:'
    },
    {
      'title': 'Battery',
      'description': 'Ensure avionics battery is connected:'
    },
    {
      'title': 'Airframe',
      'description': 'Examine entire airframe and cowling:'
    },
    {
      'title': 'Landing Gear',
      'description': 'Examine the landing gear and verify:'
    },
    {
      'title': 'Propellers',
      'description': 'Examine the propellers and verify that:'
    },
    {
      'title': 'Motor Arm',
      'description': 'Plug in all 4 motor arms then verify:'
    },
    {'title': 'Wipe-Down', 'description': 'Cleaning:'},
    {
      'title': 'Payload Drop',
      'description': 'Perform if RPA features a payload drop mechanism:'
    }
    // {
    //   'title': 'Motor Arm Connector + interior Check',
    //   'description':
    //       '*Only perform if Motor Arms need to be assembled (Do not remove Motor arms or Top Cowling to perform check)\nInspect the Motor Arm Connectors + Interior and verify that:'
    // },
  ];
  Checklist({Key? key}) : super(key: key);
  int groupIndex = 0;
  int groupItemIndex = 0;
  @override
  State<Checklist> createState() => _ChecklistState();
}

class _ChecklistState extends State<Checklist> {
  submitList() {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text("Uh oh!"),
              content: const Text(
                  "There are one or more items that failed the checks."),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context, "OK"),
                    child: const Text('OK'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text('Pre-flight Physical Checklist'), actions: [
        IconButton(
          onPressed: () => submitList(),
          icon: const Icon(Icons.send),
          tooltip: 'Submit the list and check for errors',
        )
      ]),
      body: ListView.builder(
          cacheExtent: 9999,
          itemBuilder: (context, int index) {
            if (index > widget.checkItems.length) {
              const Spacer(flex: 1000);
            }
            if (index == 0 ||
                index == 2 ||
                index == 3 ||
                index == 7 ||
                index == 11 ||
                index == 16 ||
                index == 19 ||
                index == 20) {
              widget.groupItemIndex = 0;
              widget.groupIndex++;
              if (widget.groupIndex <= widget.checkGroups.length) {
                widget.groupItemIndex++;
                return Column(children: [
                  const Divider(),
                  GroupHeading(
                    title: widget.groupIndex.toString() +
                        '. ' +
                        widget.checkGroups[widget.groupIndex - 1]['title'],
                    description: widget.checkGroups[widget.groupIndex - 1]
                        ['description'],
                  ),
                  CheckItemWidget(
                      text: widget.checkItems[index],
                      index: widget.groupItemIndex - 1)
                ]);
              }
            } else {
              widget.groupItemIndex++;
              return CheckItemWidget(
                  text: widget.checkItems[index],
                  index: widget.groupItemIndex - 1);
            }
            return const Text("Error");
          },
          itemCount: widget.checkItems.length),
    );
  }
}

// this video has the answers to what you want to do https://www.youtube.com/watch?v=l3KnuUmlr-w