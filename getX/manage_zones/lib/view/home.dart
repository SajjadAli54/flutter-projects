import 'package:flutter/material.dart';
import 'package:manage_zones/view/log_out.dart';
import 'package:manage_zones/view/zones_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home Page"),
          actions: const [LogOut()],
        ),
        body: Center(
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Zones()));
              },
              child: const Text("See Zones")),
        ));
  }
}
