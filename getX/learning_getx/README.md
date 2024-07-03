# GetX

[Docs](https://pub.dev/packages/get)

GetX is a popular state management library for Flutter that provides a simple and effective way to manage the state of your application. It offers various functionalities like state management, dependency injection, routing, and more, all in a lightweight package. Let's go through some of the key concepts and code examples of using GetX in Flutter.

```sh
flutter pub add get
```

1. State Management with GetX:
   GetX provides a reactive state management system that allows you to easily manage and update your app's state. You can use GetX controllers to hold your state and observe changes in the UI.

Example:

```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CounterController extends GetxController {
  var count = 0;

  void increment() {
    count++;
    update(); // Notifies the UI to update when the count changes.
  }
}

class CounterPage extends StatelessWidget {
  final CounterController _controller = Get.put(CounterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GetX Counter Example')),
      body: Center(
        child: Obx(() => Text('Count: ${_controller.count}')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _controller.increment,
        child: Icon(Icons.add),
      ),
    );
  }
}
```

In the above example, we define a `CounterController` that extends `GetXController`. The `count` variable represents the state we want to manage. When the `increment` method is called, it increases the count and notifies the UI to update using `update()`.

The `CounterPage` widget uses `Get.put()` to instantiate the `CounterController`. Inside the widget, we use `Obx()` to observe changes to the `count` variable and update the UI accordingly.

2. Dependency Injection with GetX:
   GetX allows you to easily inject dependencies into your widgets using `Get.put()` or `Get.lazyPut()`.

Example:

```dart
class MyDependency {
  void doSomething() {
    print('Doing something...');
  }
}

class HomeController extends GetxController {
  final MyDependency _dependency;

  HomeController(this._dependency);

  void performAction() {
    _dependency.doSomething();
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MyDependency dependency = MyDependency();
    final HomeController _controller = Get.put(HomeController(dependency));

    return Scaffold(
      appBar: AppBar(title: Text('GetX Dependency Injection')),
      body: Center(
        child: ElevatedButton(
          onPressed: _controller.performAction,
          child: Text('Perform Action'),
        ),
      ),
    );
  }
}
```

In this example, we create a simple `MyDependency` class and a `HomeController` class that depends on `MyDependency`. By using `Get.put()`, we inject the `HomeController` with an instance of `MyDependency`, making it available throughout the widget tree.

3. Navigation with GetX:
   GetX also offers a powerful routing system for navigation within your app.

Example:

```dart
class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('First Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.to(SecondPage());
          },
          child: Text('Go to Second Page'),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Second Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.back(); // Go back to the previous page
          },
          child: Text('Go Back'),
        ),
      ),
    );
  }
}
```

In this example, we have two pages: `FirstPage` and `SecondPage`. When the button is pressed on `FirstPage`, we use `Get.to()` to navigate to the `SecondPage`. On the `SecondPage`, the button is used with `Get.back()` to go back to the previous page.

These are just some of the basic examples of how to use GetX in Flutter. GetX also provides more advanced features like dependency management, reactive services, and more, making it a powerful and versatile library for building Flutter applications.
