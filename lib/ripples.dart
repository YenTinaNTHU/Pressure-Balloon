import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_app/parameters.dart';

class Ripples extends StatefulWidget {
  Ripples({
    this.child,
    required this.radius,
    required this.minRadius,
    this.pressure = 0.0,
    this.spreadColor = Colors.grey,
    this.duration = const Duration(milliseconds: 4000),
  });

  final Widget? child;
  final double radius;
  final double minRadius;
  final double pressure;
  final Color spreadColor;
  final Duration duration;

  @override
  _RipplesState createState() => _RipplesState();
}

class _RipplesState extends State<Ripples> with TickerProviderStateMixin {
  List<Widget> children = [];
  List<AnimationController> controllers = [];

  @override
  void initState() {
    super.initState();
    if (widget.child != null) {
      children.add(
        ClipOval(
          child: SizedBox(
            width: widget.radius,
            height: widget.radius,
            child: widget.child,
          ),
        ),
      );
    }
    start();
  }

  start() async {
    while (true) {
      if (mounted) {
        setState(() {
          AnimationController _animationController;
          Animation<double> _animation;

          _animationController =
              AnimationController(vsync: this, duration: widget.duration);
          _animation = CurvedAnimation(
              parent: _animationController, curve: Curves.linear);

          _animationController.addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              //動畫完成
              children.removeAt(0);
              controllers.removeAt(0);
              _animationController.dispose();
            }
          });
          controllers.add(_animationController);
          _animationController.forward(); //啟動動畫

          widget.child != null
              ? children.insert(
                  children.length - 1,
                  Circle(
                    animation: _animation,
                    radius: widget.radius,
                    minRadius: widget.minRadius,
                    color: widget.spreadColor,
                  ))
              : children.add(Circle(
                  animation: _animation,
                  radius: widget.radius,
                  minRadius: widget.minRadius,
                  color: widget.spreadColor,
                ));
        });
      }
      await Future.delayed(//出現第二個圓的時間
          Duration(milliseconds: widget.duration.inMilliseconds ~/ 4));
    }
  }

  @override
  void dispose() {
    controllers.forEach((c) {
      c.dispose();
      //c = null;
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: children,
    );
  }
}

class Circle extends AnimatedWidget {
  final Tween<double> _opacityTween = Tween(begin: 0, end: 1);
  final Tween<double> _radiusTween;
  final Color color;
  Circle(
      {Key? key,
      required Animation<double> animation,
      required double radius,
      required double minRadius,
      required this.color})
      : _radiusTween = Tween(begin: radius, end: minRadius),
        super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    return SizedBox(
      width: _radiusTween.evaluate(animation),
      height: _radiusTween.evaluate(animation),
      child: ClipOval(
        child: Opacity(
          opacity: _opacityTween.evaluate(animation),
          child: Container(
            color: color,
          ),
        ),
      ),
    );
  }
}
