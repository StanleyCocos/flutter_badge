import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_push_badge/flutter_push_badge.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _badgeNumber = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String badgeNumber;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      badgeNumber = await FlutterPushBadge.badgeNumber;
    } on PlatformException {
      badgeNumber = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _badgeNumber = badgeNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app '),
        ),
        body: Center(
          child: Column(
            children: <Widget>[

              Padding(padding: EdgeInsets.only(top: 100),),

              Text("当前角标: $_badgeNumber"),

              Padding(padding: EdgeInsets.only(top: 100),),
              GestureDetector(
                onTap: (){
                  initPlatformState();
                },
                child: Container(
                  width: 100,
                  height: 40,
                  alignment: Alignment.center,
                  color: Colors.red,
                  child: Text(
                      "获取角标"
                  ),
                ),
              ),

              Padding(padding: EdgeInsets.only(top: 100),),
              GestureDetector(
                onTap: (){
                  FlutterPushBadge.setBadgeNumber("20");
                },
                child: Container(
                  width: 100,
                  height: 40,
                  alignment: Alignment.center,
                  color: Colors.yellow,
                  child: Text(
                      "设置角标"
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
