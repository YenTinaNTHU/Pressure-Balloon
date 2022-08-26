import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:my_app/recordPage.dart';
import 'package:my_app/parameters.dart';
import 'SettingPage.dart';

class EndingPage extends StatefulWidget {
  const EndingPage({Key? key}) : super(key: key);

  @override
  State<EndingPage> createState() => _EndingPageState();
}

class _EndingPageState extends State<EndingPage> {
  int _page = 0;
  void _handleSettingIconPressed() {
    print("pressed");
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const SettingPage()));
  }

  void _handleEditIconPressed() {
    print("pressed");
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const RecordPage()));
  }

  void _updatePage(int page) {
    setState(() {
      if (page <= 3) _page = page;
    });
  }

  double _currentSliderValue = 2;
  int id = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    child: IconButton(
                      alignment: Alignment.topCenter,
                      padding: const EdgeInsets.fromLTRB(20, 50, 0, 0),
                      color: Colors.grey,
                      iconSize: 30,
                      icon: const Icon(
                        Icons.edit_note_rounded,
                      ),
                      onPressed: () {
                        _handleEditIconPressed();
                      },
                    ),
                  ),
                ),
                Spacer(flex: 12),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: IconButton(
                      alignment: Alignment.topCenter,
                      padding: const EdgeInsets.fromLTRB(0, 50, 20, 0),
                      color: Colors.grey,
                      iconSize: 30,
                      icon: const Icon(
                        Icons.settings_rounded,
                      ),
                      onPressed: () {
                        _handleSettingIconPressed();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Spacer(flex: 3),
          Expanded(
            flex: 10,
            child: Column(
              children: [
                endingDialog(
                  page: _page,
                ),
                _page != 3
                    ? NextBtn(updatePage: _updatePage, page: _page)
                    : Container(),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
                width: 300,
                child: _page == 0
                    ? SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                            trackHeight: 20,
                            activeTickMarkColor: Color(0xffFFBDBD),
                            activeTrackColor: Color(0xffFFBDBD),
                            inactiveTickMarkColor: Color(0xffE9E9E9),
                            inactiveTrackColor: Color(0xffE9E9E9),
                            thumbColor: Colors.white),
                        child: Slider(
                          value: _currentSliderValue,
                          max: 4,
                          divisions: 4,
                          label: moods[id],
                          onChanged: (double value) {
                            setState(() {
                              _currentSliderValue = value;
                              id = (_currentSliderValue).toInt();
                            });
                          },
                        ),
                      )
                    : Container()),
          ),
          Spacer(flex: 10),
          Expanded(
            flex: 20,
            child: Center(
                child: Image.asset('assets/images/normalBalloon_01.png')),
          ),
          Spacer(flex: 10),
        ],
      ),
    );
  }
}

class endingDialog extends StatelessWidget {
  endingDialog({Key? key, required this.page}) : super(key: key);
  final int page;

  @override
  Widget build(BuildContext context) {
    final List<String> dialogs = [
      'How do you feel?',
      'Anyway, we had found that this moment is your creativity sweet spot.',
      'It’s time to go back to work and see if there is some inspiration',
      'See you next time, bye-bye ^w^/',
    ];
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 20, 50, 0),
      child: Center(
        child: Text(
          dialogs[page],
          textAlign: TextAlign.center,
          style: TextStyle(color: Color(0xff2f2f2f)),
        ),
      ),
    );
  }
}

class NextBtn extends StatelessWidget {
  const NextBtn({Key? key, required this.updatePage, required this.page})
      : super(key: key);
  final ValueChanged<int> updatePage;
  final int page;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 40),
      child: TextButton(
        onPressed: () => {updatePage(page + 1)},
        child: const Text(
          ">>NEXT",
          textAlign: TextAlign.right,
          style: TextStyle(
              decoration: TextDecoration.underline, color: Color(0xffD77B7B)),
        ),
      ),
    );
  }
}
