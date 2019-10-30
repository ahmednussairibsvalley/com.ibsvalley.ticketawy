import 'package:flutter/material.dart';

import 'custom_widgets/CustomShowDialog.dart';
import 'dashed_divider.dart';
import '../util.dart' as util;

class NewPassword extends StatefulWidget {

  final String phone;

  NewPassword({@required this.phone,});
  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {

  final _formKey = GlobalKey<FormState>();
  bool _passwordShown = false;
  bool _passwordConfirmationShown = false;
  @override
  Widget build(BuildContext context) {

    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    bool _passwordUpdating = false;


    String _newPassword = '';

    print('The phone: ${widget.phone}');

    return Stack(
      children: <Widget>[
        Scaffold(
          body: Stack(
            children: <Widget>[
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

                      // New Password
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 45.0,
                          right: 45.0,
                          bottom: 8.0,
                          top: 20.0,
                        ),
                        child: TextFormField(
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
                            hintText: 'New Password',

                          ),
                          validator: (value) {
                            if (value.isEmpty)
                              return 'Please enter your new password.';
                            _newPassword = value;
                            return null;
                          },
                        ),
                      ),

                      // Confirm new password
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 45.0,
                          right: 45.0,
                          bottom: 8.0,
                          top: 20.0,
                        ),
                        child: TextFormField(
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
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  style: BorderStyle.none,
                                )),
                            labelStyle: TextStyle(
                              fontSize: 15,
                            ),
                            hintText: 'Confirm New Password',

                          ),
                          validator: (value) {
                            if (value.isEmpty)
                              return 'Please confirm your password.';
                            else if(_newPassword.isEmpty)
                              return 'Please enter your password first and then confirm!';
                            else if(value != _newPassword)
                              return 'Password does not match!';
                            return null;
                          },
                        ),
                      ),

                      // update password button
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
                                _passwordUpdating = true;
                              });

                              Map response = await util.updatePassword(
                                  phoneNumber: widget.phone,
                                  newPassword: _newPassword
                              );

                              print('$response');

                              setState(() {
                                _passwordUpdating = false;
                              });

                              _showResultDialog(context, response['user_Message'], (){
                                Navigator.of(context).pop();
                              }, response['result']);
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
                                'Update password',
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
                    ],
                  ),
                ),
              ),

              //The back arrow
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
              ),
            ],
          ),
        ),
        _passwordUpdating? Positioned(
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

  _showResultDialog(BuildContext context, String message, Function onPasswordUpdate, bool passwordUpdated){
    showDialog(
        barrierDismissible: false,
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
                        child: Text('$message',
                          textAlign: TextAlign.center,
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
                      if(passwordUpdated)
                        onPasswordUpdate();
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
}
