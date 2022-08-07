// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/balloon.dart';
import 'package:my_app/dialogBlock.dart';
import 'package:my_app/forceBar.dart';
import 'package:my_app/holdingCircle.dart';
import 'package:my_app/pressureFrame.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/parameters.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double _pressure = 0.0;
  Status _status = Status.beforeSleep;
  int _milliSeconds = maxMilliSeconds;

  void _handlePressureChanged(double newPressure) {
    setState(() {
      _pressure = newPressure;
    });
  }
  void _setRemainMilliSeconds(int newMilliSeconds){
    setState(() {
      _milliSeconds = newMilliSeconds;
    });
  }

  void _updateStatus(Status st){
    setState(() {
      switch(_status){
        case Status.beforeSleep:
          _status = Status.sleeping;
          break;
        case Status.sleeping:
          _status = Status.awake;
          break;
        case Status.awake:
          _status = Status.beforeSleep;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double p = 0.7;
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 50, 0, 0),
                        child: Container(
                          child: const Icon(
                            Icons.edit_note_rounded,
                            size: 30,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(flex: 1),
                    Expanded(
                      flex: 10,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                        child: PressureFrame(
                          pressure: _pressure,
                          status: _status,
                        ),
                      ),
                    ),
                    Spacer(flex: 1),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 50, 20, 0),
                        child: Container(
                          child: const Icon(
                            Icons.settings_rounded,
                            size: 30,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(flex: 2),
              Expanded(
                flex: 7,
                child: ForceBar(
                  pressure: _pressure,
                ),
              ),
              Spacer(flex: 3),
              Expanded(
                flex: 13,
                child: DialogBlock(pressure: _pressure, state: _status),
              ),
              Spacer(flex: 3),
              Expanded(
                flex: 5,
                child: HoldingCircle(
                  milliSeconds: _milliSeconds,
                ),
              ),
              Spacer(flex: 3),
              Expanded(
                flex: 40,
                child: Balloon(
                  pressure: _pressure,
                  updatePressure: _handlePressureChanged,
                  status: _status,
                  updateStatus: _updateStatus,
                  milliseconds: _milliSeconds,
                  setRemainMilliseconds: _setRemainMilliSeconds,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
