import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticketawy/view/dashed_divider.dart';
import 'package:ticketawy/view/password_recovery.dart';
import 'package:ticketawy/view/register.dart';
import '../globals.dart';
import '../util.dart' as util;

import 'package:responsive_container/responsive_container.dart';
import 'custom_widgets/CustomShowDialog.dart';
import 'home.dart';
import 'registration_success.dart';
import 'verification.dart';

class Login extends StatefulWidget {
  final bool openedFromHome;
  final bool openedByDrawer;
  final bool openedFromEventDescription;

  Login({this.openedFromHome = true,
    this.openedByDrawer = false, this.openedFromEventDescription = false});
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _loggingIn = false;
  bool _passwordShown = false;

  _showLoginErrorDialog(BuildContext context, {String message}) {
    showDialog(
        context: context,
        builder: (context) {
          return CustomAlertDialog(
            content: Container(
              width: 300.0,
              height: 150.0,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Error',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'GeometriqueSans',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DashedDivider(),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        message.isEmpty ? 'Error when signing in' : message,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Verdana',
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    title: Container(
                      decoration: BoxDecoration(
                        color: Color(0xfffe6700),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Close',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  _showNoConnectivityDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return CustomAlertDialog(
            titlePadding: EdgeInsets.all(0),
            contentPadding: EdgeInsets.all(0),
            content: Container(
              width: 260.0,
              height: 230.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                      child: Container(
                    child: Text(
                      'Please check your internet connection and try again.',
                      style: TextStyle(
                        color: Color(0xfffe6700),
                        fontSize: 20,
                      ),
                    ),
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                  )),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    title: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        child: Text(
                          'Close',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xfffe6700),
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        padding: EdgeInsets.all(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    bool _isUnderDevelopment = false;


    String _userName = '';
    String _password = '';

    return WillPopScope(
      onWillPop: () async{
        if(widget.openedByDrawer){
          if(widget.openedFromHome)
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(
                builder: (context) => Home(
                  currentPageIndex:
                  PagesIndices.homePageIndex,
                )));
          else
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(
                builder: (context) => Home(
                  currentPageIndex:
                  PagesIndices.eventPageIndex,
                ))
            );
          return false;
        } else {
          return true;
        }
      },
      child: Stack(
        children: <Widget>[
          Globals.skipped
              ? Scaffold(
            body: Stack(
              children: <Widget>[
                // The background
                Container(
                  height: _height,
                  width: _width,
                  decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          //                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
                          image: AssetImage('assets/login.jpg'))),
                ),

                ResponsiveContainer(
                  heightPercent: 100,
                  widthPercent: 100,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 50),
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        children: <Widget>[
                          // Header logo
                          ResponsiveContainer(
                            child: Image.asset(
                              'assets/header.png',
                            ),
                            heightPercent: 25,
                            widthPercent: 30,
                            alignment: Alignment.center,
                          ),

                          // Dashed line
                          ResponsiveContainer(
                            child: DashedDivider(
                              color: Colors.white30,
                            ),
                            widthPercent: 0,
                            heightPercent: 3,
                            padding: EdgeInsets.only(left: 30, right: 30),
                          ),

                          // Login Text
                          ResponsiveContainer(
                            widthPercent: 0,
                            heightPercent: 8,
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 35),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          // User name.
                          ResponsiveContainer(
                            heightPercent: 10,
                            widthPercent: 0,
                            padding: const EdgeInsets.only(
                              left: 45.0,
                              right: 45.0,
                            ),
                            child: TextFormField(
                              controller: _phoneNumberController,
                              textInputAction: TextInputAction.go,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon: Icon(Icons.phone_android),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      style: BorderStyle.none,
                                    )),
                                labelStyle: TextStyle(
                                  fontSize: 15,
                                ),
                                hintText: 'Mobile Number',
                              ),
                              validator: (value) {
                                if (value.isEmpty)
                                  return 'Please enter your mobile number';
                                //                          else if(value != mobile)
                                //                            return 'Wrong mobile number';
                                _userName = value;
                                return null;
                              },
                            ),
                          ),

                          // Password.
                          ResponsiveContainer(
                            heightPercent: 10,
                            widthPercent: 0,
                            padding: const EdgeInsets.only(
                              left: 45.0,
                              right: 45.0,
                            ),
                            child: TextFormField(
                              controller: _passwordController,
                              textInputAction: TextInputAction.go,
                              obscureText: _passwordShown?false:true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon: Icon(Icons.lock_outline),
                                suffixIcon: Tooltip(
                                  message: _passwordShown?'Hide Password':'Show Password',
                                  child: IconButton(
                                    icon: Icon(_passwordShown?Icons.visibility:Icons.visibility_off),
                                    onPressed: (){
                                      setState(() {
                                        _passwordShown = _passwordShown?false:true;
                                      });
                                    },
                                  ),
                                ),

                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      style: BorderStyle.none,
                                    )),
                                labelStyle: TextStyle(
                                  fontSize: 15,
                                ),
                                hintText: 'Password',
                              ),
                              validator: (value) {
                                if (value.isEmpty)
                                  return 'Please enter your password';
                                //                          else if(value != password)
                                //                            return 'Wrong password';
                                _password = value;
                                return null;
                              },
                            ),
                          ),

                          // login button
                          ResponsiveContainer(
                            heightPercent: 9,
                            widthPercent: 0,
                            padding: const EdgeInsets.only(
                              left: 30.0,
                              right: 30.0,
                            ),
                            child: ListTile(
                              onTap: () async {

                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    _loggingIn = true;
                                  });

                                  Map response = await util.login(
                                      _userName, _password);

                                  if (response != null && response['result'] == true) {
                                    Globals.userPassword = _password;
                                    Globals.userId = response['id'];

                                    Map userData = await util.getUserDetails();

                                    SharedPreferences prefs =
                                    await SharedPreferences
                                        .getInstance();

                                    prefs.setString(
                                        'userId', response['id']);
                                    prefs.setString(
                                        'fullName', userData['fullName']);
                                    prefs.setString(
                                        'phoneNumber', _userName);
                                    prefs.setString('password', _password);

                                    Globals.skipped = false;
                                    if(widget.openedFromHome)
                                      Navigator.of(context)
                                          .pushReplacement(MaterialPageRoute(
                                          builder: (context) => Home(
                                            currentPageIndex:
                                            PagesIndices
                                                .homePageIndex,
                                          )));
                                    else
                                      Navigator.of(context)
                                          .pushReplacement(MaterialPageRoute(
                                          builder: (context) => Home(
                                            currentPageIndex:
                                            PagesIndices
                                                .eventPageIndex,
                                          )));
                                  } else if (response != null && response['result'] == 2) {
                                    setState(() {
                                      _loggingIn = false;
                                    });

                                    _showVerificationDialog(
                                        phoneNumber: _userName,
                                        password: _password);
                                  } else {
                                    setState(() {
                                      _loggingIn = false;
                                    });

                                    _showLoginErrorDialog(context,
                                        message: response != null?response['user_Message']:'');
                                  }

                                }
                              },
                              title: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                  color: Color(0xfffe6700),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    'Sign In',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          //Forgot Password
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                _phoneNumberController.value = _phoneNumberController.value.copyWith(text: '');
                                _passwordController.value = _passwordController.value.copyWith(text: '');
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PasswordRecovery()));
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            'Forgot Password?',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 105,
                                                left: 105,
                                                top: 5),
                                            child: DashedDivider(
                                              width: 5,
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          ),

                          // Sign up link text
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                _phoneNumberController.value = _phoneNumberController.value.copyWith(text: '');
                                _passwordController.value = _passwordController.value.copyWith(text: '');
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                                    builder: (context) => Register(
                                      openedFromHome: false,
                                      openedFromEventDescription: widget.openedFromEventDescription,
                                    )));
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            'Don\'t have an account?',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 105,
                                                left: 105,
                                                top: 5),
                                            child: DashedDivider(
                                              width: 5,
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                Globals.skipped
                    ? //The back arrow
                Container(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                      onTap: () async {
                        if (_isUnderDevelopment) {
                          _showUnderDevelopmentDialog(context);
                          return;
                        }
                        Globals.skipped = true;

                        if(widget.openedFromHome)
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                              builder: (context) => Home(
                                currentPageIndex:
                                PagesIndices.homePageIndex,
                              )));
                        else
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                              builder: (context) => Home(
                                currentPageIndex:
                                PagesIndices.eventPageIndex,
                              ))
                          );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 40, bottom: 40, left: 20, right: 40),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 30,
                        ),
                      )),
                )
                    : Container(),
              ],
            ),
          )
              : Scaffold(
            body: Stack(
              children: <Widget>[
                // The background
                Container(
                  height: _height,
                  width: _width,
                  decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      image: DecorationImage(
                          fit: BoxFit.fill,
//                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
                          image: AssetImage('assets/login.jpg'))),
                ),

                ResponsiveContainer(
                  heightPercent: 100,
                  widthPercent: 100,
                  padding: EdgeInsets.only(top: 50),
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        children: <Widget>[

                          // Header logo
                          ResponsiveContainer(
                            child: Image.asset(
                              'assets/header.png',
                            ),
                            heightPercent: 25,
                            widthPercent: 30,
                            alignment: Alignment.center,
                          ),

                          // Dashed Line
                          ResponsiveContainer(
                            child: DashedDivider(
                              color: Colors.white30,
                            ),
                            widthPercent: 0,
                            heightPercent: 3,
                            padding: EdgeInsets.only(left: 30, right: 30),
                          ),

                          // Login Text
                          ResponsiveContainer(
                            widthPercent: 0,
                            heightPercent: 8,
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                  fontSize: 35, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          // User name.
                          ResponsiveContainer(
                            heightPercent: 10,
                            widthPercent: 0,
                            padding: const EdgeInsets.only(
                              left: 45.0,
                              right: 45.0,
                            ),
                            child: TextFormField(
                              controller: _phoneNumberController,
                              textInputAction: TextInputAction.go,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon: Icon(Icons.phone_android),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      style: BorderStyle.none,
                                    )),
                                labelStyle: TextStyle(
                                  fontSize: 15,
                                ),
                                hintText: 'Mobile Number',
                              ),
                              validator: (value) {
                                if (value.isEmpty)
                                  return 'Please enter your mobile number';
//                          else if(value != mobile)
//                            return 'Wrong mobile number';
                                _userName = value;
                                return null;
                              },
                            ),
                          ),

                          // Password.
                          ResponsiveContainer(
                            heightPercent: 10,
                            widthPercent: 0,
                            padding: const EdgeInsets.only(
                              left: 45.0,
                              right: 45.0,
                            ),
                            child: TextFormField(
                              controller: _passwordController,
                              textInputAction: TextInputAction.go,
                              obscureText: _passwordShown?false:true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon: Icon(Icons.lock_outline,),
                                suffixIcon: Tooltip(
                                  message: _passwordShown?'Hide Password':'Show Password',
                                  child: IconButton(
                                    icon: Icon(_passwordShown?Icons.visibility:Icons.visibility_off),
                                    onPressed: (){
                                      setState(() {
                                        _passwordShown = _passwordShown?false:true;
                                      });
                                    },
                                  ),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      style: BorderStyle.none,
                                    )),
                                labelStyle: TextStyle(
                                  fontSize: 15,
                                ),
                                hintText: 'Password',
                              ),
                              validator: (value) {
                                if (value.isEmpty)
                                  return 'Please enter your password';
//                          else if(value != password)
//                            return 'Wrong password';
                                _password = value;
                                return null;
                              },
                            ),
                          ),


                          // login button
                          ResponsiveContainer(
                            heightPercent: 9,
                            widthPercent: 0,
                            padding: const EdgeInsets.only(
                              left: 30.0,
                              right: 30.0,
                            ),
                            child: ListTile(
                              onTap: () async {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                var connectivityResult =
                                await Connectivity()
                                    .checkConnectivity();
                                if (connectivityResult !=
                                    ConnectivityResult.mobile &&
                                    connectivityResult !=
                                        ConnectivityResult.wifi) {
                                  _showNoConnectivityDialog();
                                  return;
                                }

                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    _loggingIn = true;
                                  });

                                  Map response = await util.login(
                                      _userName, _password);

                                  if (response != null && response['result'] == true) {
                                    Globals.skipped = false;
                                    Globals.userPassword = _password;
                                    Globals.userId = response['id'];

                                    Map userData = await util.getUserDetails();

                                    SharedPreferences prefs =
                                    await SharedPreferences
                                        .getInstance();

                                    prefs.setString(
                                        'userId', response['id']);
                                    prefs.setString(
                                        'fullName', userData['fullName']);
                                    prefs.setString(
                                        'phoneNumber', _userName);
                                    prefs.setString('password', _password);

                                    Navigator.of(context)
                                        .pushReplacementNamed('/home');
                                  } else if (response != null && response['result'] == 2) {
                                    Map verificationResponse = await util.sendVerificationMessage(_userName);
                                    if (verificationResponse['result']){
                                      setState(() {
                                        _loggingIn = false;
                                      });

                                      _showVerificationDialog(
                                          phoneNumber: _userName,
                                          password: _password);
                                    }

                                  } else {
                                    setState(() {
                                      _loggingIn = false;
                                    });

                                    _showLoginErrorDialog(context,
                                        message: response != null?response['user_Message']:'');
                                  }
                                }
                              },
                              title: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                  color: Color(0xfffe6700),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    'Sign In',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          //Forgot Password
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                _phoneNumberController.value = _phoneNumberController.value.copyWith(text: '');
                                _passwordController.value = _passwordController.value.copyWith(text: '');
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PasswordRecovery()));
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            'Forgot Password?',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 105,
                                                left: 105,
                                                top: 5),
                                            child: DashedDivider(
                                              width: 5,
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          ),

                          // Sign up link text
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                _phoneNumberController.value = _phoneNumberController.value.copyWith(text: '');
                                _passwordController.value = _passwordController.value.copyWith(text: '');
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                                    builder: (context) => Register(
                                      openedFromHome: false,
                                    )));
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            'Don\'t have an account?',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 105,
                                                left: 105,
                                                top: 5),
                                            child: DashedDivider(
                                              width: 5,
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                Globals.skipped
                    ? //The back arrow
                Container(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 40, bottom: 40, left: 20, right: 40),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 30,
                        ),
                      )),
                )
                    : Container(),
              ],
            ),
            bottomNavigationBar: BottomAppBar(
              color: Colors.black,
              child: GestureDetector(
                onTap: () async {
                  if (_isUnderDevelopment) {
                    _showUnderDevelopmentDialog(context);
                    return;
                  }
                  var connectivityResult =
                  await Connectivity().checkConnectivity();
                  if (connectivityResult != ConnectivityResult.mobile &&
                      connectivityResult != ConnectivityResult.wifi) {
                    _showNoConnectivityDialog();
                    return;
                  }
                  setState(() {
                    _loggingIn = true;
                  });

                  Globals.skipped = true;
                  Navigator.of(context).pushReplacementNamed('/home');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(15),
                        color: Color(0xfffe6700),
                        child: Text(
                          'Skip This Step',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          _loggingIn
              ? Positioned(
            top: 0.0,
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              color: Colors.black.withOpacity(0.5),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SpinKitFadingCircle(
                    itemBuilder: (context , int index) {
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffff6600),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          )
              : Container(),
        ],
      ),
    );
  }

  _showVerificationDialog({String phoneNumber, String id, String password}) {
    showDialog(
        context: context,
        builder: (context) {
          return CustomAlertDialog(
            content: VerificationDialog(
              phoneNumber: phoneNumber,
              id: id != null ? id : '',
              password: password,
              onSuccess: (id, message, password) {
                _showRegistrationSuccessDialog(context, id: id,
                    message: message, password: password);
              },
            ),
          );
        });
  }

  _showRegistrationSuccessDialog(BuildContext context,
      {String message, String id, String password}) {
    showDialog(
        context: context,
        builder: (context) {
          return CustomAlertDialog(
            content: Container(
              width: 300.0,
              height: 200.0,
              child: RegistrationSuccessDialog(message: message, password: password, id: id),
            ),
          );
        });
  }

  _showUnderDevelopmentDialog(context) {
    showDialog(
        context: context,
        builder: (context) {
          return CustomAlertDialog(
            titlePadding: EdgeInsets.all(0),
            contentPadding: EdgeInsets.all(0),
            content: Container(
              width: MediaQuery.of(context).size.width > 360 ? 400.0 : 300,
              height: MediaQuery.of(context).size.width > 360 ? 150.0 : 150,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(33.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Not available during the development of the app.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize:
                            MediaQuery.of(context).size.width > 360 ? 20 : 18,
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    title: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffff6600),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Close',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

