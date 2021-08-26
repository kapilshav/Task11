import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class Ter extends StatefulWidget {
  @override
  _TerState createState() => _TerState();
}

class _TerState extends State<Ter> {
  var authc = FirebaseAuth.instance;
  var fstore = FirebaseFirestore.instance;
  myout(var a) async {
    var url = "http://192.168.1.9/cgi-bin/web.py?x=${a}";
    var r = await http.get(url);
    setState(() {
      out = r.body;
    });
    fstore.collection("linux").add({'cmd': '${cmd}', 'output': '${out}'});
  }

  var c = TextEditingController();
  var cmd;
  var out;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("LI-TER"),
        leading: Image.asset("images/logo1.png"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                print("Sign out");
                await authc.signOut();
                Fluttertoast.showToast(
                    msg: "Successfully loged out",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
                Navigator.pushNamed(context, "log");
              })
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/bg4.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                // Stroked text as border.
                Text(
                  'LI-TER',
                  style: TextStyle(
                    fontSize: 40,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 6
                      ..color = Colors.green[700],
                  ),
                ),
                // Solid text as fill.
                Text(
                  'LI-TER',
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.grey[300],
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.all(20.0),
              child: Card(
                color: Colors.black12,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 20.0,
                child: Row(
                  children: <Widget>[
                    Text(" [root@li-ter]",
                        style: TextStyle(color: Colors.white)),
                    Flexible(
                      child: TextField(
                        controller: c,
                        style: TextStyle(color: Colors.white),
                        onChanged: (value) {
                          cmd = value;
                        },
                      ),
                    ),
                    IconButton(
                        color: Colors.white,
                        icon: Icon(Icons.send),
                        onPressed: () {
                          c.clear();
                          myout(cmd);
                        })
                  ],
                ),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: fstore.collection("linux").snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  print("no data");
                  return Text("no data");
                }
                var co = snapshot.data.docs;
                List<Widget> y = [];
                for (var d in co) {
                  var cmd = d.data()['cmd'];
                  var out = d.data()['output'];
                  var wid = Container(
                      margin: EdgeInsets.only(left: 10.0, top: 0.5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "[root@li-ter]$cmd",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            out,
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ));
                  y.add(wid);
                }

                print(y.length);
                return Container(
                  margin: EdgeInsets.all(20.0),
                  height: MediaQuery.of(context).size.height * 0.6,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      //side: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 20.0,
                    color: Colors.black26,
                    child: ConstrainedBox(
                      constraints: new BoxConstraints(
                        minHeight: 0.0,
                        maxHeight: MediaQuery.of(context).size.height * 0.7,
                      ),
                      child: ListView(
                        children: y,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
