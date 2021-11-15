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
  @override
    Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    WeatherController weatherController = Get.find();
    // Future<List<String>> newDataList = weatherController.listCity();
    // List<String> newDataList = weatherController.listCities;
    List<String> _cities= [];

    @override
    void initState(){
      var json_city =  DefaultAssetBundle.of(context).loadString('assets/json/city_list.json');
      var newDataList = json.decode(json_city.toString());   
      for (var q in newDataList){
        _cities.add(q['name']);
      } 
      super.initState();
    }

    @override
    void onItemChanged(String value) {
    setState(() {
      _cities = _cities
          .where((string) => string.toLowerCase().contains(value.toLowerCase()))
          .toList();
      
    });}
    // print(weatherController.listCities);
    return Scaffold(
      body: FutureBuilder(
              future: DefaultAssetBundle.of(context)
                  .loadString('assets/json/city_list.json'),
              builder: (context, snapshot) {
                // Decode the JSON
                if (!snapshot.hasData) {
                  return Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(weatherController.background),
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
                                          // onChanged: onItemChanged,                      
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
                  for (var q in newDataList){
                    _cities.add(q['name']);
                  } 
                      return Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(weatherController.background),
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
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(_cities[index]),
                              );
                            },
                          ),
                          ),
                        ],
                      ) ,
                      );
                }
            }
      
      
      //  Container(
      //   decoration: BoxDecoration(
      //     image: DecorationImage(
      //       image: AssetImage(weatherController.background),
      //       fit: BoxFit.fill,
      //     ),
      //   ),
      // child: //SingleChildScrollView(child:             
      //      Column(
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     children: [
      //     const SizedBox(height: 60),
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Container(
      //           margin: const EdgeInsets.only(left: 15),
      //           padding: const EdgeInsets.symmetric(horizontal: 20),
      //           width: size.width*0.83,
      //           height: size.height/20,
      //           decoration: BoxDecoration(
      //               color: Colors.white, borderRadius: BorderRadius.circular(29)),
      //               child:  GestureDetector(
      //                     child: TextField(
      //                     obscureText: false,
      //                     decoration: const InputDecoration(
      //                       icon: Icon(
      //                         Icons.search,
      //                         color:Colors.black,),
      //                       hintText: 'Search city',
      //                       border: InputBorder.none,
      //                     ),
      //                     // onChanged: onItemChanged,                      
      //                   )                        
      //               )
      //         ),
      //         IconButton(onPressed: (){Get.back();}, 
      //         padding: const EdgeInsets.only(right: 2, left: 5),
      //         icon: const Icon(Icons.cancel, color: Colors.white, size: 40,))
      //       ],
      //     ),
      //     // Expanded(
      //     //     child: ListView.builder(
      //     //       shrinkWrap: true,
      //     //       itemCount: newDataList.length,
      //     //       itemBuilder: (context, index) {
      //     //         return ListTile(
      //     //           title: Text(newDataList[index]),
      //     //         );
      //     //       },
      //     //     ),)
      //   ],
      // ) ,
      // ))
    ));
  }
}