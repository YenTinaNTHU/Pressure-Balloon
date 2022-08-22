import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/parameters.dart';
import 'package:my_app/recordPage.dart';
import 'package:my_app/ripples.dart';

import 'SettingPage.dart';

class TutorialPage extends StatefulWidget {
  const TutorialPage({Key? key}) : super(key: key);

  @override
  State<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  double _pressure = 0.0;
  TutorialStatus _status = TutorialStatus.intro;
  int _milliSeconds = maxMilliSeconds;

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
                  TutorialDialog(status: _status,),
                  NextBtn(updateStatus: _updateStatus,),
                ],
              ),
            ),
            Spacer(flex: 3),
            Expanded(
                flex: 40,
                child:Center(
                  child: Stack(
                    children: [
                      _pressure < 0.3 ? Center(
                        child: Ripples(
                          minRadius: 50,
                          radius: 300,
                          spreadColor: const Color(0xffF49E9E),
                          pressure: _pressure,
                        ),
                      ) : Container(),
                      TutorialBalloon(),
                    ],
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}

class TutorialDialog extends StatelessWidget {
  TutorialDialog({Key? key, this.status = TutorialStatus.intro}) : super(key: key);
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
  const NextBtn({Key? key, required this.updateStatus}) : super(key: key);
  final ValueChanged<TutorialStatus> updateStatus;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 40),
      child: TextButton(
        onPressed: () => {updateStatus(TutorialStatus.init)},
        child: const Text(
          ">>NEXT",
          textAlign: TextAlign.right,
          style: TextStyle(decoration: TextDecoration.underline, color: Color(0xffD77B7B)),
        ),
      ),
    );
  }
}

class TutorialBalloon extends StatefulWidget {
  const TutorialBalloon({
    Key? key,
  }) : super(key: key);


  @override
  State<TutorialBalloon> createState() => _TutorialBalloonState();
}

class _TutorialBalloonState extends State<TutorialBalloon> {
  double _pressure = 0.0;
  ForcePressGestureRecognizer _forcePressRecognizer = ForcePressGestureRecognizer();
  @override
  void initState(){
    super.initState();
    _forcePressRecognizer = ForcePressGestureRecognizer(startPressure: 0.0, peakPressure: 1.0);
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Balloon: $_pressure"));
  }
}


