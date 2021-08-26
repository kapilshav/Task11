import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50.0,
            ),
            Text(
              "Hello",
              style: TextStyle(fontSize: 35.0),
            ),
            Text(
              "Welcome to LITER",
              style: TextStyle(fontSize: 35.0),
            ),
            SizedBox(
              height: 50.0,
            ),
            RaisedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, "ter");
              },
              icon: Icon(Icons.tv),
              label: Text("Terminal"),
            )
          ],
        ),
      ),
    );
  }
}
