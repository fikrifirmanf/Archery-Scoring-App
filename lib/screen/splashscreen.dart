import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: SafeArea(
        top: false,
        child: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Container(
                //   height: 32,
                //   width: 32,
                //   decoration: BoxDecoration(
                //     image: DecorationImage(
                //         image: AssetImage('assets/img/logo.png'),
                //         fit: BoxFit.fill),
                //   ),
                // ),
                Text(
                  "Archery Scoring",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )
              ]),
        ),
      ),
    );
  }
}
