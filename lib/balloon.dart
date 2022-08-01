import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


class Balloon extends StatefulWidget {
  const Balloon({Key? key, this.pressure = 0.0, required this.onChanged}) : super(key: key);

  final double pressure;
  final ValueChanged<double> onChanged;

  @override
  State<Balloon> createState() => _BalloonState();
}

class _BalloonState extends State<Balloon> {

  double _pressure = 0.0;
  ForcePressGestureRecognizer _forcePressRecognizer = ForcePressGestureRecognizer();
  String _imageUrl = 'assets/images/Balloon_S.png';

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
      }else if(_pressure < 0.8){
        _imageUrl = 'assets/images/Balloon_M.png';
      }else{
        _imageUrl = 'assets/images/Balloon_L.png';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
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
        )
    );
  }
}