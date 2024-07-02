class Weather {
  int? temp;

  Weather({this.temp});

  Weather.fromJson(dynamic json) {
    // We take the data `temp` data inside `main` and convert to degree Celsius.
    var tempInKelvin = json['main']['temp'];
    // 0 degrees Kelvin is equal to -273.15 degrees Celsius:
    temp = (tempInKelvin - 273.15).round();
  }
}
