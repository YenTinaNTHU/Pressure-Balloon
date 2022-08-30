import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/recordPage.dart';
import 'package:my_app/settingPage.dart';
import 'package:my_app/balloon.dart';
import 'package:my_app/dialogBlock.dart';
import 'package:my_app/forceBar.dart';
import 'package:my_app/holdingCircle.dart';
import 'package:my_app/pressureFrame.dart';
import 'package:my_app/parameters.dart';
import 'package:my_app/ripples.dart';
import 'package:audioplayers/audioplayers.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _pressure = 0.0;
  Status _status = Status.beforeSleep;
  int _milliSeconds = maxMilliSeconds;
  AudioPlayer audioPlayer = AudioPlayer();
  AssetSource source = AssetSource('audios/sleepMusic.mp3');

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

  void _updateStatus(Status newStatus) {
    HapticFeedback.mediumImpact();
    if (newStatus == Status.sleeping) {
      audioPlayer.play(source, volume: 0.5);
    } else {
      audioPlayer.stop();
    }
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
        color: (_status == Status.sleeping) ? Color(0xFF494949) : Colors.white,
        duration: Duration(milliseconds: 1000),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 15,
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
                  Spacer(flex: 4),
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
              flex: 5,
              child: DialogBlock(pressure: _pressure, state: _status),
            ),
            Spacer(flex: 1),
            Expanded(
              flex: 2,
              child: _status != Status.sleeping
                  ? HoldingCircle(
                      milliSeconds: _milliSeconds,
                    )
                  : Container(),
            ),
            Spacer(flex: 3),
            Expanded(
                flex: 40,
                child: Center(
                  child: Stack(
                    children: [
                      _pressure < 0.3
                          ? Center(
                              child: Ripples(
                                minRadius: 50,
                                radius: 300,
                                spreadColor: const Color(0xffF49E9E),
                                pressure: _pressure,
                              ),
                            )
                          : (_status != Status.awake)
                              ? Center(
                                  child: Image.asset(
                                      "assets/images/Ellipse_01.png"))
                              : Container(),
                      Balloon(
                        pressure: _pressure,
                        updatePressure: _handlePressureChanged,
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
