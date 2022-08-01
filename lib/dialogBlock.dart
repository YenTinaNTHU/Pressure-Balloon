import 'package:flutter/material.dart';

class DialogBlock extends StatelessWidget {
  DialogBlock({Key? key, this.pressure = 0.1}) : super(key: key);

  final double pressure;

  final List<String> dialog = [
    'Press me',
    'Press me harder',
    'Too...too hard!!!',
    'Nice',
    'Close your eyes and relax.'
  ];

  @override
  Widget build(BuildContext context) {
    int state = 0;
    if (pressure / 1.0 <= 0.0) {
      state = 0;
    } else if (pressure / 1.0 < 0.4) {
      state = 1;
    } else if (pressure / 1.0 >= 0.4 && pressure / 1.0 <= 0.8) {
      state = 3;
    } else if (pressure / 1.0 > 0.8) {
      state = 2;
    }
    return Stack(alignment: Alignment.center, children: <Widget>[
      Image.asset('assets/images/block.png'),
      Text(dialog[state])
    ]);
  }
}
