import 'package:dart_application_factory/person.dart';

void main(List<String> args) {
  final p1 = Person("John");
  var p2 = Person("John");
  var p3 = Person("Jack");

  print(p1 == p2);
  print(p2 == p3);
}
