import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(Record());
}

class Record extends StatelessWidget {
  Record({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Record Page',
        theme: ThemeData(
          textTheme: GoogleFonts.aBeeZeeTextTheme(Theme.of(context).textTheme),
        ),
        home: Scaffold(
            body: Container(
                color: const Color(0xffffdfdf),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        flex: 20,
                        child: Container(
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 50, 0, 0),
                                      child: IconButton(
                                        icon: const Icon(Icons.arrow_back),
                                        iconSize: 30,
                                        color: Colors.grey,
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Record()),
                                          );
                                        },
                                      )),
                                ),
                                const Spacer(flex: 2),
                                const Expanded(
                                  flex: 2,
                                  child: Padding(
                                      padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
                                      child: Text("Topic",
                                          style: TextStyle(
                                              color: Color(0xff9f9f9f),
                                              fontSize: 25))),
                                ),
                                const Spacer(flex: 3)
                              ],
                            ))),
                    Spacer(flex: 2),
                    Expanded(
                      flex: 50,
                      child: Container(color: Colors.white),
                    ),
                    Spacer(flex: 2)
                  ],
                )))
        /*home: Scaffold(
            body: Container(
                color: Color.white,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                          flex: 25,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 50, 0, 0),
                                    child: IconButton(
                                      icon: const Icon(Icons.arrow_back),
                                      iconSize: 30,
                                      color: Colors.grey,
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Record()),
                                        );
                                      },
                                    )),
                              ),
                              const Spacer(flex: 2),
                              const Expanded(
                                flex: 2,
                                child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
                                    child: Text("Topic",
                                        style: TextStyle(
                                            color: Color(0xff9f9f9f),
                                            fontSize: 25))),
                              ),
                              const Spacer(flex: 3)
                            ],
                          )),
                      Expanded(
                        flex: 65,
                        child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Container(color: Color(0xffffdfdf)),
                              Container(
                                  color: Colors.white, height: 500), //height?
                            ]),
                      )
                    ])))
                    */
        );
  }
}
