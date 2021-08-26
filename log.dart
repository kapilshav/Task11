import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:animated_text/animated_text.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Log extends StatefulWidget {
  @override
  _LogState createState() => _LogState();
}

class _LogState extends State<Log> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;
  Animation<Offset> _offsetAnimation;
  var id;
  var passwd;
  var auth = FirebaseAuth.instance;
  var ec = TextEditingController();
  var pc = TextEditingController();
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
      begin: Offset(0.0, 0.3),
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
          child: Container(
            color: Colors.blue.shade700,
            child: Column(children: <Widget>[
              SizedBox(
                height: 90.0,
              ),
              RotationTransition(
                turns: _animation,
                child: Image.asset(
                  "images/logo1.png",
                  height: 150.0,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 50.0,
                child: AnimatedText(
                  repeatCount: 1,
                  alignment: Alignment.topCenter,
                  speed: Duration(milliseconds: 1000),
                  controller: AnimatedTextController.loop,
                  displayTime: Duration(milliseconds: 1000),
                  wordList: ['LI-TER', 'Linux Terminal'],
                  textStyle: TextStyle(
                      color: Colors.black45,
                      fontSize: 35.0,
                      fontWeight: FontWeight.w700),
                ),
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
                    width: 300.0,
                    height: 300.0,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 15.0,
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
                              ec.clear();
                              pc.clear();
                              try {
                                setState(() {
                                  sspin = true;
                                });
                                await auth.signInWithEmailAndPassword(
                                    email: id, password: passwd);

                                Navigator.pushNamed(context, "ter");
                              } catch (e) {
                                setState(() {
                                  sspin = false;
                                });
                                Fluttertoast.showToast(
                                    msg: "Enter correct id password.",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            },
                            child: Text(
                              "LOGIN",
                              style: TextStyle(fontSize: 24.0),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        FlatButton(
                          onPressed: () {
                            setState(() {
                              sspin = true;
                            });
                            Navigator.pushNamed(context, "reg");
                          },
                          child: Text(
                            "SignUp",
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
    );
  }
}
