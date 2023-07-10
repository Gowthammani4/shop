// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_if_null_operators, must_be_immutable, sized_box_for_whitespace, camel_case_types

import 'package:flutter/material.dart';
import 'package:shop/cricketjson.dart';

class cricmatch extends StatelessWidget {
  Match match;
  int index;

  cricmatch(this.match, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  match.matchInfo.team1.teamName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      // match.seriesAdWrapper.seriesMatches.
                      match.matchScore.team1Score.inngs1.runs.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                    Text('/'),
                    Text(
                      //match.seriesAdWrapper.seriesMatches.
                      match.matchScore.team1Score.inngs1.wickets.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                    )
                  ],
                ),
                Text(
                  //match.seriesAdWrapper.seriesMatches.
                  match.matchScore.team1Score.inngs1.overs == null
                      ? '0.0'
                      :
                      // match.seriesAdWrapper.seriesMatches
                      // .
                      match.matchScore.team1Score.inngs1.overs.toString(),
                ),
                // match.matchScore.team1Score.inngs2.runs == null
                //     ? Row(
                //         children: [
                //           Text(
                //             // match.seriesAdWrapper.seriesMatches.
                //             match.matchScore.team1Score.inngs1.runs.toString(),
                //             textAlign: TextAlign.center,
                //             style: TextStyle(
                //               color: Colors.white,
                //               fontSize: 16.0,
                //             ),
                //           ),
                //           Text('/'),
                //           Text(
                //             //match.seriesAdWrapper.seriesMatches.
                //             match.matchScore.team1Score.inngs1.wickets
                //                 .toString(),
                //             textAlign: TextAlign.center,
                //             style: TextStyle(
                //               color: Colors.black,
                //               fontSize: 16.0,
                //             ),
                //           )
                //         ],
                //       )
                //     : Text('')
              ],
            ),
          ),
          // Image.network(
          //  // match.home.logoUrl,
          //   width: 36.0,
          // ),
          Expanded(
              //flex: 5,
              child: Text(
            //match.seriesAdWrapper.seriesMatches.
            match.matchInfo.status == null ? '' : match.matchInfo.status,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18),
          )),
          // Image.network(
          //   match.away.logoUrl,
          //   width: 36.0,
          // ),
          Expanded(
              child: Column(children: [
            Text(
              // match.seriesAdWrapper.seriesMatches.
              match.matchInfo.team2.teamName,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  // match.seriesAdWrapper.seriesMatches.
                  match.matchScore.team2Score.inngs1.runs == null
                      ? '0'
                      :
                      // match.seriesAdWrapper.seriesMatches
                      //     .
                      match.matchScore.team2Score.inngs1.runs.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                Text('/'),
                Text(
                  //match.seriesAdWrapper.seriesMatches.
                  match.matchScore.team2Score.inngs1.runs == null
                      ? '0'
                      :
                      // match.seriesAdWrapper.seriesMatches
                      //     .
                      match.matchScore.team2Score.inngs1.wickets.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            Text(
                //match.seriesAdWrapper.seriesMatches.
                match.matchScore.team2Score.inngs1.overs == null
                    ? '0.0'
                    :
                    //match.seriesAdWrapper.seriesMatches.
                    match.matchScore.team2Score.inngs1.overs.toString())
          ]))
        ],
      ),
    );
  }
}
