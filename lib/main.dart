import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/domain/weather_controller.dart';
import 'package:weather_app/presentation/screens/myhomepage.dart';

void main() {
  Get.lazyPut<WeatherController>(() => WeatherController());
  runApp(App());
}

class App extends StatelessWidget{
  WeatherController weatherController = Get.find();
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WeatherApp',
        home: HomePage()
    );
  }
}