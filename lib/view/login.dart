import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ticketawy/view/dashed_divider.dart';
import 'package:ticketawy/view/register.dart';
import '../util.dart' as util;

import 'custom_widgets/CustomShowDialog.dart';

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
                child: Text(message.isEmpty?'Invalid login':message,
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

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    bool _isUnderDevelopment = false;
    
    String _userName = '';
    String _password = '';
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
                            if(_formKey.currentState.validate()){
                              setState(() {
                                _loggingIn = true;
                              });

                              Map response = await util.login(_userName, _password);

                              if(response.containsKey('token')){
                                Navigator.of(context).pushReplacementNamed('/home');
                              } else{
                                setState(() {
                                  _loggingIn = false;
                                });

                                _showLoginErrorDialog(context, message: response.containsKey('message')?response['message']:'');
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


          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          child: GestureDetector(
            onTap: () {
              if(_isUnderDevelopment){
                _showUnderDevelopmentDialog(context);
                return;
              }
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
