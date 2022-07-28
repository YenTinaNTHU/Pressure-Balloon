import 'package:flutter/material.dart';

class DialogBlock extends StatefulWidget {
  const DialogBlock({Key? key}) : super(key: key);

  @override
  State<DialogBlock> createState() => _DialogBlockState();
}

class _DialogBlockState extends State<DialogBlock> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
    );
  }
}