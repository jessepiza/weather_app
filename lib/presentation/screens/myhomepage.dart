import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/domain/weather_controller.dart';
import 'package:weather_app/presentation/screens/search_screen.dart';

class HomePage extends StatelessWidget {

  const HomePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    WeatherController weatherController = Get.find();
    // weatherController.initDB();
    dynamic id = 3688685;
    weatherController.updateWeather(id);
    Timer.periodic(const Duration(hours: 1), (Timer t) => weatherController.updateWeather(id));
    return Obx(()=>Scaffold(
      body: Container(
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
                          obscureText: false,
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.search,
                              color:Colors.black,),
                            hintText: 'Search city',
                            border: InputBorder.none,
                          ),
                          onTap: () {Get.to(()=> SearchPage());},
                          
                        )
                        
                    )
                      
                  //   const TextField(
                  //   obscureText: false,
                  //   decoration: InputDecoration(
                  //     icon: Icon(
                  //       Icons.search,
                  //       color: Colors.black,
                  //     ),
                  //     hintText: 'Search city',
                  //     border: InputBorder.none,
                  //   ),
                  //   onTap: () {Get.to(const SearchPage());},
                  // ),
              ),
              IconButton(onPressed: () async =>{                }, 
              padding: const EdgeInsets.only(right: 2, left: 5),
              icon: const Icon(Icons.add, color: Colors.white, size: 40,))
            ],
          
          ),
          SizedBox(height: size.height*0.1,),
          Text(weatherController.city, textAlign: TextAlign.center, 
                style: GoogleFonts.rubik(color: Colors.white, fontSize: 40, 
                shadows: <Shadow>[
                  const Shadow(
                    offset: Offset(2,2),
                    blurRadius: 1.0,
                    color: Colors.grey,
                  ),
                ],)),
          Text('${weatherController.temp}°', textAlign: TextAlign.center, 
                style: GoogleFonts.rubik(color: Colors.white, fontSize: 100, 
                shadows: <Shadow>[
                  const Shadow(
                    offset: Offset(-1,3),
                    blurRadius: 1.0,
                    color: Colors.grey,
                  ),
                ],)),
          SizedBox(height: size.height/15,),
          Text(weatherController.description, textAlign: TextAlign.center, 
                style: GoogleFonts.rubik(color: Colors.white, fontSize: 25, 
                shadows: <Shadow>[
                  const Shadow(
                    offset: Offset(2,2),
                    blurRadius: 1.0,
                    color: Colors.grey,
                  ),
                ],)),
          SizedBox(height: size.height/35,),
          Container(
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(10),
                width: size.width*0.83,
                height: size.height/3,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4), 
                  borderRadius: BorderRadius.circular(29)),
                child: 
                Column(
                  children: [
                    SizedBox(height: size.height*0.05,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Feels Like', textAlign: TextAlign.center, 
                        style: GoogleFonts.rubik(color: Colors.white.withOpacity(0.7), fontSize: 18, 
                        )),
                        Text('Humidity', textAlign: TextAlign.center, 
                        style: GoogleFonts.rubik(color: Colors.white.withOpacity(0.7), fontSize: 18, 
                        )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('${weatherController.feelsLike}°C', textAlign: TextAlign.center, 
                        style: GoogleFonts.rubik(color: Colors.white, fontSize: 30, 
                        )),
                        Text('  ${weatherController.humidity}%', textAlign: TextAlign.center, 
                        style: GoogleFonts.rubik(color: Colors.white, fontSize: 30, 
                        )),
                      ],
                    ),
                    SizedBox(height: size.height*0.05,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Wind speed', textAlign: TextAlign.center, 
                        style: GoogleFonts.rubik(color: Colors.white.withOpacity(0.7), fontSize: 18, 
                        )),
                        Text('Pressure', textAlign: TextAlign.center, 
                        style: GoogleFonts.rubik(color: Colors.white.withOpacity(0.7), fontSize: 18, 
                        )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('${weatherController.windSpeed}km/h', textAlign: TextAlign.center, 
                        style: GoogleFonts.rubik(color: Colors.white, fontSize: 30, 
                        )),
                        Text('${weatherController.pressure}mb', textAlign: TextAlign.center, 
                        style: GoogleFonts.rubik(color: Colors.white, fontSize: 30, 
                        )),
                      ],
                    ),
                  ],
                ),
          ),
          
          // BorderedText(
          //       strokeWidth: 2,
          //       strokeColor: Colors.grey.withOpacity(0.8),
          //       child: const Text('Broken Clouds', textAlign: TextAlign.center, 
          //       style: GoogleFonts.oswald(color: Colors.white))
          //       )
                // style: TextStyle(fontSize: 25, color: Colors.white, decorationColor: Colors.black)
            
          
        ],
      ) ,
      ))
    );
  }
}