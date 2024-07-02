import 'package:flutter/material.dart';

import 'target.dart';
import 'draggable.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Draggable and DragTarget Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              DraggableWidget(),
              SizedBox(height: 50),
              DragTargetWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
