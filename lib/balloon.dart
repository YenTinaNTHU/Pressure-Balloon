import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/endingPage.dart';
import 'package:my_app/parameters.dart';
import 'package:rive/rive.dart';

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

class _BalloonState extends State<Balloon> with SingleTickerProviderStateMixin {
  double _pressure = 0.0;
  String _imageUrl = 'assets/images/initBalloon_0.png';
  Pressure _pressureStatus = Pressure.small;
  ForcePressGestureRecognizer _forcePressRecognizer = ForcePressGestureRecognizer();
  late Timer _timer;
  Duration _elapsed = Duration.zero;
  late final _ticker = createTicker((elapsed) {
    setState(() {
      _elapsed = elapsed;
      if (widget.milliseconds > 0) {
        widget.setRemainMilliseconds(maxMilliSeconds - elapsed.inMilliseconds);
      } else {
        _stopTimer(reset: true);
        if (widget.status == Status.beforeSleep) {
          widget.updateStatus(Status.sleeping);
        }
        if (widget.status == Status.awake) {
          _timer.cancel();
          Navigator.push(context, MaterialPageRoute(builder: (_) => const EndingPage()));
        }
      }
    });
  });

  @override
  void initState() {
    super.initState();
    // int _counter = 5;
    _forcePressRecognizer =
        ForcePressGestureRecognizer(startPressure: 0.0, peakPressure: 1.0);
    _forcePressRecognizer.onUpdate = _handleForcePressOnUpdate;
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (widget.status == Status.awake) {
        HapticFeedback.vibrate();
        // setState(() => _counter--);
      }
    });
  }

  @override
  void dispose() {
    _forcePressRecognizer.dispose();
    _ticker.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _handleForcePressOnUpdate(ForcePressDetails fpd) {
    Pressure prePressureStatus = _pressureStatus;
    // update pressure and pressure status
    setState(() {
      _pressure = fpd.pressure;
      widget.updatePressure(fpd.pressure);
      if (_pressure < smallPressureThreshold) {
        _pressureStatus = Pressure.small;
      } else if (_pressure < bigPressureThreshold) {
        _pressureStatus = Pressure.medium;
      } else {
        _pressureStatus = Pressure.big;
      }
    });
    // update status (and timer, since we control status with timer)
    // before sleep & awake -> update status at timer == 0
    // sleeping -> update status at _pressure < awakePressureThreshold
    if (widget.status == Status.beforeSleep || widget.status == Status.awake) {
      if (_pressureStatus == Pressure.small && prePressureStatus == Pressure.medium) {
        _stopTimer(reset: true);
        print("small");
      }
      if (_pressureStatus == Pressure.medium && prePressureStatus != Pressure.medium) {
        _startTimer(reset: true);
        print("medium");
      }
      if (_pressureStatus == Pressure.big && prePressureStatus == Pressure.medium) {
        _stopTimer(reset: true);
        print("big");
      }
    } else {
      // widget.status == Status.sleeping
      if (_pressure < awakePressureThreshold) widget.updateStatus(Status.awake);
    }

    // update image
    if (widget.status == Status.beforeSleep) {
      if (_pressureStatus == Pressure.small) {
        setState(() => _imageUrl = 'assets/images/smallBalloon.png');
      } else if (_pressureStatus == Pressure.medium) {
        setState(() => _imageUrl = 'assets/images/normalBalloon.png');
      } else {
        // _pressureStatus == Pressure.big
        setState(() => _imageUrl = 'assets/images/bigBalloon.png');
      }
    } else if (widget.status == Status.sleeping) {
      setState(() => _imageUrl = 'assets/images/sleepingBalloon.png');
    } else {
      // widget.status == Status.awake
      if (_pressureStatus == Pressure.big) {
        setState(() => _imageUrl = 'assets/images/bigBalloon.png');
      } else {
        setState(() => _imageUrl = 'assets/images/awakeBalloon.png');
      }
    }
  }

  // Timer(Ticker) Control
  void _resetTimer() {
    widget.setRemainMilliseconds(maxMilliSeconds);
    setState(() => _elapsed = Duration.zero);
  }

  void _startTimer({bool reset = true}) {
    if (reset) _resetTimer();
    _ticker.start();
  }

  void _stopTimer({bool reset = true}) {
    if (reset) _resetTimer();
    _ticker.stop(canceled: true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(alignment: Alignment.center, children: <Widget>[
        buildEurekaEffect(),
        buildBalloon(),
        buildForcePressRecognizer(),
      ]),
    );
  }

  // ========= build widget =========
  Widget buildEurekaEffect() => Stack(
        alignment: Alignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            width: double.infinity * 0.5,
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 500),
              opacity: (widget.status == Status.awake &&
                      _pressureStatus == Pressure.small)
                  ? 1.0
                  : 0.0,
              child: const RiveAnimation.asset(
                'assets/animates/Party_Effect.riv',
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: (250 * _pressure) + 50,
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 500),
              opacity: (widget.status == Status.awake &&
                      _pressureStatus != Pressure.big)
                  ? 1.0
                  : 0.0,
              child: const RiveAnimation.asset(
                'assets/animates/Eureka_Effect.riv',
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
      );
  Widget buildBalloon() => Stack(
        alignment: Alignment.center,
        children: [
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
        ],
      );
  Widget buildForcePressRecognizer() => Center(
        child: Text.rich(
          TextSpan(
            text: "press",
            style: const TextStyle(color: Colors.transparent, fontSize: 100),
            recognizer: _forcePressRecognizer,
          ),
        ),
      );
}
