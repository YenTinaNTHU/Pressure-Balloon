import 'package:flutter/material.dart';


class Balloon extends StatefulWidget {
  const Balloon({Key? key}) : super(key: key);

  @override
  State<Balloon> createState() => _BalloonState();
}

class _BalloonState extends State<Balloon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.redAccent,
          shape: BoxShape.circle
      ),
      child: Center(
        child: Text("Balloon",style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.normal,
          height: 1.2,
        ),),
      ),
    );
  }
}