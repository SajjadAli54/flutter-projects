class Singleton {
  Singleton._privateConstructor();

  static final Singleton _instance = Singleton._privateConstructor();

  factory Singleton() {
    return _instance;
  }
}

void main(List<String> args) {
  var s1 = Singleton();
  var s2 = Singleton();

  print(s1 == s2); // true
}
