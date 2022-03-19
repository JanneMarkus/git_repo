import 'dart:async';
import 'package:flutter/material.dart';
import 'global.dart' as global;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'database_helper.dart';

// the rgb for the green I want (152,190,100)

void main() async {
  runApp(const MyApp());
}

//
// This is the code for writing to a txt file
//
// create the class that handles reading and writing to a local text file.
class DataStorage {
  // create a function that returns the path to where the file will be stored.
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    // return the path
    return directory.path;
  }

  // create a funtion that returns the path to the exact file.
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/puttingData.txt');
  }

  // create a function that reads the data. If the data cannot be read, return 0.
  Future<int> readData() async {
    // try to open and return the contents of the file
    try {
      final file = await _localFile;

      final contents = await file.readAsString();

      return int.parse(contents);
      // if the file cannot be read or parsed, return 0
    } catch (e) {
      return 0;
    }
  }

  // create a function that writes to the file
  // when calling the function, the user passes the integer they want to write.
  Future<File> writeData(int data) async {
    // wait for the file to open
    final file = await _localFile;
    // writes the passed in data as a string to the text document.
    return file.writeAsString('$data');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Putting App';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: _title,
        scaffoldMessengerKey: global.snackbarKey,
        home: MainAppWidget(storage: DataStorage()),
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.green,
        ));
  }
}

//
// This is where I set the main structure of the app.
// Add features to the app by putting them in the scaffold
//

class MainAppWidget extends StatelessWidget {
  const MainAppWidget({Key? key, required this.storage}) : super(key: key);

  final DataStorage storage;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: global.startTab,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Text('Setup'),
              ),
              Tab(
                icon: Text('Putt'),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Center(
              // This calls the Putting Setup page code
              child: PuttingSetup(),
            ),
            Center(
              // This is where the putting game code class will be called from
              child: PuttingCounter(),
            ),
          ],
        ),
      ),
    );
  }
}

class PuttingSetup extends StatelessWidget {
  const PuttingSetup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _ChoiceChip(),
        const Divider(),
        const StackSizeSliders(),
        const Center(
            child: Text(
          "# of Putters",
          textScaleFactor: 1.25,
        )),
        const Divider(),
        const DistanceSliders(),
        const Center(
            child: Text(
          "Distance To Basket (ft)",
          textScaleFactor: 1.25,
        ))
      ],
    );
  }
}

//
// This is where the code for the Choice Chips goes
//

class _ChoiceChip extends StatefulWidget {
  @override
  _ChoiceChipState createState() => _ChoiceChipState();
}

class _ChoiceChipState extends State<_ChoiceChip> with RestorationMixin {
  final RestorableIntN _indexSelected = RestorableIntN(global.shotType);

  @override
  String get restorationId => 'choice_chip_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_indexSelected, 'choice_chip');
  }

  @override
  void dispose() {
    _indexSelected.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        children: [
          ChoiceChip(
            label: const Text("Hyzer"),
            selected: _indexSelected.value == 0,
            onSelected: (value) {
              setState(() {
                _indexSelected.value = value ? 0 : -1;
                global.shotType = 0;
              });
            },
          ),
          const SizedBox(width: 8),
          ChoiceChip(
            label: const Text("Flat"),
            selected: _indexSelected.value == 1,
            onSelected: (value) {
              setState(() {
                _indexSelected.value = value ? 1 : -1;
                global.shotType = 1;
              });
            },
          ),
          const SizedBox(width: 8),
          ChoiceChip(
            label: const Text("Anhyzer"),
            selected: _indexSelected.value == 2,
            onSelected: (value) {
              setState(() {
                _indexSelected.value = value ? 2 : -1;
                global.shotType = 2;
              });
            },
          ),
        ],
      ),
    );
  }
}

//
// This is where the stackSize Slider Code goes
//

class StackSizeSliders extends StatefulWidget {
  const StackSizeSliders({Key? key}) : super(key: key);

  @override
  StackSizeSlidersState createState() => StackSizeSlidersState();
}

class StackSizeSlidersState extends State<StackSizeSliders>
    with RestorationMixin {
  final RestorableDouble _continuousValue =
      RestorableDouble(global.stackSize.toDouble());

  @override
  String get restorationId => 'stackSize_slider';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_continuousValue, 'continuous_value');
  }

  @override
  void dispose() {
    _continuousValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Semantics(
                child: SizedBox(
                  width: 64,
                  height: 48,
                  child: TextField(
                    textAlign: TextAlign.center,
                    onSubmitted: (value) {
                      final newValue = double.tryParse(value);
                      if (newValue != null &&
                          newValue != _continuousValue.value) {
                        setState(() {
                          _continuousValue.value = newValue.clamp(0, 20);
                          global.stackSize = newValue.clamp(0, 20).toInt();
                        });
                      }
                    },
                    keyboardType: TextInputType.number,
                    controller: TextEditingController(
                      text: _continuousValue.value.toStringAsFixed(0),
                    ),
                  ),
                ),
              ),
              Slider(
                value: _continuousValue.value,
                min: 0,
                max: 20,
                onChanged: (value) {
                  setState(() {
                    _continuousValue.value = value;
                    global.stackSize = value.toDouble().toInt();
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//
// This is where the distance slider code goes

class DistanceSliders extends StatefulWidget {
  const DistanceSliders({Key? key}) : super(key: key);

  @override
  DistanceSlidersState createState() => DistanceSlidersState();
}

class DistanceSlidersState extends State<DistanceSliders>
    with RestorationMixin {
  final RestorableDouble _continuousValue =
      RestorableDouble(global.distance.toDouble());

  @override
  String get restorationId => 'distance_slider';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_continuousValue, 'continuous_value');
  }

  @override
  void dispose() {
    _continuousValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Semantics(
                child: SizedBox(
                  width: 64,
                  height: 48,
                  child: TextField(
                    textAlign: TextAlign.center,
                    onSubmitted: (value) {
                      final newValue = double.tryParse(value);
                      if (newValue != null &&
                          newValue != _continuousValue.value) {
                        setState(() {
                          _continuousValue.value =
                              newValue.clamp(0, 100) as double;
                          global.distance = newValue.clamp(0, 100).toInt();
                        });
                      }
                    },
                    keyboardType: TextInputType.number,
                    controller: TextEditingController(
                      text: _continuousValue.value.toStringAsFixed(0),
                    ),
                  ),
                ),
              ),
              Slider(
                value: _continuousValue.value,
                min: 0,
                max: 100,
                onChanged: (value) {
                  setState(() {
                    _continuousValue.value = value;
                    global.distance = value.toDouble().toInt();
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ShotsMade extends StatefulWidget {
  const ShotsMade({Key? key}) : super(key: key);
  @override
  State<ShotsMade> createState() => _ShotsMadeState();
}

class _ShotsMadeState extends State<ShotsMade> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text("Made putts")),
      body: SafeArea(
        top: false,
        child: ListView.builder(
            reverse: true,
            itemBuilder: (context, int index) => SizedBox(
                height: (height) / 7,
                child: GestureDetector(
                  onTap: () => {
                    global.makes = global.makes + index,
                    print(global.makes),
                    Navigator.pop(context)
                  },
                  child: Container(
                    color: Color.fromARGB(
                        (255 / global.stackSize * index).ceil(), 200, 0, 0),
                    child: Center(
                        child: Text(
                      (index).toString(),
                      textScaleFactor: 5,
                    )),
                  ),
                )),
            itemCount: global.stackSize + 1),
      ),
    );
  }
}

//
// This is where the putting counter code goes
//
class PuttingCounter extends StatelessWidget {
  const PuttingCounter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Counter();
  }
}

class CustomPageRoute extends MaterialPageRoute {
  CustomPageRoute({builder}) : super(builder: builder);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);
}

class Counter extends StatefulWidget {
  const Counter({Key? key}) : super(key: key);
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  var count = global.count;
  var makes = global.makes;
  var stackSize = global.stackSize;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return Row(children: [
          GestureDetector(
              onLongPress: () {
                final makesSnackBar = SnackBar(
                    content: Text(
                        "${global.makes}/$count - Accuracy: ${(global.makes / count) * 100.round()}%"));
                global.snackbarKey.currentState?.showSnackBar(makesSnackBar);
              },
              onTap: () => setState(() {
                    if (count - stackSize <= 0) {
                      count = 0;
                    } else {
                      count = count - stackSize;
                    }
                    global.count = count;
                    if (count >= global.goal) {
                      global.backgroundColor = global.green;
                    } else {
                      global.backgroundColor = Colors.transparent;
                    }
                  }),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      height: constraints.maxHeight,
                      width: (MediaQuery.of(context).size.width / 2),
                      color: global.backgroundColor))),
          GestureDetector(
              onLongPress: () {
                final makesSnackBar = SnackBar(
                    content: Text(
                        "${global.makes}/$count - Accuracy: ${(global.makes / count) * 100.round()}%"));
                global.snackbarKey.currentState?.showSnackBar(makesSnackBar);
              },
              onTap: () => setState(() {
                    Navigator.push(
                        context,
                        CustomPageRoute(
                            builder: (context) => const ShotsMade()));
                    count = count + stackSize;
                    global.count = count;
                    if (count >= global.goal) {
                      global.backgroundColor = global.green;
                    } else {
                      global.backgroundColor = Colors.transparent;
                    }
                  }),
              child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                      height: constraints.maxHeight,
                      width: (MediaQuery.of(context).size.width / 2),
                      color: global.backgroundColor))),
        ]);
      }),
      Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Center(
            child: IgnorePointer(
                child: Text(
          "$count",
          textScaleFactor: 10,
        ))),
        ElevatedButton(
            child: const Text(
              "Log Session",
              textScaleFactor: 2,
            ),
            style: null,
            onPressed: count == 0
                ? null
                : () async {
                    final currentCount = count;
                    final currentMakes = global.makes;
                    int? i = await DataBaseHelper.instance.insert({
                      DataBaseHelper.columnName: global.name,
                      DataBaseHelper.columnDate: DateTime.now().toString(),
                      DataBaseHelper.columnThrows: global.count,
                      DataBaseHelper.columnMakes: global.makes,
                      DataBaseHelper.columnShotType: global.shotType,
                      DataBaseHelper.columnDistance: global.distance,
                      DataBaseHelper.columnStackSize: global.stackSize
                    });

                    setState(() {
                      global.makes = 0;
                      count = 0;
                      global.backgroundColor = Colors.transparent;
                    });
                    final snackBar = SnackBar(
                        content: Text(
                            "Logged session $i to database:\n\nYou made $currentMakes of ${global.count.toString()} ${global.shotType == 0 ? "hyzer" : (global.shotType == 1 ? "flat" : "anhyzer")} throws from ${global.distance.toString()} feet."),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () async {
                            await DataBaseHelper.instance.delete(i);
                            setState(() {
                              count = currentCount;
                              global.makes = currentMakes;
                              if (count >= global.goal) {
                                global.backgroundColor = global.green;
                              } else {
                                global.backgroundColor = Colors.transparent;
                              }
                            });
                            final deleteSnackBar = SnackBar(
                              content: Text("Deleted session $i"),
                            );
                            global.snackbarKey.currentState
                                ?.showSnackBar(deleteSnackBar);
                          },
                        ));
                    global.snackbarKey.currentState?.showSnackBar(snackBar);
                  }),
      ])
    ]);
  }
}
