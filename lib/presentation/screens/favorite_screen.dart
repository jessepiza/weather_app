import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/domain/weather_controller.dart';
import 'package:weather_app/presentation/screens/search_screen.dart';

class FavoritePage extends StatelessWidget {

  const FavoritePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    WeatherController weatherController = Get.find();
    return Obx(()=>Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Cities", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        leading: const BackButton(),
      ),

      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(weatherController.background),
            fit: BoxFit.fill,
          ),
        ),
      child:             
              ListView.builder(
              itemCount: weatherController.savedWords.length,
              itemBuilder: (context, index) {
                String word = weatherController.savedWords[index];
                bool isSaved = weatherController.savedWords.contains(word); 
                return GestureDetector(
                  child: ListTile(
                          title: Text(weatherController.savedWords[index],style: GoogleFonts.rubik(color: Colors.white, fontSize: 20, )),
                          trailing: IconButton(
                            onPressed: ()=>{
                              if (isSaved){
                                weatherController.deleteNewWord(word),
                              },  
                            },
                            icon: isSaved? const Icon(Icons.favorite):const Icon(Icons.favorite_border),
                            color: isSaved?Colors.red:null,)
                        ),
                  onTap: ()=>{
                    if (isSaved == false){
                      weatherController.saveNewWord(word),
                    },                              
                    // print(weatherController.mapData[weatherController.savedWords[index]]),    
                    weatherController.updateId(weatherController.mapData[weatherController.savedWords[index]]),
                    weatherController.updateWeather(weatherController.mapData[weatherController.savedWords[index]]),
                    Get.back()
                  },
                );
              },
              
            ),
            ),
      )
    );
  }
}