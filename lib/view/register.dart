import 'package:flutter/material.dart';

import 'custom_widgets/CustomShowDialog.dart';
import 'dashed_divider.dart';
import '../util.dart' as util;

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final _formKey = GlobalKey<FormState>();

  bool _registering = false;

  String phoneNumber = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Stack(
      children: <Widget>[
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
//                      colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
                        image: AssetImage('assets/login.jpg')
                    )
                ),
              ),

              //The registration form
              Positioned(
                left: 0.0,
                right: 0.0,
                top: _width > 360?_height / 11:_height / 25,
                bottom: 0.0,
                child: ListView(
                  children: <Widget>[
                    Image.asset('assets/header.png', width: 300, height: 195,),
                    Column(
                      children: <Widget>[
                        Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 20, bottom: 20, left: 50, right: 50,),
                                child: DashedDivider(
                                  color: Colors.white30,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20),
                                child: Text('Register',style: TextStyle(fontSize: 35,color: Colors.white),textAlign: TextAlign.center,),
                              ),
                              // User name.
                              Padding(
                                padding: const EdgeInsets.only(left: 45.0, right: 45.0, bottom: 8.0, top: 20.0,),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    prefixIcon: Icon(Icons.person_outline),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          style: BorderStyle.none,
                                        )
                                    ),
                                    labelStyle: TextStyle(
                                      fontSize: 15,
                                    ),
                                    hintText: 'Mobile Number',
                                  ),
                                  validator: (value){
                                    if(value.isEmpty)
                                      return 'Please enter your mobile number.';
                                    phoneNumber = value;
                                    return null;
                                  },
                                ),
                              ),

                              // Password.
                              Padding(
                                padding: const EdgeInsets.only(left: 45.0, right: 45.0, bottom: 8.0, top: 8.0,),
                                child: TextFormField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    prefixIcon: Icon(Icons.lock_outline),
//                                  suffixIcon: Icon(Icons.help_outline),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          style: BorderStyle.none,
                                        )
                                    ),
                                    labelStyle: TextStyle(
                                      fontSize: 15,
                                    ),
                                    hintText: 'Password',
                                  ),
                                  validator: (value){
                                    if(value.isEmpty)
                                      return 'Please enter your password';
                                    password = value;
                                    return null;
                                  },
                                ),
                              ),

                              // Confirm Password
                              Padding(
                                padding: const EdgeInsets.only(left: 45.0, right: 45.0, bottom: 8.0, top: 8.0,),
                                child: TextFormField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    prefixIcon: Icon(Icons.lock_outline),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          style: BorderStyle.none,
                                        )
                                    ),
                                    labelStyle: TextStyle(
                                      fontSize: 15,
                                    ),
                                    hintText: 'Confirm Password',
                                  ),
                                  validator: (value){
                                    if(value.isEmpty)
                                      return 'Please confirm your password';
                                    else if(value != password)
                                      return 'The password does not match your password';
                                    return null;
                                  },
                                ),
                              ),

                              // register button
                              Padding(
                                padding: const EdgeInsets.only(left: 28.5, right: 28.5,),
                                child: ListTile(

                                  onTap: () async{
                                    if(_formKey.currentState.validate()){
                                      setState(() {
                                        _registering = true;
                                      });
                                      Map response = await util.register(phoneNumber, password);

                                      bool succeeded = response['succeeded'];

                                      if(succeeded){
                                        setState(() {
                                          _registering = false;
                                        });
                                        _showRegistrationSuccessDialog(context);
                                      } else {
                                        setState(() {
                                          _registering = false;
                                        });
                                        _showRegistrationErrorDialog(context, message: response['errors'][0]['description']);
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
                                      child: Text('Sign Up',
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
                              GestureDetector(
                                onTap: (){
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
                                      padding: const EdgeInsets.only(right: 105, left: 105, top: 5),
                                      child: DashedDivider(
                                        width: 5,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
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
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                    )
                ),
              ),
            ],
          ),
        ),
        _registering? Positioned(
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

  _showRegistrationErrorDialog(BuildContext context, {String message}){

    showDialog(context: context, builder: (context){
      return CustomAlertDialog(
        content: Container(
          width: 300.0,
          height: 200.0,
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
                child: Text(message.isEmpty?'Registration Failed':message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Verdana',
                    fontSize: 17,
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

  _showRegistrationSuccessDialog(BuildContext context){

    showDialog(context: context, builder: (context){
      return CustomAlertDialog(
        content: Container(
          width: 300.0,
          height: 200.0,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Success', textAlign: TextAlign.center,
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
                child: Text('Registered With Success',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Verdana',
                    fontSize: 17,
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
}
