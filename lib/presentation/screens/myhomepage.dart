import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/backgrounds/clear_sky.png'),
            fit: BoxFit.fill,
          ),
        ),
      child: Column(
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
                    child: const TextField(
                    obscureText: false,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      hintText: 'Search city',
                      border: InputBorder.none,
                    ),
                  ),
              ),
              IconButton(onPressed: () =>{}, 
              padding: const EdgeInsets.only(right: 2, left: 5),
              icon: const Icon(Icons.add, color: Colors.white, size: 40,))
            ],
          
          ),
          SizedBox(height: size.height*0.15,),
          Text('Bogotá', textAlign: TextAlign.center, 
                style: GoogleFonts.rubik(color: Colors.white, fontSize: 40, 
                shadows: <Shadow>[
                  const Shadow(
                    offset: Offset(2,2),
                    blurRadius: 1.0,
                    color: Colors.grey,
                  ),
                ],)),
          Text(' 19°', textAlign: TextAlign.center, 
                style: GoogleFonts.rubik(color: Colors.white, fontSize: 100, 
                shadows: <Shadow>[
                  const Shadow(
                    offset: Offset(-1,3),
                    blurRadius: 1.0,
                    color: Colors.grey,
                  ),
                ],)),
          SizedBox(height: size.height/15,),
          Text('Broken Clouds', textAlign: TextAlign.center, 
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
                  color: Colors.blueGrey.withOpacity(0.2), borderRadius: BorderRadius.circular(29)),
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
      )
    );
  }
}