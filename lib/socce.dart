// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables, camel_case_types, await_only_futures

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shop/cricketjson.dart';
import '/soccer.dart';

class SoccerApi {
  final apiUrl = Uri.https(
      'api-football-beta.p.rapidapi.com', '/fixtures', {"date": "2022-01-18"});
  static const headers = {
    'X-RapidAPI-Host': "api-football-beta.p.rapidapi.com",
    "X-RapidAPI-Key": "",
  };

  Future<List<SoccerMatch>> getAllMatches() async {
    http.Response res = await http.get(
      apiUrl,
      headers: headers,
    );
    var body;

    body = jsonDecode(res.body);
    print(body);
    List<SoccerMatch> matches = [];

    try {
      List<dynamic> matchesList = body['response'];
      print("Api service: ${body['response']}");
      matches = matchesList
          .map((dynamic item) => SoccerMatch.fromJson(item))
          .toList();
    } catch (e) {
      print(e);
    }
    return matches;
  }
}

class cricapi {
  final apiUrl = Uri.https('unofficial-cricbuzz.p.rapidapi.com',
      '/matches/list', {"matchState": "live"});
  static const headers = {
    'X-RapidAPI-Host': "unofficial-cricbuzz.p.rapidapi.com",
    "X-RapidAPI-Key": "",
  };
  Future<List<cricketapi>> cricsmatches() async {
    http.Response res = await http.get(
      apiUrl,
      headers: headers,
    );
    var body;

    body = jsonDecode(res.body);
    List<cricketapi>? c;

    print(body);
    try {
      print(body['typeMatches']);
      List<dynamic> criclist = body['typeMatches'];
      c = await criclist
          .map((dynamic item) => cricketapi.fromJson(item))
          .toList();
      c.first.seriesAdWrapper.removeAt(1);
    } catch (e) {
      print(e);
    }
    return c!;
  }
}
