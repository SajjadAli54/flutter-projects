class Animal {
  factory Animal(String type) {
    switch (type) {
      case "dog":
        return Dog();
      case "cat":
        return Cat();
      default:
        throw ArgumentError('Unknown animal type');
    }
  }

  @override
  toString() {
    return "Animal";
  }
}

class Dog implements Animal {
  @override
  toString() {
    return "Dog";
  }
}

class Cat implements Animal {
  @override
  toString() {
    return "Cat";
  }
}

void main(List<String> args) {
  var dog = Animal("dog");
  var cat = Animal("cat");

  print(dog);
  print(cat);
}
