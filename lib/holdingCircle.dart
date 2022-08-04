import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_app/parameters.dart';

class HoldingCircle extends StatefulWidget {
  final int milliSeconds;
  final Status status;

  const HoldingCircle(
      {Key? key,
      this.milliSeconds = maxMilliSeconds,
      this.status = Status.beforeSleep})
      : super(key: key);

  @override
  State<HoldingCircle> createState() => _HoldingCircleState();
}

class _HoldingCircleState extends State<HoldingCircle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: buildTimer(),
    );
  }

  Widget buildTimer() => SizedBox(
        width: 30,
        height: 30,
        child: Stack(fit: StackFit.expand, children: [
          CircularProgressIndicator(
            value: 1 - widget.milliSeconds / maxMilliSeconds,
            valueColor: AlwaysStoppedAnimation(Color(0xffffbdbd)),
            backgroundColor: Color(0xffe9e9e9),
            strokeWidth: 5,
          ),
          Center(
            child: buildTime(widget.status),
          ),
        ]),
      );

  Widget buildTime(Status status) {
    if (widget.milliSeconds == 0) {
      return Icon(
        Icons.done,
        color: Color(0xffffbdbd),
        size: 12,
      );
    } else {
      return Text(
        '${(widget.milliSeconds / 1000).ceil()}',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: (status == Status.sleeping)
              ? Color(0xff2f2f2f)
              : Colors.transparent,
          fontSize: 12,
        ),
      );
    }
  }
}
