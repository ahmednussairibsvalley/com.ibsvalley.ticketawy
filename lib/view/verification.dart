import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import 'dashed_divider.dart';
import '../util.dart' as util;

/// Phone number verification dialog
class VerificationDialog extends StatefulWidget {

  /// The phone number
  final String phoneNumber;

  /// The user ID.
  final String id;

  /// The user password.
  final String password;

  /// Callback function for success.
  final Function(String, String, String) onSuccess;

  /// Will the verification dialog be
  /// used only for phone confirmation?
  final bool forJustPhoneConfirmation;

  VerificationDialog(
      {@required this.phoneNumber,
      this.password,
      this.id,
      @required this.onSuccess,
      this.forJustPhoneConfirmation = false});
  @override
  _VerificationDialogState createState() => _VerificationDialogState();
}

class _VerificationDialogState extends State<VerificationDialog> {

  /// Masked text controller for the code text field.
  final _verificationController = MaskedTextController(
    mask: '000000',
  );

  /// The appearing message under the code text field.
  String _message = '';

  /// Resending the SMS code?
  bool _resending = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        /// The verification dialog body.
        GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
            width: 300.0,
            height: 300.0,
            child: Column(
              children: <Widget>[

                // the first paragraph indicating of an SMS
                // message being sent
                Padding(
                  padding: const EdgeInsets.only(
                      top: 30, bottom: 8, left: 8, right: 8),
                  child: Text(
                    'An SMS sent to you with a verification code, '
                    'please enter the code and press confirm',
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

                // The code text field
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onTap: () {
                      setState(() {
                        _message = '';
                      });
                    },
                    onChanged: (value) {
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
                ),

                // The appearing message under
                // the code text field.
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: _message.isNotEmpty
                      ? Text(
                          _message,
                          textAlign: TextAlign.center,
                        )
                      : Padding(
                          padding: const EdgeInsets.all(5),
                        ),
                ),

                // The two buttons (confirm) and (resend).
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // Confirm
                    GestureDetector(
                      onTap: () async {
                        if (widget.forJustPhoneConfirmation) {
                          Map response = await util.confirmPasswordCode(
                              phoneNumber: widget.phoneNumber,
                              code: _verificationController.text);
                          if (response != null && response['result']) {
                            Navigator.of(context).pop();
                            widget.onSuccess(response['id'],
                                response['user_Message'], widget.password);
                          } else {
                            setState(() {
                              _message = response != null
                                  ? response['user_Message']
                                  : '';
                            });
                          }
                        } else {
                          Map response = await util.verifyPhone(
                              widget.phoneNumber, _verificationController.text);
                          if (response != null && response['result']) {
                            Navigator.of(context).pop();
                            widget.onSuccess(response['id'],
                                response['user_Message'], widget.password);
                          } else {
                            setState(() {
                              _message = response != null
                                  ? response['user_Message']
                                  : 'Error Confirming The Code';
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
                          child: Text(
                            'Confirm',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),

                    //Resend
                    GestureDetector(
                      onTap: () async {
                        if (!_resending) {
                          FocusScope.of(context).requestFocus(FocusNode());
                          setState(() {
                            _message = 'Resending ..';
                            _resending = true;
                          });
                          var response = await util
                              .sendVerificationMessage(widget.phoneNumber);

                          if (response != null && response['result']) {
                            setState(() {
                              _message = 'An SMS sent to you';
                              _resending = false;
                            });
                          } else {
                            setState(() {
                              _message = 'Error while resending a new SMS.';
                              _resending = false;
                            });
                          }
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: _resending ? Colors.grey : Color(0xfffe6700),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Resend',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        /// The top right closing icon
        Positioned(
          top: 0.0,
          right: 0.0,
          child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.close),
          ),
        )
      ],
    );
  }
}
