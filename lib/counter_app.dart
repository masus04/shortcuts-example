import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(
        title: 'Flutter Demo Home Page',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onKey: (node, event) {
        if (event.isControlPressed && event.physicalKey == PhysicalKeyboardKey.keyF) {
          debugPrint("onKey: ctrl + F pressed");
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Shortcuts(
          shortcuts: const {
            SingleActivator(LogicalKeyboardKey.arrowUp): IncrementIntent(),
            SingleActivator(LogicalKeyboardKey.arrowDown): DecrementIntent(),
          },
          child: Actions(
            actions: {
              IncrementIntent: SetCounterAction(perform: () {
                setState(() {
                  _counter += 1;
                });
              }),
              DecrementIntent: SetCounterAction(perform: () {
                setState(() {
                  _counter -= 1;
                });
              }),
            },
            child: Focus(
              onKey: (node, event) {
                if (event.isControlPressed && event.physicalKey == PhysicalKeyboardKey.keyF) {
                  debugPrint("onKey: ctrl + F pressed");
                  return KeyEventResult.handled;
                }
                return KeyEventResult.ignored;
              },
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'You have pushed the button this many times:',
                      style: Theme.of(context).textTheme.headline5!,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        '$_counter',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text.rich(
                        TextSpan(
                          style: Theme.of(context).textTheme.headline5!.copyWith(textBaseline: TextBaseline.ideographic),
                          children: const [
                            TextSpan(text: "Press "),
                            WidgetSpan(child: KeyIcon(iconData: Icons.arrow_upward)),
                            TextSpan(text: " to increment counter, press "),
                            WidgetSpan(child: KeyIcon(iconData: Icons.arrow_downward)),
                            TextSpan(text: " to decrease counter."),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      "Notice that keyboard shortcuts only work when the TextField below is focused",
                      style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.red),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: TextField(
                        decoration: InputDecoration(labelText: "Click here for shortcuts to work"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}

class KeyIcon extends StatelessWidget {
  final IconData iconData;

  const KeyIcon({Key? key, required this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: Icon(
        iconData,
        size: 20,
      ),
    );
  }
}

class IncrementIntent extends Intent {
  const IncrementIntent();
}

class DecrementIntent extends Intent {
  const DecrementIntent();
}

class SetCounterAction extends Action {
  final Function perform;

  SetCounterAction({required this.perform});

  @override
  Object? invoke(Intent intent) {
    debugPrint("Updated counter");
    return perform();
  }
}
