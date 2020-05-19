import 'package:flutter/material.dart';

class London extends StatefulWidget {
  @override
  _LondonState createState() => new _LondonState();
}


class _LondonState extends State<London> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("London Tour"),
        backgroundColor: Colors.deepOrange,
      ),

    );
  }
}




