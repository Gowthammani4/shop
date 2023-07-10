// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import '/goalstat.dart';
import '/matchtile.dart';
import '/teamstat.dart';
import '/soccer.dart';

class pageBody extends StatefulWidget {
  List<SoccerMatch> allmatches;
  pageBody(this.allmatches);

  @override
  _pageBodyState createState() => _pageBodyState();
}

class _pageBodyState extends State<pageBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  teamStat("Local Team", widget.allmatches.last.home.logoUrl,
                      widget.allmatches.last.home.name),
                  goalStat(90, widget.allmatches.last.goal.home,
                      widget.allmatches.last.goal.away),
                  teamStat("Visitor Team", widget.allmatches.last.away.logoUrl,
                      widget.allmatches.last.away.name),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(
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
                  // Text(
                  //   'Live matches',
                  //   style: TextStyle(
                  //     color: Colors.white,
                  //     fontSize: 24.0,
                  //   ),
                  // ),
                  // Container(
                  //   height: 80,
                  //   child: ListView.builder(
                  //     itemCount: widget.allmatches.length,
                  //     itemBuilder: (context, index) {
                  //       return matchTile(widget.allmatches[index], index);
                  //     },
                  //   ),
                  // ),
                  Text('Recent Matches'),
                  Container(
                    height: 400,
                    child: ListView.builder(
                      itemCount: widget.allmatches.length,
                      itemBuilder: (context, index) {
                        return matchTile(widget.allmatches[index], index);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
