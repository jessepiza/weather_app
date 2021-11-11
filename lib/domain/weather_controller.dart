import 'dart:convert' as convert;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:weather_app/data/model/weather.dart';
import 'package:weather_app/db/weather_db.dart';
import 'dart:async';

class WeatherController extends GetxController {
  WeatherDB database = WeatherDB.instance;

  Future<void> initDB() async {
      final String response = await rootBundle.loadString('assets/json/city_list.json');
      var jsonResponse = convert.jsonDecode(response);
      for (var i in jsonResponse){
        Weather weatherCity = Weather(id: i['id'], name: i['name'], temp: 0.0, description: '', feelsLike: 0.0, humidity: 0.0, windSpeed: 0.0, pressure: 0.0);
        try{
          
          database.insertWeatherCity(weatherCity);
        }on Exception catch (_){
          // ignore: avoid_print
          print('Error');
        }
      }
      print('logrado');
  }
}