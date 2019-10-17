import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import 'dashed_divider.dart';
import '../util.dart' as util;

class VerificationDialog extends StatefulWidget {

  final String phoneNumber;
  final String id;
  final String password;
  final Function(String, String, String) onSuccess;
  final bool forJustPhoneConfirmation;

  VerificationDialog({@required this.phoneNumber, this.password, this.id,
    @required this.onSuccess, this.forJustPhoneConfirmation = false});
  @override
  _VerificationDialogState createState() => _VerificationDialogState();
}

class _VerificationDialogState extends State<VerificationDialog> {

  final _verificationController = MaskedTextController(mask: '000000',);

  String _message = '';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: (){
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
            width: 300.0,
            height: 300.0,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'An SMS sent to you with verification code.'
                        'Please enter the code and press OK',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'GeometriqueSans',
                    ),
                  ),
                ),

                // Divider
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DashedDivider(),
                ),


                TextFormField(
                  onTap: (){
                    setState(() {
                      _message = '';
                    });
                  },
                  onChanged: (value){
                    setState(() {
                      _message = '';
                    });
                  },
                  controller: _verificationController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    hintText: 'Enter the verification code',
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: _message.isNotEmpty?
                  Text(_message, textAlign: TextAlign.center,)
                      : Padding(
                    padding: const EdgeInsets.all(15),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    // Confirm
                    GestureDetector(
                      onTap: () async{
                        if(widget.forJustPhoneConfirmation){
                          Map response = await util.confirmPasswordCode(phoneNumber: widget.phoneNumber, code: _verificationController.text);
                          if(response['result']){
                            Navigator.of(context).pop();
//                      _showRegistrationSuccessDialog(context, message: response['user_Message'],id: widget.id, password: widget.password);
                            widget.onSuccess(response['id'], response['user_Message'], widget.password);
                          } else {
                            setState(() {
                              _message = response['user_Message'];
                            });
                          }
                        } else {
                          Map response = await util.verifyPhone(widget.phoneNumber, _verificationController.text);
                          if(response['result']){
                            Navigator.of(context).pop();
//                      _showRegistrationSuccessDialog(context, message: response['user_Message'],id: widget.id, password: widget.password);
                            widget.onSuccess(response['id'], response['user_Message'], widget.password);
                          } else {
                            setState(() {
                              _message = response['user_Message'];
                            });
                          }
                        }

                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xfffe6700),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text('Confirm',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),

                    //Resend
                    GestureDetector(
                      onTap: () async{
                        FocusScope.of(context).requestFocus(FocusNode());
                        setState(() {
                          _message = 'Resending ..';
                        });
                        var response = await util.sendVerificationMessage(widget.phoneNumber);

                        print('$response');
                        if(response['result']){
                          setState(() {
                            _message = 'An SMS sent to you';
                          });
                        } else {
                          _message = 'Error while resending a new SMS.';
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xfffe6700),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text('Resend',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
//                  ListTile(
//                    onTap: () async{
//
//                      Map response = await util.verifyPhone(phoneNumber, _verificationController.text);
//
//                      if(response['result']){
//                        Navigator.of(context).pop();
//                        _showRegistrationSuccessDialog(context, message: response['user_Message']);
//                      }
//                    },
//                    title: Container(
//                      decoration: BoxDecoration(
//                        color: Color(0xfffe6700),
//                        borderRadius: BorderRadius.circular(20),
//                      ),
//                      child: Padding(
//                        padding: const EdgeInsets.all(8.0),
//                        child: Text(
//                          'Confirm',
//                          textAlign: TextAlign.center,
//                        ),
//                      ),
//                    ),
//                  )
              ],
            ),
          ),
        ),
        Positioned(
          top: 0.0,
          right: 0.0,
          child: GestureDetector(
            onTap: (){
              Navigator.of(context).pop();
            },
              child: Icon(Icons.close)
          ),
        )
      ],
    );
  }
}