import 'package:flutter/material.dart';

class MessagePageWidget extends StatelessWidget {
  MessagePageWidget({this.image, this.title, this.subtitle});

  final Image image;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            image,
            SizedBox(height: 15.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black38,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black38,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
