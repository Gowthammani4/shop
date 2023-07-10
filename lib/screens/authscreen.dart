// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field, unnecessary_string_interpolations, prefer_final_fields, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, deprecated_member_use, non_constant_identifier_names, body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'dart:math';

import 'package:provider/provider.dart';
import 'package:shop/models/http%20exeption.dart';
import 'package:shop/providers/auth.dart';

// ignore: constant_identifier_names
enum Authmode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
                  Color.fromRGBO(255, 288, 177, 1).withOpacity(0.9)
                ],
                begin: Alignment.topLeft,
                end: Alignment.center,
                stops: [0, 1],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: devicesize.height,
              width: devicesize.width,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Container(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 20),
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 94.0),
                          transform: Matrix4.rotationZ(-0.8 * pi / 180)
                            ..translate(-10.0),
                          //tranfor is used to tilt the container in given direction
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.orange,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 8,
                                    color: Colors.black26,
                                    offset: Offset(0, 2))
                              ]),
                          child: Text(
                            'Sports splaza',
                            style: TextStyle(
                                color: Colors.purple,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Authcard(),
                      flex: devicesize.width > 600 ? 2 : 1,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Authcard extends StatefulWidget {
  const Authcard();

  @override
  _AuthcardState createState() => _AuthcardState();
}

class _AuthcardState extends State<Authcard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Authmode _Authmode = Authmode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();
  AnimationController? _controller;
  Animation<Offset>? _slideAnimation;
  Animation<double>? _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 300,
      ),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, -1.5),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.fastOutSlowIn,
      ),
    );
    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.easeIn,
      ),
    );
    // _heightAnimation.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    super.dispose();
    _controller!.dispose();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          ElevatedButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_Authmode == Authmode.Login) {
        // Log user in
        await Provider.of<auth>(context, listen: false).login(
          _authData['email']!,
          _authData['password']!,
        );
      } else {
        // Sign user up
        await Provider.of<auth>(context, listen: false).signup(
          _authData['email']!,
          _authData['password']!,
        );
      }
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthmode() {
    if (_Authmode == Authmode.Login) {
      setState(() {
        _Authmode = Authmode.Signup;
      });
      _controller!.forward();
    } else {
      setState(() {
        _Authmode = Authmode.Login;
      });
      _controller!.reverse();
    }
  }

  bool visibity = false;
  bool visibilitycheck() {
    setState(() {
      visibity = !visibity;
    });
    return visibity;
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
        height: _Authmode == Authmode.Signup ? 320 : 260,
        // height: _heightAnimation.value.height,
        constraints:
            BoxConstraints(minHeight: _Authmode == Authmode.Signup ? 320 : 260),
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.mail),
                    SizedBox(
                      width: 1,
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'E-Mail'),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty || !value.contains('@')) {
                            return 'Invalid email!';
                          }
                        },
                        onSaved: (value) {
                          _authData['email'] = value!;
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.lock),
                    SizedBox(
                      width: 1,
                    ),
                    Expanded(
                      child: TextFormField(
                          decoration: InputDecoration(labelText: 'Password'),
                          obscureText: visibity ? false : true,
                          controller: _passwordController,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 5) {
                              return 'Password is too short!';
                            }
                          },
                          onSaved: (value) {
                            _authData['password'] = value!;
                          }),
                    ),
                    IconButton(
                        onPressed: () {
                          visibilitycheck();
                          // setState(() {
                          //   visibity = !visibity;
                          // });
                        },
                        icon: visibity
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off))
                  ],
                ),
                AnimatedContainer(
                  constraints: BoxConstraints(
                    minHeight: _Authmode == Authmode.Signup ? 60 : 0,
                    maxHeight: _Authmode == Authmode.Signup ? 120 : 0,
                  ),
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                  child: FadeTransition(
                    opacity: _opacityAnimation!,
                    child: SlideTransition(
                      position: _slideAnimation!,
                      child: Row(
                        children: [
                          Icon(Icons.lock_outline),
                          Expanded(
                            child: TextFormField(
                              enabled: _Authmode == Authmode.Signup,
                              decoration: InputDecoration(
                                  labelText: 'Confirm Password'),
                              obscureText: true,
                              validator: _Authmode == Authmode.Signup
                                  ? (value) {
                                      if (value != _passwordController.text) {
                                        return 'Passwords do not match!';
                                      }
                                    }
                                  : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  ElevatedButton(
                    child:
                        Text(_Authmode == Authmode.Login ? 'LOGIN' : 'SIGN UP'),
                    onPressed: _submit,
                    // shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(30),
                    // ),
                    // padding:
                    //     EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                    // color: Theme.of(context).primaryColor,
                    // textColor: Colors.black
                    // Theme.of(context).primaryTextTheme.button.color,
                  ),
                ElevatedButton(
                  child: Text(
                      '${_Authmode == Authmode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                  onPressed: _switchAuthmode,
                  // padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                  // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  // textColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
