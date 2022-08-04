import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_app/holdingCircle.dart';
import 'package:my_app/parameters.dart';

class Balloon extends StatefulWidget {
  const Balloon({
    Key? key,
    this.pressure = 0.0,
    this.status = Status.beforeSleep,
    this.milliseconds = maxMilliSeconds,
    required this.onChanged,
    required this.updateStatus,
    required this.setRemainMilliseconds,
  }) : super(key: key);

  final double pressure;
  final ValueChanged<double> onChanged;
  final Status status;
  final ValueChanged<Status> updateStatus;
  final int milliseconds;
  final ValueChanged<int> setRemainMilliseconds;

  @override
  State<Balloon> createState() => _BalloonState();
}

class _BalloonState extends State<Balloon> {

  double _pressure = 0.0;
  ForcePressGestureRecognizer _forcePressRecognizer = ForcePressGestureRecognizer();
  String _imageUrl = 'assets/images/Balloon_S.png';

  Timer? _timer; //timer may be null
  Pressure _pressureStatus = Pressure.small;

  @override
  void initState() {
    super.initState();
    _forcePressRecognizer = ForcePressGestureRecognizer(startPressure: 0.1, peakPressure: 1.0);
    _forcePressRecognizer.onUpdate = _handleForcePressOnUpdate;
  }

  void _handleForcePressOnUpdate(ForcePressDetails fpd){
    setState(() {
      _pressure = fpd.pressure;
      widget.onChanged(fpd.pressure);
      if(_pressure < 0.3){
        _imageUrl = 'assets/images/Balloon_S.png';
        if(_pressureStatus!= Pressure.small){
          if(widget.status == Status.sleeping) {
            widget.updateStatus(widget.status);
            stopTimer(reset: true);
          }else{
            stopTimer(reset: true);
          }
        }
        _pressureStatus = Pressure.small;
      }else if(_pressure < 0.8){
        _imageUrl = 'assets/images/Balloon_M.png';
        if(_pressureStatus != Pressure.medium){
          if(widget.status != Status.sleeping){
            stopTimer(reset: true);
            startTimer(reset: true);
          }
        }
        _pressureStatus = Pressure.medium;

      }else{
        _imageUrl = 'assets/images/Balloon_L.png';
        if(_pressureStatus!=Pressure.big){
          if(widget.status != Status.sleeping) stopTimer(reset: true);
        }
        _pressureStatus = Pressure.big;
      }
    });
  }

  void resetTimer() {
    widget.setRemainMilliseconds(maxMilliSeconds);
  }

  void startTimer({bool reset = true}){
    if (reset) {
      resetTimer();
    }
    _timer = Timer.periodic(Duration(milliseconds: 1), (timer) {
      if (widget.milliseconds > 0) {
        widget.setRemainMilliseconds(widget.milliseconds-1);
      }else{
        stopTimer(reset: false);
        if(widget.status == Status.beforeSleep || widget.status == Status.awake) widget.updateStatus(widget.status);
      }
    });
  }

  void stopTimer({bool reset = true}){
    if (reset) {
      resetTimer();
    }
    setState(() => _timer?.cancel());
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