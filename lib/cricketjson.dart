// To parse this JSON data, do
//
//     final cricketapi = cricketapiFromJson(jsonString);

// ignore_for_file: camel_case_types, prefer_if_null_operators, unnecessary_null_comparison, avoid_print

import 'dart:convert';

import 'dart:core';

cricketapi cricketapiFromJson(String str) =>
    cricketapi.fromJson(json.decode(str));
Map<String, dynamic> series = {
  "seriesMatches": {
    "seriesId": 3641,
    "seriesName": "New Zealand tour of England, 2022",
    "matches": [
      {
        "matchInfo": {
          "matchId": 48009,
          "seriesId": 3641,
          "seriesName": "New Zealand tour of England, 2022",
          "matchDesc": "2nd Warm-up Match",
          "matchFormat": "TEST",
          "startDate": "1653559200000",
          "endDate": "1653843600000",
          "state": "Stumps",
          "status": "Day 3: Stumps - County Select XI need 152 runs",
          "team1": {
            "teamId": 13,
            "teamName": "New Zealand",
            "teamSName": "NZ",
            "imageId": "172128"
          },
          "team2": {
            "teamId": 886,
            "teamName": "County Select XI",
            "teamSName": "CSXI",
            "imageId": 174284
          },
          "venueInfo": {
            "id": 118,
            "ground": "County Ground",
            "city": "Chelmsford",
            "timezone": "+01:00"
          },
          "currentBatTeamId": 886,
          "seriesStartDt": 1653004800000,
          "seriesEndDt": 1656460800000
        },
        "matchScore": {
          "team1Score": {
            "inngs1": {
              "inningsId": 1,
              "runs": 362,
              "wickets": 9,
              "overs": 99.6,
              "isDeclared": true
            },
            "inngs2": {
              "inningsId": 3,
              "runs": 148,
              "wickets": 10,
              "overs": 43.2
            }
          },
          "team2Score": {
            "inngs1": {
              "inningsId": 2,
              "runs": 247,
              "wickets": 10,
              "overs": 74.2
            },
            "inngs2": {"inningsId": 4, "runs": 112, "wickets": 1, "overs": 44.6}
          }
        }
      }
    ]
  }
};

String cricketapiToJson(cricketapi data) => json.encode(data.toJson());

class cricketapi {
  cricketapi(
    this.matchType,
    this.seriesAdWrapper,
  );
  String matchType;
  List<SeriesAdWrapper> seriesAdWrapper;

  factory cricketapi.fromJson(Map<String, dynamic> json) {
    print('passed');
    return cricketapi(
      json["matchType"] == null ? '' : json['matchType'],
      List<SeriesAdWrapper>.from(
          json["seriesAdWrapper"].map((x) => SeriesAdWrapper.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "matchType": matchType,
        "seriesAdWrapper":
            List<dynamic>.from(seriesAdWrapper.map((x) => x.toJson())),
      };
}

class SeriesAdWrapper {
  SeriesAdWrapper({
    required this.seriesMatches,
  });

  SeriesMatches seriesMatches;

  factory SeriesAdWrapper.fromJson(Map<String, dynamic> json) {
    print('pass');
    return SeriesAdWrapper(
      seriesMatches: SeriesMatches.fromJson(json["seriesMatches"] == null
          ? series['seriesMatches']
          : json["seriesMatches"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "seriesMatches": seriesMatches.toJson(),
      };
}

class SeriesMatches {
  SeriesMatches({
    required this.seriesId,
    required this.seriesName,
    required this.matches,
  });

  int seriesId;
  String seriesName;
  List<Match> matches;

  factory SeriesMatches.fromJson(Map<String, dynamic> json) {
    print('passed seriesmatches');
    return SeriesMatches(
      seriesId: json["seriesId"],
      seriesName: json["seriesName"],
      matches: List<Match>.from(json["matches"].map((x) => Match.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "seriesId": seriesId,
        "seriesName": seriesName,
        "matches": List<dynamic>.from(matches.map((x) => x.toJson())),
      };
}

class Match {
  Match({
    required this.matchInfo,
    required this.matchScore,
  });

  MatchInfo matchInfo;
  MatchScore matchScore;

  factory Match.fromJson(Map<String, dynamic> json) {
    print('passed matches');

    return Match(
      matchInfo: MatchInfo.fromJson(json["matchInfo"]),
      matchScore: MatchScore.fromJson(json["matchScore"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "matchInfo": matchInfo.toJson(),
        "matchScore": matchScore.toJson(),
      };
}

class MatchInfo {
  MatchInfo({
    required this.matchId,
    required this.seriesId,
    required this.seriesName,
    required this.matchDesc,
    required this.matchFormat,
    required this.startDate,
    required this.endDate,
    required this.state,
    required this.status,
    required this.team1,
    required this.team2,
    //  required this.venueInfo,
  });

  int matchId;
  int seriesId;
  String seriesName;
  String matchDesc;
  String matchFormat;
  String startDate;
  String endDate;
  String state;
  String status;
  Team1 team1;
  Team2 team2;
  //VenueInfo venueInfo;

  factory MatchInfo.fromJson(Map<String, dynamic> json) {
    print('passed matchinfo');

    return MatchInfo(
      matchId: json["matchId"],
      seriesId: json["seriesId"],
      seriesName: json["seriesName"],
      matchDesc: json["matchDesc"],
      matchFormat: json["matchFormat"],
      startDate: json["startDate"],
      endDate: json["endDate"],
      state: json["state"],
      status: json["status"],
      team1: Team1.fromJson(json["team1"]),
      team2: Team2.fromJson(json["team2"]),
      // venueInfo: VenueInfo.fromJson(json["venueInfo"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "matchId": matchId,
        "seriesId": seriesId,
        "seriesName": seriesName,
        "matchDesc": matchDesc,
        "matchFormat": matchFormat,
        "startDate": startDate,
        "endDate": endDate,
        "state": state,
        "status": status,
        "team1": team1.toJson(),
        "team2": team2.toJson(),
        //"venueInfo": venueInfo.toJson(),
      };
}

class Team1 {
  Team1({
    required this.teamName,
    required this.teamSName,
  });

  String teamName;
  String teamSName;

  factory Team1.fromJson(Map<String, dynamic> json) {
    print('passed Team1');

    var t1 = Team1(
      teamName: json["teamName"],
      teamSName: json["teamSName"],
    );
    print(t1.teamSName);
    return t1;
  }

  Map<String, dynamic> toJson() => {
        "teamName": teamName,
        "teamSName": teamSName,
      };
}

class Team2 {
  Team2({
    required this.teamName,
    required this.teamSName,
  });

  String teamName;
  String teamSName;

  factory Team2.fromJson(Map<String, dynamic> json) {
    print('passed Team2');

    var t2 = Team2(
      teamName: json["teamName"] == null ? '' : json["teamName"],
      teamSName: json["teamSName"] == null ? '' : json["teamName"],
    );
    print(t2.teamName);
    return t2;
  }

  Map<String, dynamic> toJson() => {
        "teamName": teamName,
        "teamSName": teamSName,
      };
}

// class Team2 {
//   Team2({
//     required this.teamName,
//     required this.teamSName,
//   });

//   String teamName;
//   String teamSName;

//   factory Team2.fromJson(Map<String, dynamic> json) {
//     print('passed Team2');

//     return Team2(
//       teamName: json["teamName"],
//       teamSName: json["teamSName"],
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "teamName": teamName,
//         "teamSName": teamSName,
//       };
//  }

// class VenueInfo {
//   VenueInfo({
//     required this.id,
//     required this.ground,
//     required this.city,
//     required this.timezone,
//   });

//   int id;
//   String ground;
//   String city;
//   String timezone;

//   factory VenueInfo.fromJson(Map<String, dynamic> json) {
//     print('passed venue');

//     var v = VenueInfo(
//       id: json["id"],
//       ground: json["ground"],
//       city: json["city"],
//       timezone: json["timezone"],
//     );
//     print(v);
//     return v;
//   }

//   toJson() => {
//         "id": id,
//         "ground": ground,
//         "city": city,
//         "timezone": timezone,
//       };
// }

class MatchScore {
  MatchScore({
    required this.team1Score,
    required this.team2Score,
  });

  TeamScore team1Score;
  TeamScore team2Score;

  factory MatchScore.fromJson(Map<String, dynamic>? json) {
    print('passed matchscore');

    var s = MatchScore(
      team1Score: TeamScore.fromJson(json!["team1Score"]),
      team2Score: TeamScore.fromJson(json["team2Score"]),
    );
    print(s.team1Score.inngs1.runs);
    return s;
  }

  toJson() => {
        "team1Score": team1Score.toJson(),
        "team2Score": team2Score.toJson(),
      };
}

class TeamScore {
  TeamScore({
    required this.inngs1,
    //required this.inngs2
  });

  Inngs inngs1;
  //Inngs inngs2;

  factory TeamScore.fromJson(Map<String, dynamic>? json) {
    print('passed Teamscore');
    var ed;
    if (json?["inngs1"] == null) {
      ed = TeamScore(
        inngs1: Inngs.fromJson(json),
        //inngs2: Inngs.fromJson(json)
      );
    } else {
      ed = TeamScore(inngs1: Inngs.fromJson(json!["inngs1"]));
      //inngs2: Inngs.fromJson(json["inngs2"]));
    }
    return ed;
  }

  Map<String, dynamic> toJson() => {
        "inngs1": inngs1.toJson(),
//"inngs2": inngs2.toJson(),
      };
}

class Inngs {
  Inngs({
    required this.runs,
    required this.wickets,
    required this.overs,
    //required this.isDeclared,
  });

  int? runs;
  int? wickets;
  double? overs;
  //bool isDeclared;

  factory Inngs.fromJson(Map<String, dynamic>? json) {
    print('passed inngs');
    var d;
    if (json == null) {
      d = Inngs(runs: 0, wickets: 0, overs: 0);
    } else {
      d = Inngs(
        runs: json["runs"],
        wickets: json['wickets'],
        overs: json["overs"],
      );
    }

    print(d.runs);
    return d;
  }

  Map<String, dynamic>? toJson() => {
        "runs": runs,
        "wickets": wickets,
        "overs": overs,
        // "isDeclared": isDeclared == null ? null : isDeclared,
      };
}
