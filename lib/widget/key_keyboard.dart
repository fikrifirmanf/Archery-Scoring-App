import 'package:flutter/material.dart';
import 'package:scoring_panahan/widget/key_controller.dart';
import 'package:scoring_panahan/widget/key_symbol.dart';

abstract class Keys {
  static KeySymbol x = const KeySymbol('X');
  static KeySymbol ten = const KeySymbol('10');
  static KeySymbol zero = const KeySymbol('0');
  static KeySymbol one = const KeySymbol('1');
  static KeySymbol two = const KeySymbol('2');
  static KeySymbol three = const KeySymbol('3');
  static KeySymbol four = const KeySymbol('4');
  static KeySymbol five = const KeySymbol('5');
  static KeySymbol six = const KeySymbol('6');
  static KeySymbol seven = const KeySymbol('7');
  static KeySymbol eight = const KeySymbol('8');
  static KeySymbol nine = const KeySymbol('9');
  static KeySymbol m = const KeySymbol('M');
}

class KeyKeyboard extends StatelessWidget {
  KeyKeyboard({this.symbol});

  final KeySymbol symbol;

  static dynamic _fire(KeyKeyboard key) => KeyController.fire(KeyEvent(key));

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.purple[800],
      ),
      margin: EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          symbol.value,
          style: TextStyle(
            fontSize: 25.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
