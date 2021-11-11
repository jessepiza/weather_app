import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:weather_app/data/model/weather.dart';

class WeatherClient {
  static const baseUrl = "https://api.openweathermap.org/data/2.5/weather";
  static const appid = "d5abe3d816a237c5f52019701508dd84";
  final dynamic id;
  WeatherClient(this.id);
  Future<Weather> getWeather() async {
    var uri = Uri.parse(baseUrl)
        .resolveUri(Uri(queryParameters: {
      "id": id.toString(),
      "units": "metric",
      "appid": appid
    }));
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        dynamic id = jsonResponse['id'];
        String name = jsonResponse['name'];
        var weatherDescription = jsonResponse['weather'];
        String main = weatherDescription[0]['main'];
        var description = weatherDescription[0]['description'];
        double temp = jsonResponse['main']['temp'];
        
        double feelsLike = jsonResponse['main']['feels_like'];
        int humidity = jsonResponse['main']['humidity'];
        dynamic windSpeed = jsonResponse['wind']['speed'];
        int pressure = jsonResponse['main']['pressure'];

        Weather weather = Weather(id: id, name: name, description: description, temp: temp, feelsLike: feelsLike, humidity: humidity, windSpeed: windSpeed, pressure: pressure, main:main);
        return weather;
      } else {
        return Future.error([]);
      }
    } catch (e) {
      return Future.error('Client error Timeout');
    }
  }
}
