import 'dart:isolate';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/gifs/bouncingball.gif",
            height: 100,
          ),
          const SizedBox(
            height: 20,
          ),
          // This will cause the UI to be unresponsive and hinder the user's experience
          ElevatedButton(
              onPressed: () {
                var total = complexTask1();
                debugPrint(total.toString());
              },
              child: const Text("Task 1")),
          //Using async and await
          ElevatedButton(
              onPressed: () async {
                var total = await complexTask1();
                debugPrint(total.toString());
              },
              child: const Text("Task 2")),
          ElevatedButton(
              onPressed: () {
                final receivePort = ReceivePort();
                 Isolate.spawn(complextask3, receivePort.sendPort);
                receivePort.listen((message) {
                  debugPrint(message.toString());
                });
              },
              child: const Text("Task 3"))
        ],
      )),
    );
  }

  double complexTask1() {
    var total = 0.0;
    for (var i = 0; i < 1000000000; i++) {
      total += i;
    }
    return total;
  }

  Future<double> complexTask() async {
    var total = 0.0;
    for (var i = 0; i < 1000000000; i++) {
      total += i;
    }
    return total;
  }
}
// End of homepage class

complextask3(SendPort sendPort) {
  var total = 0.0;
  for (var i = 0; i < 1000000000; i++) {
    total += i;
  }
  sendPort.send(total);
}
