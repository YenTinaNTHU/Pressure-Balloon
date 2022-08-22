// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/settingPage.dart';
import 'package:my_app/homePage.dart';
import 'package:my_app/tutorialPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    double p = 0.7;
    return MaterialApp(
        title: 'Eureka Moment',
        theme: ThemeData(
          textTheme: GoogleFonts.aBeeZeeTextTheme(Theme.of(context).textTheme),
        ),
        routes: {
          "setting_page": (context) => const SettingPage(),
        },
        home: const TutorialPage());
  }
}
