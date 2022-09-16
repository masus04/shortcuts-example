import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SelectSearchApp extends StatelessWidget {
  const SelectSearchApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Focus(
          onKey: (node, event) {
            if (event.isControlPressed && event.physicalKey == PhysicalKeyboardKey.keyF) {
              debugPrint("onKey: [ctrl] + [F] pressed");
              return KeyEventResult.handled;
            }
            return KeyEventResult.ignored;
          },
          child: Center(
            child: Card(
              color: Colors.white,
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text("Pressing [ctrl] + [F] should focus the below TextField and print a message to the console. \n\nNotice however, that the behaviour changes depending on which component is focused:\n * If the TextField is focused, the message is printed to the console twice\n * If any other element is focused when the key combination is pressed, the native search field is triggered"),
                    TextField(
                      decoration: InputDecoration(labelText: "Press [ctrl] + [F] to select"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
