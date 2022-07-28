// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/balloon.dart';
import 'package:my_app/dialogBlock.dart';
import 'package:my_app/forceBar.dart';
import 'package:my_app/holdingCircle.dart';
import 'package:my_app/pressureFrame.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eureka Moment',
      theme: ThemeData(
        textTheme: GoogleFonts.aBeeZeeTextTheme(Theme.of(context).textTheme),
      ),
      home: Scaffold(
        body: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 25,
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 50, 0, 0),
                        child:  Container(
                          child: Icon(Icons.edit_note_rounded, size: 30, color: Colors.grey,),
                        ),
                      ),),
                    Spacer(flex: 1),
                    Expanded(
                      flex: 10,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                        child:  PressurePercentage(pressure:0.5,),
                      ),),
                    Spacer(flex: 1),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 50, 20, 0),
                        child:  Container(
                          child: Icon( Icons.settings_rounded, size: 30, color: Colors.grey,),
                        ),
                      ),),
                  ],
                ),),
              Spacer(flex: 2),
              Expanded(flex: 5,child: ForceBar(pressure: 1.0,),),
              Spacer(flex: 3),
              Expanded(flex: 13, child: DialogBlock(),),
              Spacer(flex: 3),
              Expanded(flex: 40, child: Balloon(),),
            ],
          ),
        ),
      ),
    );
  }
}