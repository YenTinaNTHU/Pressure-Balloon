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
    if (pressure / 1.0 <= 0.0 && state == Status.beforeSleep) {
      id = 0;
    } else if (pressure / 1.0 < smallPressureThreshold && state == Status.beforeSleep) {
      id = 1;
    } else if (pressure / 1.0 >= smallPressureThreshold &&
        pressure / 1.0 <= bigPressureThreshold &&
        state == Status.beforeSleep) {
      id = 3;
    } else if (pressure / 1.0 > bigPressureThreshold && state == Status.beforeSleep) {
      id = 2;
    } else if (state == Status.sleeping) {
      id = 4;
    } else if (state == Status.awake) {
      id = 5;
    }
    return Stack(alignment: Alignment.center, children: <Widget>[
      //Image.asset('assets/images/block.png'),
      Text(dialog[id], style: TextStyle(color: (state == Status.sleeping) ? Colors.white : Color(0xff2f2f2f)))
    ]);
  }
}
