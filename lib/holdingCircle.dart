import 'package:flutter/material.dart';

class HoldingCircle extends StatefulWidget {
  const HoldingCircle({Key? key}) : super(key: key);

  @override
  State<HoldingCircle> createState() => _HoldingCircleState();
}

class _HoldingCircleState extends State<HoldingCircle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
    );
  }
}