import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:my_app/holdingCircle.dart';
import 'package:my_app/parameters.dart';

class Balloon extends StatefulWidget {
  const Balloon({
    Key? key,
    this.pressure = 0.0,
    this.status = Status.beforeSleep,
    this.milliseconds = maxMilliSeconds,
    required this.updatePressure,
    required this.updateStatus,
    required this.setRemainMilliseconds,
  }) : super(key: key);

  final double pressure;
  final ValueChanged<double> updatePressure;
  final Status status;
  final ValueChanged<Status> updateStatus;
  final int milliseconds;
  final ValueChanged<int> setRemainMilliseconds;

  @override
  State<Balloon> createState() => _BalloonState();
}

class _BalloonState extends State<Balloon> with SingleTickerProviderStateMixin{

  double _pressure = 0.0;
  String _imageUrl = 'assets/images/Balloon_S.png';
  Pressure _pressureStatus = Pressure.small;

  Duration _elapsed = Duration.zero;
  late final _ticker = createTicker((elapsed) {
    setState(() {
      _elapsed = elapsed;
      if (widget.milliseconds > 0) {
        widget.setRemainMilliseconds(maxMilliSeconds - elapsed.inMilliseconds);
      }else{
        _stopTimer(reset: false);
        if(widget.status == Status.beforeSleep || widget.status == Status.awake) widget.updateStatus(widget.status);
      }
    } );
  });

  ForcePressGestureRecognizer _forcePressRecognizer = ForcePressGestureRecognizer();

  @override
  void initState() {
    super.initState();
    _forcePressRecognizer = ForcePressGestureRecognizer(startPressure: 0.0, peakPressure: 1.0);
    _forcePressRecognizer.onUpdate = _handleForcePressOnUpdate;
  }
  @override
  void dispose() {
    _forcePressRecognizer.dispose();
    _ticker.dispose();
    super.dispose();
  }
  void _handleForcePressOnUpdate(ForcePressDetails fpd){
    Pressure prePressureStatus = _pressureStatus;
    // update pressure and pressure status
    setState(() {
      _pressure = fpd.pressure;
      widget.updatePressure(fpd.pressure);
      if(_pressure < smallPressureThreshold){
        _pressureStatus = Pressure.small;
      }else if(_pressure < bigPressureThreshold){
        _pressureStatus = Pressure.medium;
      }else{
        _pressureStatus = Pressure.big;
      }
    });

    // update status (and timer, since we control status with timer)
    // before sleep & awake -> update status at timer == 0
    // sleeping -> update status at _pressure < awakePressureThreshold
    if(widget.status == Status.beforeSleep || widget.status == Status.awake){
      if(_pressureStatus == Pressure.small && prePressureStatus == Pressure.medium){
        _stopTimer(reset: true);
      }
      if(_pressureStatus == Pressure.medium && prePressureStatus != Pressure.medium){
        _startTimer(reset: true);
      }
      if(_pressureStatus == Pressure.big && prePressureStatus == Pressure.medium){
        _stopTimer(reset: true);
      }
    } else { // widget.status == Status.sleeping
      if(_pressure < awakePressureThreshold) widget.updateStatus(widget.status);
    }

    // update image
    if(_pressureStatus == Pressure.small){
      setState(() => _imageUrl = 'assets/images/Balloon_S.png');
    }else if(_pressureStatus == Pressure.medium){
      setState(() => _imageUrl = 'assets/images/Balloon_M.png');
    }else{ // _pressureStatus == Pressure.big
      setState(() => _imageUrl = 'assets/images/Balloon_L.png');
    }

  }

  // Timer(Ticker) Control
  void _resetTimer() {
    widget.setRemainMilliseconds(maxMilliSeconds);
    setState(() => _elapsed = Duration.zero);
  }
  void _startTimer({bool reset = true}){
    if (reset) _resetTimer();
    _ticker.start();
  }
  void _stopTimer({bool reset = true}){
    if (reset) _resetTimer();
    _ticker.stop(canceled: true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child:
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/Rope.png',
                    fit: BoxFit.contain,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    _imageUrl,
                    fit: BoxFit.fitHeight,
                    width: (250 * _pressure) + 50,
                    height: (250 * _pressure) + 50,
                  ),
                ),
                Center(
                  child: Text.rich(
                    TextSpan(
                      text: "press",
                      style: const TextStyle(
                        color: Colors.transparent,
                      ),
                      recognizer: _forcePressRecognizer,
                    ),
                  ),
                ),
                ]
            ),
    );
  }
}