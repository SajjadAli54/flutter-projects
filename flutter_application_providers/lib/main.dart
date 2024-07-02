import 'package:flutter/material.dart';
import 'package:flutter_application_providers/counter_model.dart';
import 'package:flutter_application_providers/counter_screen.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(ChangeNotifierProvider(
    create: (context) => CounterModel(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CounterScreen(),
    );
  }
}
