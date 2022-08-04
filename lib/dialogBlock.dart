import 'package:flutter/material.dart';
import 'package:my_app/parameters.dart';

class DialogBlock extends StatelessWidget {
  DialogBlock({Key? key, this.pressure = 0.1, this.state = Status.beforeSleep})
      : super(key: key);

  final double pressure;
  final Status state;

  final List<String> dialog = [
    'Press me',
    'Press me harder',
    'Too...too hard!!!',
    'Nice',
    'Close your eyes and relax.',
    'EUREKA MOMENT!'
  ];

  @override
  Widget build(BuildContext context) {
    int id = 0;
    if (pressure / 1.0 <= 0.0) {
      id = 0;
    } else if (pressure / 1.0 < 0.4) {
      id = 1;
    } else if (pressure / 1.0 >= 0.4 &&
        pressure / 1.0 <= 0.8 &&
        state == Status.beforeSleep) {
      id = 3;
    } else if (pressure / 1.0 >= 0.4 &&
        pressure / 1.0 <= 0.8 &&
        state == Status.sleeping) {
      id = 4;
    } else if (pressure / 1.0 > 0.8) {
      id = 2;
    } else if (state == Status.awake) {
      id = 5;
    }
    return Stack(alignment: Alignment.center, children: <Widget>[
      Image.asset('assets/images/block.png'),
      Text(dialog[id])
    ]);
  }
}