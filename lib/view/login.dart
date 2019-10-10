import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticketawy/view/dashed_divider.dart';
import 'package:ticketawy/view/register.dart';
import '../globals.dart';
import '../util.dart' as util;

import '../util.dart';
import 'custom_widgets/CustomShowDialog.dart';
import 'verification.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  bool _loggingIn = false;


  
  _showLoginErrorDialog(BuildContext context, {String message}){

    showDialog(context: context, builder: (context){
      return CustomAlertDialog(
        content: Container(
          width: 300.0,
          height: 150.0,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Error', textAlign: TextAlign.center,
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
                  child: Text(message.isEmpty?'Invalid login':message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Verdana',
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              ListTile(
                onTap: (){
                  Navigator.of(context).pop();
                },
                title: Container(
                  decoration: BoxDecoration(
                    color: Color(0xfffe6700),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Close', textAlign: TextAlign.center,),
                  ),

                ),
              )
            ],
          ),
        ),
      );
    });
  }

  _showNoConnectivityDialog(){
    showDialog(
        context: context,
        builder: (context){
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
                        child: Text('Please check your internet connection and try again.',
                          style: TextStyle(
                            color: Color(0xfffe6700),
                            fontSize: 20,
                          ),
                        ),
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                      )
                  ),
                  ListTile(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    title: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        child: Text('Close',
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
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;


    bool _isUnderDevelopment = true;
    
    String _userName = '';
    String _password = '';
    return Stack(
      children: <Widget>[
        Globals.skipped?
        Scaffold(
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

              Positioned(
                left: 0.0,
                right: 0.0,
                top: _width > 360? _height / 11 : _height / 13,
                bottom: 0.0,
                child: GestureDetector(
                  onTap: (){
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: <Widget>[
                        Image.asset(
                          'assets/header.png',
                          width: 300,
                          height: 195,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 20, left: 50, right: 50,),
                          child: DashedDivider(
                            color: Colors.white30,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 20, right: 20),
                          child: Text('login',style: TextStyle(fontSize: 35,color: Colors.white),textAlign: TextAlign.center,),
                        ),

                        // User name.
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 45.0,
                            right: 45.0,
                            bottom: 8.0,
                            top: 20.0,
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: Icon(Icons.person_outline),
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
                              if(value.isEmpty)
                                return 'Please enter your mobile number';
  //                          else if(value != mobile)
  //                            return 'Wrong mobile number';
                              _userName = value;
                              return null;
                            },
                          ),
                        ),

                        // Password.
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 45.0,
                            right: 45.0,
                            bottom: 8.0,
                            top: 8.0,
                          ),
                          child: TextFormField(

                            obscureText: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: Icon(Icons.lock_outline),
  //                          suffixIcon: Icon(Icons.help_outline),
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
                              if(value.isEmpty)
                                return 'Please enter your password';
  //                          else if(value != password)
  //                            return 'Wrong password';
                              _password = value;
                              return null;
                            },
                          ),
                        ),

                        // login button
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 30.0,
                            right: 30.0,
                            top: 1.0,
                          ),
                          child: ListTile(
                            onTap: () async {
                              Globals.skipped = false;
                              FocusScope.of(context).requestFocus(FocusNode());
                              if(_formKey.currentState.validate()){
                                setState(() {
                                  _loggingIn = true;
                                });

                                Map response = await util.login(_userName, _password);

                                if(response['result']){
                                  Globals.userPassword = _password;
                                  Globals.userId = response['id'];

                                  Map userData = await getUserDetails();

                                  Globals.controller.populateUser(userData);

                                  SharedPreferences prefs = await SharedPreferences.getInstance();

                                  prefs.setString('userId', response['id']);
                                  prefs.setString('fullName', userData['fullName']);
                                  prefs.setString('phoneNumber', _userName);
                                  prefs.setString('password', _password);

                                  List categoriesList = await categoryList();

                                  Globals.controller.populateCategories(categoriesList);
                                  Navigator.of(context).pushReplacementNamed('/home');
                                } else{
                                  setState(() {
                                    _loggingIn = false;
                                  });

                                  _showLoginErrorDialog(context, message: response['user_Message']);
                                }

                              }
                            },
                            title: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                color: Color(0xfffe6700),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  'login',
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

                        // Sign up link text
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Register()));
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
                                        padding: const EdgeInsets.only(right: 105, left: 105, top: 5),
                                        child: DashedDivider(
                                          width: 5,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  )
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),

              Globals.skipped?//The back arrow
              Container(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                    onTap: () async{
                      if(_isUnderDevelopment){
                        _showUnderDevelopmentDialog(context);
                        return;
                      }
                      Globals.skipped = true;
//              Map userData = await getUserDetails();
//
//              Globals.controller.populateUser(userData);
                      List categoriesList = await categoryList();

                      Globals.controller.populateCategories(categoriesList);
                      Navigator.of(context).pushReplacementNamed('/home');
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40, bottom: 40 , left: 20, right: 40),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                    )),
              ): Container(),
            ],
          ),
        )
        :Scaffold(
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

              Positioned(
                left: 0.0,
                right: 0.0,
                top: _width > 360? _height / 11 : _height / 13,
                bottom: 0.0,
                child: GestureDetector(
                  onTap: (){
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: <Widget>[
                        Image.asset(
                          'assets/header.png',
                          width: 300,
                          height: 195,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 20, left: 50, right: 50,),
                          child: DashedDivider(
                            color: Colors.white30,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 20, right: 20),
                          child: Text('login',style: TextStyle(fontSize: 35,color: Colors.white),textAlign: TextAlign.center,),
                        ),

                        // User name.
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 45.0,
                            right: 45.0,
                            bottom: 8.0,
                            top: 20.0,
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: Icon(Icons.person_outline),
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
                              if(value.isEmpty)
                                return 'Please enter your mobile number';
//                          else if(value != mobile)
//                            return 'Wrong mobile number';
                              _userName = value;
                              return null;
                            },
                          ),
                        ),

                        // Password.
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 45.0,
                            right: 45.0,
                            bottom: 8.0,
                            top: 8.0,
                          ),
                          child: TextFormField(

                            obscureText: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: Icon(Icons.lock_outline),
//                          suffixIcon: Icon(Icons.help_outline),
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
                              if(value.isEmpty)
                                return 'Please enter your password';
//                          else if(value != password)
//                            return 'Wrong password';
                              _password = value;
                              return null;
                            },
                          ),
                        ),

                        // login button
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 30.0,
                            right: 30.0,
                            top: 1.0,
                          ),
                          child: ListTile(
                            onTap: () async {

                              FocusScope.of(context).requestFocus(FocusNode());
                              var connectivityResult = await Connectivity().checkConnectivity();
                              if (connectivityResult != ConnectivityResult.mobile &&
                                  connectivityResult != ConnectivityResult.wifi){
                                _showNoConnectivityDialog();
                                return;
                              }
                              if(_formKey.currentState.validate()){
                                setState(() {
                                  _loggingIn = true;
                                });

                                Map response = await util.login(_userName, _password);

                                if(response['result'] == true){
                                  Globals.skipped = false;
                                  Globals.userPassword = _password;
                                  Globals.userId = response['id'];

                                  Map userData = await getUserDetails();

                                  Globals.controller.populateUser(userData);

                                  SharedPreferences prefs = await SharedPreferences.getInstance();

                                  prefs.setString('userId', response['id']);
                                  prefs.setString('fullName', userData['fullName']);
                                  prefs.setString('phoneNumber', _userName);
                                  prefs.setString('password', _password);

                                  List categoriesList = await categoryList();

                                  Globals.controller.populateCategories(categoriesList);
                                  Navigator.of(context).pushReplacementNamed('/home');
                                } else if(response['result'] == 2){
                                  setState(() {
                                    _loggingIn = false;
                                  });

                                  _showVerificationDialog(phoneNumber: _userName, password: _password);
                                } else{
                                  setState(() {
                                    _loggingIn = false;
                                  });

                                  _showLoginErrorDialog(context, message: response['user_Message']);
                                }

                              }
                            },
                            title: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                color: Color(0xfffe6700),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  'login',
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

                        // Sign up link text
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Register()));
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
                                        padding: const EdgeInsets.only(right: 105, left: 105, top: 5),
                                        child: DashedDivider(
                                          width: 5,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  )
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),

              Globals.skipped?//The back arrow
              Container(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40, bottom: 40 , left: 20, right: 40),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                    )),
              ): Container(),
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            color: Colors.black,
            child: GestureDetector(
              onTap: () async {
                if(_isUnderDevelopment){
                  _showUnderDevelopmentDialog(context);
                  return;
                }
                var connectivityResult = await Connectivity().checkConnectivity();
                if (connectivityResult != ConnectivityResult.mobile &&
                    connectivityResult != ConnectivityResult.wifi){
                  _showNoConnectivityDialog();
                  return;
                }
                setState(() {
                  _loggingIn = true;
                });
                Globals.skipped = true;
//              Map userData = await getUserDetails();
//
//              Globals.controller.populateUser(userData);
                List categoriesList = await categoryList();

                Globals.controller.populateCategories(categoriesList);
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
        _loggingIn? Positioned(
          top: 0.0, bottom: 0.0, left: 0.0, right: 0.0,
          child: Container(
            color: Colors.black.withOpacity(0.5),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
              ],
            ),
          ),
        ):
        Container(),
      ],
    );
  }

  _showVerificationDialog({String phoneNumber, String id, String password}){

    showDialog(
        context: context,
        builder: (context) {
          return CustomAlertDialog(
            content: VerificationDialog(
              phoneNumber: phoneNumber,
              id: id != null?id:'', password: password,
              onSuccess: (id , message , password ) {
                _showRegistrationSuccessDialog(context, message: message, password: password);
              },
            ),
          );
        });
  }

  _showRegistrationSuccessDialog(BuildContext context, {String message, String id, String password}) {
    showDialog(
        context: context,
        builder: (context) {
          return CustomAlertDialog(
            content: Container(
              width: 300.0,
              height: 200.0,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      message.isNotEmpty && message != null
                          ? message
                          : 'Success',
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
                    child: Text(
                      'Registered With Success',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Verdana',
                        fontSize: 17,
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: ()async {
                      Globals.skipped = false;
                      Globals.userPassword = password != null && password.isNotEmpty?password:'';
//                    Globals.userId = response['id'];
                      Globals.userId = id != null && id.isNotEmpty ?id:'';
                      Map userData = await getUserDetails();

                      Globals.controller.populateUser(userData);
                      List categoriesList = await categoryList();

                      Globals.controller.populateCategories(categoriesList);

                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.setString('userId', id != null && id.isNotEmpty ?id:'');
                      prefs.setString('fullName', userData['fullName']);
                      prefs.setString('phoneNumber', userData['phoneNumber']);
                      prefs.setString('password', password != null && password.isNotEmpty?password:'');

                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacementNamed('/home');
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

  _showUnderDevelopmentDialog(context) {
    showDialog(
        context: context,
        builder: (context) {
          return CustomAlertDialog(
            titlePadding: EdgeInsets.all(0),
            contentPadding: EdgeInsets.all(0),
            content: Container(
              width: MediaQuery.of(context).size.width > 360 ? 400.0 : 300,
              height: MediaQuery.of(context).size.width > 360 ?150.0 : 150,
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
                    child: Text('Not available during the development of the app.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width > 360 ? 20: 18,
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    title: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffff6600),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('Close',
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
