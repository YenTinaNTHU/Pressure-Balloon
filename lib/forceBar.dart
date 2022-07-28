
import 'package:flutter/cupertino.dart';

class ForceBar extends StatelessWidget {
  ForceBar({Key? key, this.pressure = 0.0}) : super(key: key);

  final double pressure;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Progress bar
            SizedBox(
                width: 256,
                height: 34,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 34,
                      height: 34,
                      color: (pressure < 1.0 / 7.0)
                          ? const Color(0xffe9e9e9)
                          : const Color(0xffffdfdf),
                    ),
                    Container(
                      width: 34,
                      height: 34,
                      color: (pressure < 2.0 / 7.0)
                          ? const Color(0xffe9e9e9)
                          : const Color(0xffffbdbd),
                    ),
                    Container(
                      width: 34,
                      height: 34,
                      color: (pressure < 3.0 / 7.0)
                          ? const Color(0xffe9e9e9)
                          : const Color(0xfff49e9e),
                    ),
                    Container(
                      width: 34,
                      height: 34,
                      color: (pressure < 4.0 / 7.0)
                          ? const Color(0xffe9e9e9)
                          : const Color(0xffd77b7b),
                    ),
                    Container(
                      width: 34,
                      height: 34,
                      color: (pressure < 5.0 / 7.0)
                          ? const Color(0xffe9e9e9)
                          : const Color(0xffbd5b5b),
                    ),
                    Container(
                      width: 34,
                      height: 34,
                      color: (pressure < 6.0 / 7.0)
                          ? const Color(0xffe9e9e9)
                          : const Color(0xff9f4949),
                    ),
                    Container(
                      width: 34,
                      height: 34,
                      color: (pressure < 1.0)
                          ? const Color(0xffe9e9e9)
                          : const Color(0xff9f4949),
                    ),
                  ],
                )),
          ],
        ));
  }
}