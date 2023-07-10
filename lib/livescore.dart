// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, avoid_print, camel_case_types, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:shop/cricketjson.dart';
import 'package:shop/socce.dart';
import 'package:shop/soccer.dart';

import 'body.dart';
import 'cricpage.dart';

class Soccer extends StatefulWidget {
  static const routeName = '/livescores';

  @override
  _SoccerState createState() => _SoccerState();
}

class _SoccerState extends State<Soccer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
        title: Text(
          "SOCCERBOARD",
          style: TextStyle(color: Colors.white10),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: SoccerApi().getAllMatches(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return pageBody(snapshot.data as List<SoccerMatch>);
          } else {
            print('The data is not fetched till now try correcting the errors');

            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class cricket extends StatefulWidget {
  static const routeName = '/criccores';

  cricket();

  @override
  _cricketState createState() => _cricketState();
}

class _cricketState extends State<cricket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
        title: Text(
          "SCOREBOARD",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: cricapi().cricsmatches(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return cricpageBody(snapshot.data as List<cricketapi>);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
