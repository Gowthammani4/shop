// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, prefer_conditional_assignment, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:shop/cricketjson.dart';
import 'package:shop/cricmatch.dart';
import '/soccer.dart';

class cricmatchtile extends StatelessWidget {
  cricketapi match;
  int ind;
  cricmatchtile(this.match, this.ind);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index) {
          print(match.seriesAdWrapper[index].seriesMatches.matches.first
              .matchInfo.status);
          print(match.seriesAdWrapper[ind].seriesMatches.matches.length);
          return
              // height: 100,
              Container(
            height: 80,
            child: cricmatch(
                match.seriesAdWrapper[ind].seriesMatches.matches.first, index),
          );
          //     Divider(
          //       color: Colors.black,
          //       thickness: 2.0,
          //     )
          //   ],
          // );
        },
        itemCount: match.seriesAdWrapper.length);

    // Container(
    //     height: 10,
    //     margin: EdgeInsets.symmetric(vertical: 12.0),
    //     child: );
    //);
  }
}
