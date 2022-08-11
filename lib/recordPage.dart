import 'package:flutter/material.dart';

class RecordPage extends StatelessWidget {
  const RecordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: const Color(0xffffdfdf),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    flex: 18,
                    child: Container(
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: IconButton(
                                icon: const Icon(Icons.arrow_back),
                                padding:
                                    const EdgeInsets.fromLTRB(20, 50, 0, 0),
                                iconSize: 30,
                                color: Colors.grey,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            const Spacer(flex: 1),
                            Expanded(
                              flex: 10,
                              child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 50, 0, 0),
                                  child: Container(
                                    alignment: Alignment.topCenter,
                                    child: topic(),
                                  )),
                            ),
                            const Spacer(flex: 1),
                            Expanded(
                              flex: 2,
                              child: IconButton(
                                icon: const Icon(Icons.arrow_back),
                                padding:
                                    const EdgeInsets.fromLTRB(0, 50, 20, 0),
                                iconSize: 30,
                                color: Colors.transparent,
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ))),
                Spacer(flex: 2),
                Expanded(
                  flex: 50,
                  child: Container(color: Colors.white),
                ),
                Spacer(flex: 2)
              ],
            )));
  }

  Widget topic() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const <Widget>[
        Spacer(flex: 3),
        Text(
          "Topic",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 20.0,
            fontWeight: FontWeight.normal,
            height: 1.2,
          ),
        ),
        Spacer(flex: 2),
        Text("hahaha",
            style: TextStyle(
              color: Colors.transparent,
              fontSize: 50.0,
              fontWeight: FontWeight.normal,
            )),
      ],
    );
  }
}
