// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, camel_case_types, avoid_print, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:shop/cricketjson.dart';
import '/goalstat.dart';
import '/matchtile.dart';
import '/teamstat.dart';
import '/soccer.dart';
import 'cricmatchtile.dart';

class cricpageBody extends StatefulWidget {
  List<cricketapi> allmatches;
  cricpageBody(this.allmatches);

  @override
  _cricpageBodyState createState() => _cricpageBodyState();
}

class _cricpageBodyState extends State<cricpageBody> {
  @override
  Widget build(BuildContext context) {
    print(widget.allmatches.first.matchType);
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: Container(
            height: 900,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Container(
                height: 800,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "MATCHES",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                        ),
                      ),
                      Container(
                          height: 450,
                          child: cricmatchtile(widget.allmatches.first, 0)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
