import 'package:flutter/material.dart';
import 'package:my_app/parameters.dart';

class PressureFrame extends StatelessWidget {
  PressureFrame(
      {Key? key, this.pressure = 0.0, this.status = Status.beforeSleep})
      : super(key: key);
  double pressure;
  Status status;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Spacer(flex: 3),
        const Text(
          "Pressure",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 32.0,
            fontWeight: FontWeight.normal,
            height: 1.2,
          ),
        ),
        Spacer(flex: 2),
        Text("${(pressure / 1.0 * 100).toStringAsFixed(0)}%",
            style: const TextStyle(
              color: Color(0xffd77b7b),
              fontSize: 50.0,
              fontWeight: FontWeight.normal,
            )),
      ],
    ));
  }
}
