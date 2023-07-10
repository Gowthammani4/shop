// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, prefer_conditional_assignment, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import '/soccer.dart';

class matchTile extends StatelessWidget {
  SoccerMatch match;
  int index;
  matchTile(this.match, this.index);

  @override
  Widget build(BuildContext context) {
    var homeGoal = match.goal.home;
    var awayGoal = match.goal.away;
    if (homeGoal == null) homeGoal = 0;
    if (awayGoal == null) awayGoal = 0;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              match.home.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
          Image.network(
            match.home.logoUrl,
            width: 36.0,
          ),
          Expanded(
            child: Text(
              "$homeGoal - $awayGoal",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
          Image.network(
            match.away.logoUrl,
            width: 36.0,
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  match.away.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                Text('$index days ago')
              ],
            ),
          ),
        ],
      ),
    );
  }
}
