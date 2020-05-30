import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'App Loker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _counter, _value = "";
  String _baseurl = "http://188.166.206.43/YtQcUqOEdp7iWbpOm1fov2TQHCI2vnnd";
  String contex;
  bool status = false;
  bool status1 = false;
  bool status2 = false;
  bool status3 = false;
  bool status4 = false;
  bool status5 = false;
  bool status6 = false;
  bool temp1 = false;

  void initState() {
    super.initState();
    Timer.periodic(Duration(microseconds: 500), (Timer t) {
      getData();
      setState(() {});
    });
  }

  Future _incrementCounter() async {
    _counter = await FlutterBarcodeScanner.scanBarcode(
        "#004297", "Cencel", true, ScanMode.DEFAULT);
    if (_counter == "yuhu") {
      if (_value != "") {
        updateData(_value);
        if (_value == "Loker 1" && status1) {
          contex = _value + " Closed => RP.6000";
          status = true;
        } else if (_value == "Loker 2" && status2) {
          contex = _value + " Closed => RP.6000";
          status = true;
        } else if (_value == "Loker 3" && status3) {
          contex = _value + " Closed => RP.6000";
          status = true;
        } else if (_value == "Loker 4" && status4) {
          contex = _value + " Closed => RP.6000";
          status = true;
        } else if (_value == "Loker 5" && status5) {
          contex = _value + " Closed => RP.6000";
          status = true;
        } else if (_value == "Loker 6" && status6) {
          contex = _value + " Closed => RP.6000";
          status = true;
        } else {
          contex = _value + " Open";
          status = true;
        }
      } else {
        contex = "Please Select Loker !";
        status = false;
      }
    } else {
      status = false;
      contex = "Ops, QR Code is wrong !";
    }
    _value = "";

    setState(() {
      _displaySnackBar(context);
    });
  }

  _displaySnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text(contex),
      backgroundColor: (status) ? Colors.blue : Colors.redAccent,
      duration: Duration(seconds: 5),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void updateData(String pin) async {
    if (_value != "") {
      String apiURL = _baseurl + '/update/V7?value=' + pin;
      var apiResult = await http.get(apiURL);
      print('Response status: ${apiResult.statusCode}');
    }
  }

  void getData() async {
    String apiURL = _baseurl + "/project";
    var apiResult = await http.get(apiURL);
    var temp = json.decode(apiResult.body);
    for (var data in temp["widgets"]) {
      parsingData(data["pin"], data["value"]);
    }
  }

  void parsingData(int pin, String state) {
    switch (pin) {
      case 1:
        if (state == '1') {
          status1 = true;
        } else {
          status1 = false;
        }
        break;
      case 2:
        if (state == '1') {
          status2 = true;
        } else {
          status2 = false;
        }
        break;
      case 3:
        if (state == '1') {
          status3 = true;
        } else {
          status3 = false;
        }
        break;
      case 4:
        if (state == '1') {
          status4 = true;
        } else {
          status4 = false;
        }
        break;
      case 5:
        if (state == '1') {
          status5 = true;
        } else {
          status5 = false;
        }
        break;
      case 6:
        if (state == '1') {
          status6 = true;
        } else {
          status6 = false;
        }
        break;
      default:
    }
    setState(() {});
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
                flex: 1,
                child: Row(
                  children: <Widget>[
                    Flexible(
                        flex: 1,
                        child: ButtonTheme(
                          height: 300,
                          minWidth: 300,
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: RaisedButton(
                              color: (status1) ? Colors.red : Colors.green,
                              onPressed: () {
                                _value = "Loker 1";
                                _incrementCounter();
                              },
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30)),
                              child: Text(
                                "Loker 1",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        )),
                    Flexible(
                        flex: 1,
                        child: ButtonTheme(
                          height: 300,
                          minWidth: 300,
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: RaisedButton(
                              color: (status2) ? Colors.red : Colors.green,
                              onPressed: () {
                                _value = "Loker 2";
                                _incrementCounter();
                              },
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30)),
                              child: Text(
                                "Loker 2",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        )),
                  ],
                )),
            Flexible(
                flex: 1,
                child: Row(
                  children: <Widget>[
                    Flexible(
                        flex: 1,
                        child: ButtonTheme(
                          height: 300,
                          minWidth: 300,
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: RaisedButton(
                              color: (status3) ? Colors.red : Colors.green,
                              onPressed: () {
                                _value = "Loker 3";
                                _incrementCounter();
                              },
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30)),
                              child: Text(
                                "Loker 3",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        )),
                    Flexible(
                        flex: 1,
                        child: ButtonTheme(
                          height: 300,
                          minWidth: 300,
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: RaisedButton(
                              color: (status4) ? Colors.red : Colors.green,
                              onPressed: () {
                                _value = "Loker 4";
                                _incrementCounter();
                              },
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30)),
                              child: Text(
                                "Loker 4",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        )),
                  ],
                )),
            Flexible(
                flex: 1,
                child: Row(
                  children: <Widget>[
                    Flexible(
                        flex: 1,
                        child: ButtonTheme(
                          height: 300,
                          minWidth: 300,
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: RaisedButton(
                              color: (status5) ? Colors.red : Colors.green,
                              onPressed: () {
                                _value = "Loker 5";
                                _incrementCounter();
                              },
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30)),
                              child: Text(
                                "Loker 5",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        )),
                    Flexible(
                        flex: 1,
                        child: ButtonTheme(
                          height: 300,
                          minWidth: 300,
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: RaisedButton(
                              color: (status6) ? Colors.red : Colors.green,
                              onPressed: () {
                                _value = "Loker 6";
                                _incrementCounter();
                              },
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30)),
                              child: Text(
                                "Loker 6",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        )),
                  ],
                )),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.settings_overscan),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
