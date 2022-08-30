import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_app/holdingCircle.dart';
import 'package:my_app/parameters.dart';
import 'package:my_app/record.dart';
import 'package:my_app/recordPage.dart';
import 'package:my_app/ripples.dart';

import 'SettingPage.dart';
import 'homePage.dart';

class TutorialPage extends StatefulWidget {
  const TutorialPage({Key? key}) : super(key: key);

  @override
  State<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  double _pressure = 0.0;
  TutorialStatus _status = TutorialStatus.intro;
  int _milliSeconds = tutorialMaxMilliseconds;
  bool _isSetting = false;

  void _handlePressureChanged(double newPressure) {
    setState(() {
      _pressure = newPressure;
    });
  }

  void _setRemainMilliSeconds(int newMilliSeconds) {
    setState(() {
      _milliSeconds = newMilliSeconds;
    });
  }

  void _updateStatus(TutorialStatus newStatus) {
    HapticFeedback.mediumImpact();
    setState(() {
      _status = newStatus;
    });
    if (_status == TutorialStatus.setBigPressureThreshold ||
        _status == TutorialStatus.setSmallPressureThreshold) {
      setState(() {
        _isSetting = true;
      });
    } else {
      setState(() {
        _isSetting = false;
      });
    }
  }

  void _handleSettingIconPressed() {
    print("pressed");
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const SettingPage()));
  }

  void _handleEditIconPressed() {
    print("pressed");
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const RecordPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(milliseconds: 1000),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: IconButton(
                        alignment: Alignment.topCenter,
                        padding: const EdgeInsets.fromLTRB(20, 50, 0, 0),
                        color: Colors.grey,
                        iconSize: 30,
                        icon: const Icon(
                          Icons.edit_note_rounded,
                        ),
                        onPressed: () {
                          _handleEditIconPressed();
                        },
                      ),
                    ),
                  ),
                  Spacer(flex: 12),
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: IconButton(
                        alignment: Alignment.topCenter,
                        padding: const EdgeInsets.fromLTRB(0, 50, 20, 0),
                        color: Colors.grey,
                        iconSize: 30,
                        icon: const Icon(
                          Icons.settings_rounded,
                        ),
                        onPressed: () {
                          _handleSettingIconPressed();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(flex: 3),
            Expanded(
              flex: 20,
              child: Column(
                children: [
                  TutorialDialog(
                    status: _status,
                  ),
                  _isSetting
                      ? TutorialHoldingBar(
                          milliSeconds: _milliSeconds,
                        )
                      : _status == TutorialStatus.init
                          ? Container()
                          : NextBtn(
                              status: _status,
                              updateStatus: _updateStatus,
                            ),
                ],
              ),
            ),
            Spacer(flex: 3),
            Expanded(
                flex: 40,
                child: Center(
                  child: Stack(
                    children: [
                      _status == TutorialStatus.init
                          ? Center(
                              child: Ripples(
                                minRadius: 50,
                                radius: 300,
                                spreadColor: const Color(0xffF49E9E),
                                pressure: _pressure,
                              ),
                            )
                          : Container(),
                      TutorialBalloon(
                        status: _status,
                        updateStatus: _updateStatus,
                        milliseconds: _milliSeconds,
                        setRemainMilliseconds: _setRemainMilliSeconds,
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class TutorialDialog extends StatelessWidget {
  TutorialDialog({Key? key, this.status = TutorialStatus.intro})
      : super(key: key);
  final TutorialStatus status;
  @override
  Widget build(BuildContext context) {
    final List<String> dialogs = [
      'Hi, I am OOO, a balloon that can help you wake up at creativity sweet spot.',
      'Put your thumb here.',
      'Press me a little harder.',
      'Press me as hard as you can!',
      'Finish setting, it’s time to find out your EUREKA moment.',
    ];
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 20, 50, 0),
      child: Center(
        child: Text(
          dialogs[this.status.index],
          style: TextStyle(color: Color(0xff2f2f2f)),
        ),
      ),
    );
  }
}

class NextBtn extends StatelessWidget {
  const NextBtn({Key? key, required this.status, required this.updateStatus})
      : super(key: key);
  final ValueChanged<TutorialStatus> updateStatus;
  final TutorialStatus status;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 40),
      child: TextButton(
        onPressed: () => {
          if (status == TutorialStatus.intro)
            {updateStatus(TutorialStatus.init)}
          else if (status == TutorialStatus.finishSetting)
            {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const HomePage()))
            }
        },
        child: const Text(
          ">>NEXT",
          textAlign: TextAlign.right,
          style: TextStyle(
              decoration: TextDecoration.underline, color: Color(0xffD77B7B)),
        ),
      ),
    );
  }
}

class TutorialBalloon extends StatefulWidget {
  const TutorialBalloon({
    Key? key,
    this.status = TutorialStatus.init,
    this.milliseconds = tutorialMaxMilliseconds,
    required this.updateStatus,
    required this.setRemainMilliseconds,
  }) : super(key: key);

  final TutorialStatus status;
  final ValueChanged<TutorialStatus> updateStatus;
  final int milliseconds;
  final ValueChanged<int> setRemainMilliseconds;
  @override
  State<TutorialBalloon> createState() => _TutorialBalloonState();
}

class _TutorialBalloonState extends State<TutorialBalloon> with SingleTickerProviderStateMixin {
  String _imageUrl = 'assets/images/normalBalloon_01.png';
  double _pressure = 0.0;
  ForcePressGestureRecognizer _forcePressRecognizer =
      ForcePressGestureRecognizer();

  Duration _elapsed = Duration.zero;
  late final _ticker = createTicker((elapsed) {
    setState(() {
      _elapsed = elapsed;
      if (widget.milliseconds > 0) {
        widget.setRemainMilliseconds(tutorialMaxMilliseconds - elapsed.inMilliseconds);
      } else {
        _stopTimer(reset: true);
        if (widget.status == TutorialStatus.setSmallPressureThreshold) {
          widget.updateStatus(TutorialStatus.setBigPressureThreshold);
          _startTimer(reset: true);
        }
        if (widget.status == TutorialStatus.setBigPressureThreshold) {
          widget.updateStatus(TutorialStatus.finishSetting);
        }
      }
    });
  });

  @override
  initState() {
    super.initState();
    _forcePressRecognizer =
        ForcePressGestureRecognizer(startPressure: 0.0, peakPressure: 1.0);
    _forcePressRecognizer.onUpdate = _handleForcePressOnUpdate;
  }

  @override
  void dispose() {
    _forcePressRecognizer.dispose();
    super.dispose();
  }

  void _handleForcePressOnUpdate(ForcePressDetails fpd) {
    setState(() {
      _pressure = fpd.pressure;
      if (widget.status == TutorialStatus.init) {
        if (_pressure > 0.30) {
          widget.updateStatus(TutorialStatus.setSmallPressureThreshold);
          if (!_ticker.isActive) _startTimer(reset: true);
        }
      } else if (widget.status == TutorialStatus.setSmallPressureThreshold) {
        // record the smallPressureThreshold
        // TODO: more accurate method
        smallPressureThreshold = 0.3;
        box.put('smallPressureThreshold', smallPressureThreshold);
      } else if (widget.status == TutorialStatus.setBigPressureThreshold) {
        // record the bigPressureThreshold
        // TODO: more accurate method
        bigPressureThreshold = 1.0;
        box.put('bigPressureThreshold', bigPressureThreshold);
        if(_pressure < smallPressureThreshold){
          // reset Timer
          if(_ticker.isActive) _stopTimer(reset: true);
        }else{
          if(!_ticker.isActive) _startTimer();
        }
      } else {
        // do nothing
      }
    });
  }

  // Timer(Ticker) Control
  void _resetTimer() {
    widget.setRemainMilliseconds(tutorialMaxMilliseconds);
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
        buildBalloon(),
        buildForcePressRecognizer(),
      ]),
    );
  }

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
              getImageUrl(),
              fit: BoxFit.fitHeight,
              width: 150,
              height: 150,
            ),
          ),
        ],
      );

  Widget buildForcePressRecognizer() => Center(
        child: Text.rich(
          TextSpan(
            text: _pressure.toStringAsFixed(2),
            style: const TextStyle(color: Colors.transparent, fontSize: 100),
            recognizer: _forcePressRecognizer,
          ),
        ),
      );

  String getImageUrl(){
    _imageUrl = "";
    switch(widget.status){
      case TutorialStatus.intro:
        _imageUrl = 'assets/images/normalBalloon_01.png'; break;
      case TutorialStatus.init:
        _imageUrl = 'assets/images/initBalloon_0.png'; break;
      case TutorialStatus.setSmallPressureThreshold:
        _imageUrl = 'assets/images/normalBalloon.png'; break;
      case TutorialStatus.setBigPressureThreshold:
        _imageUrl = 'assets/images/initBalloon_2.png'; break;
      case TutorialStatus.finishSetting:
        _imageUrl = 'assets/images/awakeBalloon_1.png'; break;
    }
    return _imageUrl;
  }
}

class TutorialHoldingBar extends StatefulWidget {
  final int milliSeconds;
  const TutorialHoldingBar(
      {Key? key, this.milliSeconds = tutorialMaxMilliseconds,}) : super(key: key);
  @override
  State<TutorialHoldingBar> createState() => _TutorialHoldingBarState();
}

class _TutorialHoldingBarState extends State<TutorialHoldingBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: buildTimer(),
    );
  }

  Widget buildTimer() => SizedBox(
    height: 20,
    width: 250,
    child: Stack(fit: StackFit.expand, children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: LinearProgressIndicator(
          value:
          1 - widget.milliSeconds / tutorialMaxMilliseconds, // percent filled
          valueColor: AlwaysStoppedAnimation(Color(0xffffbdbd)),
          backgroundColor: Color(0xffe9e9e9),
        ),
      )
    ]),
  );
}
