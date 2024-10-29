import 'dart:async';

import 'package:app1/Screen/Register.dart';
import 'package:flutter/material.dart';


class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  void initState(){
    super.initState();
    Timer(const Duration(seconds: 6), (){
Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> Register()));
    },);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment:MainAxisAlignment.center,
            children: [
              Image.asset("assest/images/logo.png",
              width: 100,
              height: 100,
              fit: BoxFit.cover,),
              const SizedBox(height:20,),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 100.0),
                child: LinearProgressIndicator(
                  minHeight: 2,
                  backgroundColor: Colors.grey,
                  valueColor:AlwaysStoppedAnimation<Color>(
                    Color.fromARGB(255, 216, 26, 137)
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("What's App"),
              ),
              const Padding(
                padding: EdgeInsets.all(16),
                child:
                 Text("End To End Encrypted",style: TextStyle(color: Color.fromARGB(255, 136, 134, 134)),),
              )
            ],
          ),
        )
        
        ),
    );
  }
}