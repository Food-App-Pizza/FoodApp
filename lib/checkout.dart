import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(const Checkout());

class Checkout extends StatelessWidget {
  const Checkout({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        alignment: Alignment.center,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Your food is being delivered',style: TextStyle(fontSize: 30)),
              SizedBox(height: 20),
              Container(
                width: 500,
                height: 100,
                child: Animated())
            ]),
      ),
    ));
  }
}

class Animated extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScaleAnimatedTextKit(
      text: [
        "Thank",
        "You",
      ],
      textStyle: TextStyle(fontSize: 70.0, fontFamily: "Canterbury"),
      textAlign: TextAlign.center,
    );
  }
}
