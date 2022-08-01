import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String title = "Eureka Moment";
  LongPressGestureRecognizer _longPressRecognizer = LongPressGestureRecognizer();
  ForcePressGestureRecognizer _forcePressRecognizer = ForcePressGestureRecognizer();
  double pressure = 0.0;

  @override
  void initState() {
    super.initState();
    _longPressRecognizer = LongPressGestureRecognizer()..onLongPress = _handlePress;
    _forcePressRecognizer = ForcePressGestureRecognizer(startPressure: 0.1, peakPressure: 1.0);
    _forcePressRecognizer.onStart = _handleForcePressOnStart;
    _forcePressRecognizer.onUpdate = _handleForcePressOnUpdate;
    _forcePressRecognizer.onEnd = _handleForcePressOnEnd;
  }

  @override
  void dispose(){
    _longPressRecognizer.dispose();
    _forcePressRecognizer.dispose();
  }
  void _handlePress(){
    HapticFeedback.vibrate();
  }
  void _handleForcePressOnStart(ForcePressDetails fpd){
    HapticFeedback.vibrate();
  }
  void _handleForcePressOnUpdate(ForcePressDetails fpd){
    setState(() {
      pressure = fpd.pressure;
    });
  }
  void _handleForcePressOnEnd(ForcePressDetails fpd){
    HapticFeedback.vibrate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          Text("pressure: " + pressure.toStringAsFixed(2)),
          Center(
            child: Container(
              width: (250 * pressure) + 50,
              height: (250 * pressure) + 100,
              decoration: const BoxDecoration(
                color: Colors.redAccent,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text.rich(
                  TextSpan(
                    text: "press",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    recognizer: _forcePressRecognizer,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}


