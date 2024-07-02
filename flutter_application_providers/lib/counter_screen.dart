import 'package:flutter/material.dart';
import 'package:flutter_application_providers/counter_model.dart';
import 'package:provider/provider.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CounterModel model =
        Provider.of<CounterModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Provider Counter Example"),
      ),
      body: Center(
        child: Consumer<CounterModel>(
          builder: (context, counterModel, child) => Text(
            'Count: ${counterModel.counter}',
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => model.increment(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
