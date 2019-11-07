import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:responsive_container/responsive_container.dart';

import '../globals.dart';
import 'custom_widgets/CustomShowDialog.dart';
import 'dashed_divider.dart';
import '../util.dart' as util;

import 'home.dart';
import 'login.dart';
import 'registration_success.dart';
import 'verification.dart';

/// Class for the registration page

class Register extends StatefulWidget {

  /// Is it opened from home page?
  final bool openedFromHome;

  /// Is it opened from the event details page?
  final bool openedFromEventDescription;

  Register({
    @required this.openedFromHome,
    this.openedFromEventDescription = false,
  });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  bool _registering = false;
  bool _passwordShown = false;
  bool _passwordConfirmationShown = false;

  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String fullName = '';
  String phoneNumber = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return WillPopScope(
        child: Stack(
          children: <Widget>[

            /// The registration page body
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
                            image: AssetImage('assets/login.jpg'),
                        ),
                    ),
                  ),

                  //The registration form
                  ResponsiveContainer(
                    heightPercent: 100,
                    widthPercent: 100,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 50),
                    child: ListView(
                      children: <Widget>[

                        //Header Logo
                        ResponsiveContainer(
                          widthPercent: 25,
                          heightPercent: 22,
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/header.png',
                          ),
                        ),

                        Column(
                          children: <Widget>[
                            Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[

                                  // Dashed Divider
                                  ResponsiveContainer(
                                    child: DashedDivider(
                                      color: Colors.white30,
                                    ),
                                    widthPercent: 90,
                                    heightPercent: 3,
                                    padding:
                                        EdgeInsets.only(left: 30, right: 30),
                                  ),

                                  // sign up page title
                                  ResponsiveContainer(
                                    widthPercent: 100,
                                    heightPercent: 8,
                                    padding:
                                        EdgeInsets.only(left: 20, right: 20),
                                    child: Text(
                                      'Sign up',
                                      style: TextStyle(
                                          fontSize: _width > 360 ? 35 : 30,
                                          color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),

                                  // full name.
                                  ResponsiveContainer(
                                    heightPercent: 10,
                                    widthPercent: 100,
                                    padding: const EdgeInsets.only(
                                      left: 45.0,
                                      right: 45.0,
                                    ),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.go,
                                      controller: _fullNameController,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        prefixIcon: Icon(Icons.person_outline),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              style: BorderStyle.none,
                                            )),
                                        labelStyle: TextStyle(
                                          fontSize: 15,
                                        ),
                                        hintText: 'Full name',
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty)
                                          return 'Please enter your full name.';
                                        fullName = value;
                                        return null;
                                      },
                                    ),
                                  ),

                                  // mobile number.
                                  ResponsiveContainer(
                                    heightPercent: 10,
                                    widthPercent: 100,
                                    padding: const EdgeInsets.only(
                                      left: 45.0,
                                      right: 45.0,
                                    ),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.go,
                                      controller: _phoneController,
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        prefixIcon: Icon(Icons.phone_android),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              style: BorderStyle.none,
                                            )),
                                        labelStyle: TextStyle(
                                          fontSize: 15,
                                        ),
                                        hintText: 'Mobile Number',
                                      ),
                                      validator: (value) {
                                        Pattern pattern =
                                            r'(^(?:[+0]9)?[0-9]{11}$)';
                                        RegExp regex = new RegExp(pattern);
                                        if (value.isEmpty)
                                          return 'Please enter your mobile number.';
                                        if (!regex.hasMatch(value)) {
                                          return 'Invalid phone number';
                                        }
                                        phoneNumber = value;
                                        return null;
                                      },
                                    ),
                                  ),

                                  // Password.
                                  ResponsiveContainer(
                                    heightPercent: 10,
                                    widthPercent: 100,
                                    padding: const EdgeInsets.only(
                                      left: 45.0,
                                      right: 45.0,
                                    ),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.go,
                                      controller: _passwordController,
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
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                        else if (value.length < 6) {
                                          password = value;
                                          return 'Password must be at least six chacters ';
                                        }
                                        password = value;
                                        return null;
                                      },
                                    ),
                                  ),

                                  // Confirm Password
                                  ResponsiveContainer(
                                    heightPercent: 9,
                                    widthPercent: 100,
                                    padding: const EdgeInsets.only(
                                      left: 45.0,
                                      right: 45.0,
                                    ),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.go,
                                      controller: _confirmPasswordController,
                                      obscureText: _passwordConfirmationShown?false:true,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        prefixIcon: Icon(Icons.lock_outline),
                                        suffixIcon: Tooltip(
                                          message: _passwordConfirmationShown?'Hide Password':'Show Password',
                                          child: IconButton(
                                            icon: Icon(_passwordConfirmationShown?Icons.visibility:Icons.visibility_off),
                                            onPressed: (){
                                              setState(() {
                                                _passwordConfirmationShown = _passwordConfirmationShown?false:true;
                                              });
                                            },
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              style: BorderStyle.none,
                                            )),
                                        labelStyle: TextStyle(
                                          fontSize: 15,
                                        ),
                                        hintText: 'Confirm Password',
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty)
                                          return 'Please confirm your password';
                                        else if (value != password)
                                          return 'The password does not match your password';
                                        return null;
                                      },
                                    ),
                                  ),

                                  // register button
                                  ResponsiveContainer(
                                    heightPercent: 8,
                                    widthPercent: 100,
                                    padding: const EdgeInsets.only(
                                      left: 28.5,
                                      right: 28.5,
                                    ),
                                    child: ListTile(
                                      onTap: () async {
                                        Globals.skipped = false;
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
                                        if (_formKey.currentState.validate()) {
                                          setState(() {
                                            _registering = true;
                                          });
                                          Map response = await util.register(
                                              fullName, phoneNumber, password);

                                          if (response != null &&
                                              response['result']) {
                                            String id = response['id'];
                                            Map verificationResponse =
                                                await util
                                                    .sendVerificationMessage(
                                                        phoneNumber);

                                            if (verificationResponse[
                                                'result']) {
                                              _showVerificationDialog(
                                                  id: id,
                                                  password: password,
                                                  phoneNumber: phoneNumber);
                                              setState(() {
                                                _registering = false;
                                              });

                                              _fullNameController.value =
                                                  _fullNameController.value
                                                      .copyWith(text: '');
                                              _phoneController.value =
                                                  _phoneController.value
                                                      .copyWith(text: '');
                                              _passwordController.value =
                                                  _passwordController.value
                                                      .copyWith(text: '');
                                              _confirmPasswordController.value =
                                                  _confirmPasswordController
                                                      .value
                                                      .copyWith(text: '');
                                            }
                                          } else {
                                            setState(() {
                                              _registering = false;
                                            });
                                            _showRegistrationErrorDialog(
                                                context,
                                                message: response != null
                                                    ? response['user_Message']
                                                    : '');
                                          }
                                        }
                                      },
                                      title: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          color: Color(0xfffe6700),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Text(
                                            'Sign Up',
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

                                  // Sign in link text
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 15.0, top: 5),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (widget.openedFromHome)
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Login()));
                                        else
                                          Navigator.of(context).pop();
                                      },
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            'Have an account?',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 105, left: 105, top: 5),
                                            child: DashedDivider(
                                              width: 5,
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),

                  //The back arrow
                  Container(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                        onTap: () {
                          if (widget.openedFromHome)
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => Home()));
                          else
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
                  ),
                ],
              ),
            ),

            // The registration progress bar
            _registering
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
        onWillPop: () async {
          if (widget.openedFromHome) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Home()));
            return false;
          } else {
            return true;
          }
        });
  }

  ///Shows the verification dialog
  _showVerificationDialog({String phoneNumber, String id, String password}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return CustomAlertDialog(
            content: VerificationDialog(
              phoneNumber: phoneNumber,
              id: id,
              password: password,
              onSuccess: (id, message, password) {
                _showRegistrationSuccessDialog(context,
                    message: message,
                    id: id,
                    password: password,
                    openedFromEventDescription:
                        widget.openedFromEventDescription);
              },
            ),
          );
        });
  }
}

/// Shows the registration error dialog
_showRegistrationErrorDialog(BuildContext context, {String message}) {
  showDialog(
      barrierDismissible: false,
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
                  child: Text(
                    message.isEmpty ? 'Registration Failed' : message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Verdana',
                      fontSize: 17,
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


/// Shows the registration success dialog
_showRegistrationSuccessDialog(BuildContext context,
    {String message,
    String id,
    String password,
    bool openedFromEventDescription = false}) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CustomAlertDialog(
          content: Container(
            width: 300.0,
            height: 200.0,
            child: RegistrationSuccessDialog(
              message: message,
              password: password,
              id: id,
              openedFromEventDescription: openedFromEventDescription,
            ),
          ),
        );
      });
}
