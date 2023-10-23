class APIEndPoints {
  static String get baseUri => 'http://api.weatherapi.com/v1';
  static String get apiKey => "c4f27e077fdd4dd093490737232110";

// wather uri
  static String watherUri(let, long) {
    return '$baseUri/current.json?key=$apiKey&q=$let,$long';
  }
}
