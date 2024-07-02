class Person {
  final String name;
  static final Map<String, Person> _cache = <String, Person>{};

  factory Person(String name) {
    if (_cache.containsKey(name)) {
      return _cache[name]!;
    } else {
      final person = Person._internal(name);
      _cache[name] = person;
      return person;
    }
  }

  Person._internal(this.name);
}

void main(List<String> args) {
  final p1 = Person("John");
  var p2 = Person("John");
  var p3 = Person("Jack");

  print(p1 == p2); // true
  print(p2 == p3); // false
}
