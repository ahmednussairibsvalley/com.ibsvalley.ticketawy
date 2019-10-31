import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ticketawy/view/new_password.dart';

import '../util.dart' as util;
import 'custom_widgets/CustomShowDialog.dart';
import 'dashed_divider.dart';
import 'verification.dart';

class PasswordRecovery extends StatefulWidget {
  @override
  _PasswordRecoveryState createState() => _PasswordRecoveryState();
}

class _PasswordRecoveryState extends State<PasswordRecovery> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController _phoneController = TextEditingController();

//  String _phoneNumber = '';

  bool _recovering = false;

  _showVerificationDialog({String phoneNumber, String id, String password,}){

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return CustomAlertDialog(
            content: VerificationDialog(
              forJustPhoneConfirmation: true,
              phoneNumber: phoneNumber,
              id: id, password: password,
              onSuccess: (id , message , password ) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => NewPassword(
                  phone: phoneNumber,
                )));
              },
            ),
          );
        });
  }

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
                      Padding(
                        padding: EdgeInsets.only(
                            left: 20, right: 20),
                        child: Text('Recover your password',
                          style: TextStyle(
                              fontSize: _width > 360?35:30,
                              color: Colors.white
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 45.0,
                            right: 45.0,
                            bottom: 8.0,
                            top: 20.0,
                          ),
                          child: TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
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
                              Pattern pattern =
                                  r'(^(?:[+0]9)?[0-9]{11}$)';
                              RegExp regex = new RegExp(pattern);
                              if (value.isEmpty)
                                return 'Please enter your mobile number.';
                              if(!regex.hasMatch(value)){
                                return 'Invalid phone number';
                              }
//                              _phoneNumber = value;
                              return null;
                            },
                          ),
                        ),
                      ),


                      // recover password button
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
                                _recovering = true;
                              });

                              Map response = await util.sendVerificationMessage(_phoneController.text);

                              print('$response');

                              setState(() {
                                _recovering = false;
                              });

                              if(response['result'] == true || response['result'] == 'true'){
                                _showVerificationDialog(
                                  phoneNumber: _phoneController.text,
                                  id: response['id'],
                                );

                              } else {
                                _showResultDialog(context, response['user_Message']);
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
                                'Reset password',
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
        _recovering? Positioned(
          top: 0.0, bottom: 0.0, left: 0.0, right: 0.0,
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
        ):
        Container(),
      ],
    );
  }

  _showResultDialog(BuildContext context, String message){
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
                        child: Text(message != null?message:'The number is not registered',
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
