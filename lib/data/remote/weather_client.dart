import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:weather_app/data/model/weather.dart';

class WeatherClient {
  static const baseUrl = "https://api.openweathermap.org/data/2.5/weather";
  static const appid = "d5abe3d816a237c5f52019701508dd84";
  final String id;
  WeatherClient(this.id);

  Future<Weather> getItems(String topic) async {
    var uri = Uri.parse(baseUrl)
        .resolveUri(Uri(queryParameters: {
      "id": id,
      "units": "metric",
      "appid": appid
    }));

    try {
      final response = await http.get(uri).timeout(const Duration(seconds: 1));
      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        dynamic id = jsonResponse['id'];
        String name = jsonResponse['name'];
        String description = jsonResponse['weather']['description'];
        dynamic temp = jsonResponse['main']['temp'];
        dynamic feelsLike = jsonResponse['main']['feels_like'];
        dynamic humidity = jsonResponse['main']['humidity'];
        dynamic windSpeed = jsonResponse['wind']['speed'];
        dynamic pressure = jsonResponse['main']['pressure'];

        Weather weather = Weather(id: id, name: name, description: description, temp: temp, feelsLike: feelsLike, humidity: humidity, windSpeed: windSpeed, pressure: pressure);
        return weather;
      } else {
        return Future.error([]);
      }
    } catch (e) {
      return Future.error('Client error Timeout');
    }
  }
}
