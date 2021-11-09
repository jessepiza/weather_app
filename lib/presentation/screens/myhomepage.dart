import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          
          )
         
        ],
      ) ,
      )
    );
  }
}