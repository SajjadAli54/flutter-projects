import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home.dart';
import 'messages.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        translations: Messages(),
        locale: const Locale(
            'en', 'US'), // translations will be displayed in that locale
        fallbackLocale: const Locale('en', 'UK'),
        home: const Home());
  }
}
