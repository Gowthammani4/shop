// ignore_for_file: non_constant_identifier_names, use_rethrow_when_possible, avoid_print, unused_field, camel_case_types, recursive_getters

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:shop/models/http%20exeption.dart';

class auth with ChangeNotifier {
  String? _token;
  String? _userid;
  DateTime? _expirydate;
  Timer? _authtimer;

  bool get isauth {
    return _token != null;
  }

  String? get userid {
    return _userid;
  }

  String? get token {
    if (_expirydate != null &&
        _expirydate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyCO6LMeM3IlEwsMp0QzCHfmlSXUakyxn5w');
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userid = responseData['localId'];
      _expirydate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      // autologout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userdata = json.encode({
        'token': token,
        'userId': _userid,
        'expiryDate': _expirydate!.toIso8601String()
      });
      prefs.setString('userdata', userdata);
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<bool> tryautologin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userdata')) {
      return false;
    }
    final extracteddata =
        json.decode(prefs.getString('userdata')!) as Map<String, dynamic>;
    final expiredate = DateTime.parse(extracteddata['expiryDate'] as String);
    if (expiredate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extracteddata['token'] as String;
    _userid = extracteddata['userId'] as String;
    _expirydate = expiredate;
    notifyListeners();
    //autologout();
    return true;
  }

  void autologout() {
    if (_authtimer != null) {
      _authtimer?.cancel();
    }

    final timetoexpire = _expirydate!.difference(DateTime.now()).inSeconds;
    _authtimer = Timer(Duration(seconds: timetoexpire), logout);
    //the logout function will execute after the timer is finished
  }

  Future<void> logout() async {
    //Future.delayed(5);
    _expirydate = null;
    _userid = null;
    _token = null;
    if (_authtimer != null) {
      _authtimer?.cancel();
      _authtimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
