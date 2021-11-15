import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/domain/weather_controller.dart';

class SearchPage extends StatefulWidget {

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
    List<String> _cities= [];
    @override
    Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    WeatherController weatherController = Get.find();

    @override
    void onItemChanged(String value) {
    setState(() {
      _cities = _cities
          .where((string) => string.toLowerCase().contains(value.toLowerCase()))
          .toList();    
    });}
    return Scaffold(
      body: FutureBuilder(
              future: DefaultAssetBundle.of(context)
                  .loadString('assets/json/city_list.json'),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(weatherController.background),
                            fit: BoxFit.fill,
                          ),
                        ),
                      child:             
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
                                    child:  GestureDetector(
                                          child: const TextField(
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            icon: Icon(
                                              Icons.search,
                                              color:Colors.black,),
                                            hintText: 'Search city',
                                            border: InputBorder.none,
                                          ),                    
                                        )                        
                                    )
                              ),
                              IconButton(onPressed: (){Get.back();}, 
                              padding: const EdgeInsets.only(right: 2, left: 5),
                              icon: const Icon(Icons.cancel, color: Colors.white, size: 40,))
                            ],
                          ),
                        ],
                      ) ,
                      );
                } else{
                      var newDataList = json.decode(snapshot.data.toString());  
                       Map<String, dynamic> mapData = {}; 
                      for (var q in newDataList){
                        mapData[q['name'] + '-' + q['country']]=q['id'];
                        _cities.add(q['name'] + '-' + q['country'] );
                      } 
                      weatherController.saveMapData(mapData);
                      _cities = _cities.toSet().toList();
                      return Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(weatherController.background),
                            fit: BoxFit.fill,
                          ),
                        ),
                      child:          
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
                                    child:  GestureDetector(
                                          child: TextField(
                                          autofocus: true,
                                          obscureText: false,
                                          decoration: const InputDecoration(
                                            icon: Icon(
                                              Icons.search,
                                              color:Colors.black,),
                                            hintText: 'Search city',
                                            border: InputBorder.none,
                                          ),
                                          onChanged: onItemChanged,                      
                                        )                        
                                    )
                              ),
                              IconButton(onPressed: (){Get.back();}, 
                              padding: const EdgeInsets.only(right: 2, left: 5),
                              icon: const Icon(Icons.cancel, color: Colors.white, size: 40,))
                            ],
                          ),
                          Expanded(
                            child: ListView.builder(
                            itemCount: _cities.length,
                            itemBuilder: (context, index) {
                              String word = _cities[index];
                              bool isSaved = weatherController.savedWords.contains(word); 
                              return GestureDetector(
                                child: ListTile(
                                        title: Text(_cities[index],style: GoogleFonts.rubik(color: Colors.white, fontSize: 15, )),
                                        trailing: Icon(
                                          isSaved? Icons.favorite:Icons.favorite_border,
                                          color: isSaved?Colors.red:null,)
                                      ),
                                onTap: ()=>{
                                  if (isSaved == false){
                                    weatherController.saveNewWord(word),
                                  },                                  
                                  weatherController.updateWeather(mapData[_cities[index]]),
                                  Get.back()
                                },
                              );
                            },
                            
                          ),
                          ),
                        ],
                      ) ,
                      );
                }
            }
      )
    );
  }
}