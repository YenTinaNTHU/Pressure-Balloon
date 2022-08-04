import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_app/parameters.dart';


class HoldingCircle extends StatefulWidget {
  final int milliSeconds;

  const HoldingCircle({
    Key? key,
    this.milliSeconds = maxMilliSeconds
  }) : super(key: key);

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
    child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: 1 - widget.milliSeconds / maxMilliSeconds,
            valueColor: AlwaysStoppedAnimation(Colors.black),
            backgroundColor: Colors.grey,
            strokeWidth: 5,
          ),
          Center(
            child: buildTime(),
          ),
        ]
    ),
  );

  Widget buildTime() {
    if(widget.milliSeconds == 0){
      return Icon(Icons.done, color: Colors.black, size: 12,);
    }else{
      return Text(
        '${(widget.milliSeconds/1000).ceil()}',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 12,
        ),
      );
    }
  }
}

