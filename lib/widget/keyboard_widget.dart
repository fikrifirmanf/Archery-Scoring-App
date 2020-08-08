import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoring_panahan/widget/key_keyboard.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

class KeyboardWidget extends StatefulWidget {
  static String keys = '';

  @override
  _KeyboardWidgetState createState() => _KeyboardWidgetState();
}

class _KeyboardWidgetState extends State<KeyboardWidget> {
  SolidController _controller = SolidController();
  void _onClick(String value) {
    KeyboardWidget.keys = value;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 20) / 2;
    final double itemWidth = size.width / 3;

    return SolidBottomSheet(
      autoSwiped: true,
      showOnAppear: true,
      maxHeight: MediaQuery.of(context).size.height / 4.5,
      controller: _controller,
      draggableBody: true,
      body: Container(
          decoration: new BoxDecoration(
            border: Border(),
            gradient: new LinearGradient(
                colors: [
                  const Color(0xFFDB6AF4),
                  const Color(0xFFAC4BF1),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: GridView.count(
              crossAxisCount: 4,
              childAspectRatio: (itemHeight / itemWidth),
              controller: ScrollController(keepScrollOffset: false),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                GestureDetector(
                    onTap: () {
                      _onClick(Keys.x.toString());
                      print(KeyboardWidget.keys);
                    },
                    child: KeyKeyboard(symbol: Keys.x)),
                GestureDetector(
                    onTap: () {
                      _onClick(Keys.ten.toString());
                      print(KeyboardWidget.keys);
                    },
                    child: KeyKeyboard(symbol: Keys.ten)),
                GestureDetector(
                    onTap: () {
                      _onClick(Keys.nine.toString());
                      print(KeyboardWidget.keys);
                    },
                    child: KeyKeyboard(symbol: Keys.nine)),
                KeyKeyboard(symbol: Keys.eight),
                KeyKeyboard(symbol: Keys.seven),
                KeyKeyboard(symbol: Keys.six),
                KeyKeyboard(symbol: Keys.five),
                KeyKeyboard(symbol: Keys.four),
                KeyKeyboard(symbol: Keys.three),
                KeyKeyboard(symbol: Keys.two),
                KeyKeyboard(symbol: Keys.one),
                KeyKeyboard(symbol: Keys.m),
              ])),
    );
  }
}
