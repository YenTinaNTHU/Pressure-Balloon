// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_app/parameters.dart';
import 'package:my_app/record.dart';
import 'package:my_app/settingPage.dart';
import 'package:my_app/homePage.dart';
import 'package:my_app/tutorialPage.dart';
import 'package:my_app/endingPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  box = await Hive.openBox("recordbox");
  Hive.registerAdapter(RecordAdapter());

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool _tutorialLearned = box.get('tutorialLearned', defaultValue: false);
    print(_tutorialLearned);
    if (_tutorialLearned == false) {
      box.put('tutorialLearned', true);
    }
    return MaterialApp(
        title: 'Eureka Moment',
        theme: ThemeData(
          textTheme: GoogleFonts.aBeeZeeTextTheme(Theme.of(context).textTheme),
        ),
        routes: {
          "setting_page": (context) => const SettingPage(),
        },
        home: _tutorialLearned ? const HomePage() : const TutorialPage());
  }
}
