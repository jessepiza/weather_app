import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/domain/weather_controller.dart';

class SearchPage extends StatefulWidget {

  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _textController = TextEditingController();
    Size size = MediaQuery.of(context).size;
    WeatherController weatherController = Get.find();
    weatherController.listCity();

    List<String> newDataList = ['Bogotá', 'Cartagena', 'Medellín'];
    // List<String> newDataList = List.from(weatherController.listCities);

    onItemChanged(String value) {
    setState(() {
      newDataList = weatherController.listCities
          .where((string) => string.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/backgrounds/clear_sky.png'),
            fit: BoxFit.fill,
          ),
        ),
      child: //SingleChildScrollView(child:             
           Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
          const SizedBox(height: 60),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 15),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: size.width*0.83,
                height: size.height/20,
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(29)),
                    child: TextField(
                    controller: _textController,
                    obscureText: false,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      hintText: 'Search city',
                      border: InputBorder.none,
                    ),
                    onChanged: onItemChanged,
                  ),
              ),
              IconButton(onPressed: () async =>{Get.back()}, 
              padding: const EdgeInsets.only(right: 2, left: 5),
              icon: const Icon(Icons.cancel, color: Colors.white, size: 40,))
            ],
      ),
      Expanded(
            child: ListView(
              padding: EdgeInsets.all(12.0),
              children: newDataList.map((data) {
                return ListTile(
                  title: Text(data),
                  onTap: ()=> print(data),);
              }).toList(),
            ),
          )
      ])
    ));
  }
}