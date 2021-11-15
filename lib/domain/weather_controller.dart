import 'dart:convert' as convert;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:weather_app/data/model/weather.dart';
import 'package:weather_app/data/remote/weather_client.dart';
import 'package:weather_app/db/weather_db.dart';
import 'dart:async';

class WeatherController extends GetxController {
  final _id = 0.obs;
  final _temp = 0.0.obs;
  final _city = ''.obs;
  final _description = ''.obs;
  final _feelsLike = 0.0.obs;
  final _humidity = 0.obs;
  final _windSpeed = 0.0.obs;
  final _pressure = 0.obs;
  final _listCities = [].obs;
  final _background = 'assets/backgrounds/clear_sky.png'.obs;

  dynamic get id => _id.value;
  double get temp => _temp.value;
  String get city => _city.value;
  String get description => _description.value;
  double get feelsLike => _feelsLike.value;
  int get humidity => _humidity.value;
  dynamic get windSpeed => _windSpeed.value;
  int get pressure => _pressure.value;
  List<String> get listCities => [... _listCities];
  String get background => _background.value;

  // var timer = Timer.periodic(const Duration(seconds: 5), (Timer t) => updateWeather(_id.value));

  Future<void> initDB() async {
    WeatherDB database = WeatherDB.instance;
      final String response = await rootBundle.loadString('assets/json/city_list.json');
      var jsonResponse = convert.jsonDecode(response);

      for (var i in jsonResponse){
        Weather weatherCity = Weather(id: i['id'], name: i['name'], temp: 0.0, description: '', feelsLike: 0.0, humidity: 0, windSpeed: 0.0, pressure: 0, main: '');
        try{
          database.insertWeatherCity(weatherCity);
        }on Exception catch (_){
          // ignore: avoid_print
          print('Error');
        }
      }
  }

  Future<List<String>> listCity() async {
    initDB();
    Database database = await WeatherDB.instance.database;
    List<Map> res = await database.rawQuery(
                                        "SELECT name FROM weather_city");
    return List<String>.generate(res.length, (i) {for (var q in res){q['name'];}return '';});
  }

  Future<void> updateWeather(dynamic newId) async {
    WeatherClient weatherClient = WeatherClient(newId);
    Weather weatherCity = await weatherClient.getWeather();
    _id.value = newId;
    _temp.value = double.parse(weatherCity.temp.toString());
    _city.value = weatherCity.name!;
    _description.value = weatherCity.description!;
    _feelsLike.value = double.parse(weatherCity.feelsLike.toString());
    _windSpeed.value = double.parse(weatherCity.windSpeed.toString());
    _humidity.value = int.parse(weatherCity.humidity.toString());
    _pressure.value = int.parse(weatherCity.pressure.toString());

    if (weatherCity.main == 'Clear'){
      _background.value = 'assets/backgrounds/clear_sky.png';
    }
    else if(weatherCity.main == 'Clouds'){
      _background.value = 'assets/backgrounds/clouds.png';
    }
    else if(weatherCity.main == 'Drizzle'){
      _background.value = 'assets/backgrounds/drizzle.png';
    }
    else if(weatherCity.main == 'Rain'){
      _background.value = 'assets/backgrounds/rain.png';
    }
    else if(weatherCity.main == 'Snow'){
      _background.value = 'assets/backgrounds/snow.png';
    }
    else if(weatherCity.main == 'Thunderstorm'){
      _background.value = 'assets/backgrounds/thunderstorm.png';
    }
    else{
      _background.value = 'assets/backgrounds/clouds.png';
    }
    // database.updateWeatherCity(weatherCity);
  }



}