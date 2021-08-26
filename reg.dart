import 'package:animated_text/animated_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Reg extends StatefulWidget {
  @override
  _RegState createState() => _RegState();
}

class _RegState extends State<Reg> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;
  Animation<Offset> _offsetAnimation;
  var id;
  var name;
  var passwd;
  var cpass;
  var auth = FirebaseAuth.instance;
  var ec = TextEditingController();
  var pc = TextEditingController();
  var nc = TextEditingController();
  var cpc = TextEditingController();
  bool sspin = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset(0.0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticIn,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return Material(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        body: ModalProgressHUD(
          inAsyncCall: sspin,
          child: SingleChildScrollView(
            reverse: true,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.blue.shade700,
              child: Column(children: <Widget>[
                SizedBox(
                  height: 90.0,
                ),
                Container(
                  height: 50.0,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Card(
                    elevation: 50.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: AnimatedText(
                      repeatCount: 1,
                      alignment: Alignment.topCenter,
                      speed: Duration(milliseconds: 1000),
                      controller: AnimatedTextController.loop,
                      displayTime: Duration(milliseconds: 1000),
                      wordList: ['Register here', 'LI-TER'],
                      textStyle: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 35.0,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                SlideTransition(
                  position: _offsetAnimation,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 50.0,
                    color: Colors.white,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.width * 1.25,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 15.0,
                          ),
                          Container(
                            width: 250.0,
                            child: TextField(
                              controller: nc,
                              onChanged: (value) {
                                name = value;
                              },
                              decoration: InputDecoration(
                                labelStyle:
                                    TextStyle(fontWeight: FontWeight.bold),
                                focusColor: Colors.blue.shade700,
                                labelText: "Name",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                              keyboardType: TextInputType.text,
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            width: 250.0,
                            child: TextField(
                              controller: ec,
                              onChanged: (value) {
                                id = value;
                              },
                              decoration: InputDecoration(
                                labelStyle:
                                    TextStyle(fontWeight: FontWeight.bold),
                                prefixIcon: Icon(Icons.person),
                                focusColor: Colors.blue.shade700,
                                labelText: "E-mail",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            width: 250.0,
                            child: TextField(
                              controller: pc,
                              onChanged: (value) {
                                passwd = value;
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                labelStyle:
                                    TextStyle(fontWeight: FontWeight.bold),
                                prefixIcon: Icon(Icons.lock),
                                focusColor: Colors.blue.shade700,
                                labelText: "Password",
                                hintText:
                                    "Password should be at least 6 characters",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            width: 250.0,
                            child: TextField(
                              controller: cpc,
                              onChanged: (value) {
                                cpass = value;
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                labelStyle:
                                    TextStyle(fontWeight: FontWeight.bold),
                                prefixIcon: Icon(Icons.lock),
                                focusColor: Colors.blue.shade700,
                                labelText: "Confirm Password",
                                hintText:
                                    "Password should be at least 6 characters",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          ButtonTheme(
                            minWidth: 90,
                            height: 45,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              elevation: 10.0,
                              textColor: Colors.white,
                              color: Colors.blue.shade700,
                              onPressed: () async {
                                pc.clear();

                                cpc.clear();

                                setState(() {
                                  sspin = true;
                                });
                                try {
                                  if (passwd == cpass) {
                                    nc.clear();
                                    ec.clear();
                                    await auth.createUserWithEmailAndPassword(
                                      email: id,
                                      password: passwd,
                                    );
                                    Navigator.pushNamed(context, "ter");
                                  } else {
                                    setState(() {
                                      sspin = false;
                                    });
                                    Fluttertoast.showToast(
                                        msg: "password incorrect",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                } catch (e) {
                                  setState(() {
                                    sspin = false;
                                  });
                                  Fluttertoast.showToast(
                                      msg: "Enter correct information",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              },
                              child: Text(
                                "SignUp",
                                style: TextStyle(fontSize: 24.0),
                              ),
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              setState(() {
                                sspin = true;
                              });
                              Navigator.pushNamed(context, "log");
                            },
                            child: Text(
                              "LogIn",
                              style: TextStyle(fontSize: 20.0),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
