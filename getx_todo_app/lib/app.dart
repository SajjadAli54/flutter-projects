import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/modules/bindings/home_binding.dart';
import 'app/modules/view/home_view.dart';
import 'app/routes/app_routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Weather App using GetX',
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: AppRoutes.home,
          page: () => HomePage(),
          binding: HomeBinding(),
        )
      ],
    );
  }
}
